import argparse
import json
from pathlib import Path
import sys


def positive(value):
    number = int(value)
    if number < 1:
        raise argparse.ArgumentTypeError("must be positive")
    return number


def main(argv=None):
    parser = argparse.ArgumentParser(prog="recompyler", description="Profile Python and test verified speedups.")
    commands = parser.add_subparsers(dest="command", required=True)
    profile = commands.add_parser("profile", help="run a Python script and report its hotspots")
    profile.add_argument("--json", type=Path, help="also save the report as JSON")
    profile.add_argument("--format", choices=("text", "compact"), default="text",
                         help="emit a human-readable report or versioned compact JSON")
    profile.add_argument("--limit", type=positive, default=10, help="number of hotspots to show")
    profile.add_argument("--samples", type=positive, default=64, help="maximum captured calls per helper")
    profile.add_argument("--no-compile", action="store_true", help="only profile the script")
    profile.add_argument("--include", type=Path, action="append", default=[], metavar="PATH",
                         help="also time functions in this file or folder (repeatable)")
    profile.add_argument("script", type=Path)
    profile.add_argument("script_args", nargs=argparse.REMAINDER)
    run = commands.add_parser("run", help="run a script with the compiled versions a profile recommended")
    run.add_argument("--plan", type=Path, required=True, help="a JSON report from recompyler profile")
    run.add_argument("--json", type=Path, help="also save the call counts as JSON")
    run.add_argument("--force", action="store_true",
                     help="use the recommended functions even if loading the compiler costs more than they save")
    run.add_argument("script", type=Path)
    run.add_argument("script_args", nargs=argparse.REMAINDER)
    bench = commands.add_parser("benchmark", help="compare CPU and CUDA on a particle simulation")
    bench.add_argument("--json", type=Path, help="also save the results as JSON")
    bench.add_argument("--sizes", nargs="+", type=positive, default=[32, 512, 4096, 32768])
    bench.add_argument("--repeats", type=positive, default=3)
    bench.add_argument("--cpu-only", action="store_true")
    args = parser.parse_args(argv)
    if args.json:
        args.json = args.json.resolve()

    compact = args.command == "profile" and args.format == "compact"
    if args.command == "run":
        from .runner import print_run, run_script

        script = args.script.resolve()
        if not script.is_file():
            parser.error(f"script does not exist: {script}")
        if not args.plan.is_file():
            parser.error(f"plan does not exist: {args.plan}")
        forwarded = args.script_args[1:] if args.script_args[:1] == ["--"] else args.script_args
        report = run_script(script, forwarded, args.plan.resolve(), args.force)
        print_run(report)
    elif args.command == "profile":
        from .profiler import profile_script, print_profile

        script = args.script.resolve()
        if not script.is_file():
            parser.error(f"script does not exist: {script}")
        if args.json and (args.json == script or (args.json.exists() and args.json.samefile(script))):
            parser.error("the report path must differ from the script path")
        forwarded = args.script_args
        if forwarded[:1] == ["--"]:
            forwarded = forwarded[1:]
        report = profile_script(script, forwarded, args.limit, args.samples, not args.no_compile,
                                [path.resolve() for path in args.include])
        if compact:
            from .report import compact_profile

            report = compact_profile(report)
            print(json.dumps(report, separators=(",", ":"), allow_nan=False), file=sys.stderr)
        else:
            print_profile(report)
    else:
        from .benchmark import benchmark, print_benchmark

        try:
            report = benchmark(args.sizes, args.repeats, args.cpu_only)
        except ImportError:
            parser.error('the benchmark requires the optional dependencies. Install with pip install ".[compile]"')
        print_benchmark(report)

    if args.json:
        try:
            args.json.write_text(json.dumps(report, indent=None if compact else 2,
                                            separators=(",", ":") if compact else None, allow_nan=False) + "\n",
                                 encoding="utf-8")
        except OSError as exc:
            parser.error(f"could not write report: {exc}")
    if args.command == "run" and report["exit_code"] not in (None, 0):
        return report["exit_code"] if isinstance(report["exit_code"], int) else 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
