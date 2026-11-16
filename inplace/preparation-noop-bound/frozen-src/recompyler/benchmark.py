import os
from pathlib import Path
import statistics
from time import perf_counter
from typing import NamedTuple
import warnings


class BatchKernels(NamedTuple):
    serial: object
    parallel: object
    gpu: object


def compile_rows(function):
    """Compile one independent numeric row operation for three backends."""
    from numba import cuda, njit, prange

    cpu = njit(function, inline="always")
    device = cuda.jit(device=True, inline=True)(function)

    def host(rows, out, shared):
        for index in prange(len(rows)):
            out[index] = cpu(rows[index], shared)

    @cuda.jit
    def gpu(rows, out, shared):
        index = cuda.grid(1)
        if index < len(rows):
            out[index] = device(rows[index], shared)

    return BatchKernels(njit(host), njit(parallel=True)(host), gpu)


def advance_particle(row, shared):
    position, velocity, dt = row
    drag, gravity = shared[0]
    for _ in range(128):
        velocity += (gravity - drag * velocity) * dt
        position += velocity * dt
        if position < 0.0:
            position = -position
            velocity *= -0.7
    return position


def cuda_device():
    from numba import config, cuda
    from numba.cuda.cudadrv.error import CudaSupportError

    try:
        # Some Windows installations of the legacy CUDA backend miss the CUDA 13
        # toolkit's relocated NVVM DLL. Keep the compatibility fix process-local.
        if os.name == "nt" and os.environ.get("CUDA_PATH"):
            from numba.cuda.cudadrv.libs import get_cuda_paths

            paths = get_cuda_paths()
            nvvm = sorted((Path(os.environ["CUDA_PATH"]) / "nvvm" / "bin" / "x64").glob("nvvm64_*.dll"))
            if not paths["nvvm"].info and nvvm:
                major, minor = cuda.get_current_device().compute_capability
                paths["nvvm"] = paths["nvvm"]._replace(info=str(nvvm[-1]))
                os.environ.setdefault("NUMBA_FORCE_CUDA_CC", f"{major}.{minor}")
                config.reload_config()
        if not cuda.is_available():
            return None, "CUDA is unavailable. Check the NVIDIA driver and CUDA toolkit."
        name = cuda.get_current_device().name
    except (CudaSupportError, OSError) as exc:
        return None, f"CUDA could not initialize: {exc}"
    return name.decode() if isinstance(name, bytes) else str(name), None


def timing(run, repeats):
    measurements = []
    for _ in range(repeats):
        start = perf_counter()
        count = 0
        while True:
            run()
            count += 1
            elapsed = perf_counter() - start
            if elapsed >= 0.06:
                break
        measurements.append(elapsed * 1000 / count)
    return statistics.median(measurements)


def gpu_timings(kernel, rows, out, shared, expected, repeats):
    import numpy as np
    from numba import cuda
    from numba.core.errors import NumbaPerformanceWarning

    gpu_rows = cuda.to_device(rows)
    gpu_out = cuda.device_array_like(out)
    blocks = (len(rows) + 127) // 128

    def resident():
        kernel[blocks, 128](gpu_rows, gpu_out, shared)
        cuda.synchronize()

    def transfer():
        gpu_rows.copy_to_device(rows)
        kernel[blocks, 128](gpu_rows, gpu_out, shared)
        gpu_out.copy_to_host(out)

    with warnings.catch_warnings():
        warnings.simplefilter("ignore", NumbaPerformanceWarning)
        start = perf_counter()
        resident()
        first_call = perf_counter() - start
        np.testing.assert_allclose(gpu_out.copy_to_host(), expected, rtol=1e-12, atol=1e-12)
        transfer()
        np.testing.assert_allclose(out, expected, rtol=1e-12, atol=1e-12)
        return {"gpu_resident": timing(resident, repeats), "gpu_roundtrip": timing(transfer, repeats)}, first_call


def benchmark(sizes, repeats, cpu_only):
    os.environ.setdefault("OMP_WAIT_POLICY", "PASSIVE")
    import numpy as np
    from numba import config, cuda, set_num_threads
    from numba.core.errors import NumbaError
    from numba.cuda.cudadrv.driver import CudaAPIError, LinkerError
    from numba.cuda.cudadrv.error import CudaDriverError, CudaSupportError, NvvmError, NvvmSupportError

    cuda_errors = (CudaAPIError, CudaDriverError, CudaSupportError, LinkerError, NvvmError,
                   NvvmSupportError, NumbaError, OSError, RuntimeError)

    gpu_name, gpu_reason = (None, "CPU-only run requested.") if cpu_only else cuda_device()
    threads = min(4, config.NUMBA_NUM_THREADS)
    set_num_threads(threads)
    kernels = compile_rows(advance_particle)
    rng = np.random.default_rng(42)
    shared = (np.array([0.04, -9.81], dtype=np.float64),)
    gpu_shared = ()
    results, first_call = [], {}
    for size in sorted(set(sizes)):
        rows = rng.uniform([0, -4, 0.01], [4, 4, 0.02], size=(size, 3))
        reference_rows = rows.tolist()
        reference_constants = (tuple(shared[0].tolist()),)
        out = np.empty(size, dtype=np.float64)

        def python():
            return [advance_particle(row, reference_constants) for row in reference_rows]

        def serial():
            kernels.serial(rows, out, shared)

        def parallel():
            kernels.parallel(rows, out, shared)

        expected = python()
        runs = {"python": python, "cpu_serial": serial, "cpu_parallel": parallel}
        for name, run in (("cpu_serial", serial), ("cpu_parallel", parallel)):
            start = perf_counter()
            run()
            first_call.setdefault(name, perf_counter() - start)
            np.testing.assert_allclose(out, expected, rtol=1e-12, atol=1e-12)

        milliseconds = {name: timing(run, repeats) for name, run in runs.items()}
        if gpu_name:
            try:
                if not gpu_shared:
                    gpu_shared = tuple(cuda.to_device(array) for array in shared)
                gpu_ms, cold = gpu_timings(kernels.gpu, rows, out, gpu_shared, expected, repeats)
            except cuda_errors as exc:
                gpu_note = f"CUDA benchmark stopped ({type(exc).__name__}): {exc}"
                gpu_name, gpu_reason = None, gpu_note
                for row in results:
                    row["milliseconds"].pop("gpu_resident", None)
                    row["milliseconds"].pop("gpu_roundtrip", None)
                first_call.pop("gpu_resident", None)
            else:
                first_call.setdefault("gpu_resident", cold)
                milliseconds.update(gpu_ms)
        results.append({"batch": size, "verified": size, "milliseconds": milliseconds})
    return {"workload": "128-step particle trajectories", "cpu_threads": threads, "gpu": gpu_name,
            "gpu_note": gpu_reason, "repeats": repeats, "first_call_s": first_call, "timings": results}


def print_benchmark(report):
    print(f"{report['workload']} | CPU parallel uses {report['cpu_threads']} threads")
    print(report["gpu"] or report["gpu_note"])
    names = tuple(report["timings"][0]["milliseconds"])
    print(f"{'batch':>8} " + " ".join(f"{name:>15}" for name in names) + "  (ms per batch)")
    for row in report["timings"]:
        print(f"{row['batch']:>8,} " + " ".join(f"{row['milliseconds'][name]:>15.4f}" for name in names))
    print("Every measured backend matched the Python reference within 1e-12 relative and absolute tolerance.")
