import json
from pathlib import Path
import sys


def positive(value):
    number = int(value)
    if number < 1:
        import argparse

        raise argparse.ArgumentTypeError("must be positive")
    return number


def quick_run(argv):
    """The arguments of a plain ``run`` command line (``run [--plan P] [--json J]
    [--force] script args...``), or None for anything else, which argparse parses.
    Building the full parser loads modules a script that compiles nothing would
    otherwise not pay for."""
    if argv[:1] != ["run"]:
        return None
    options, at = {"plan": None, "json": None, "force": False}, 1
    while at < len(argv) and argv[at].startswith("-"):
        flag = argv[at]
        if flag == "--force":
            options["force"] = True
            at += 1
        elif flag in ("--plan", "--json") and at + 1 < len(argv) and not argv[at + 1].startswith("-"):
            options[flag[2:]] = argv[at + 1]
            at += 2
        else:
            return None
    if at >= len(argv) or options["plan"] is None:
        return None
    forwarded = argv[at + 1:]
    return argparse_free(command="run", plan=Path(options["plan"]), json=options["json"] and Path(options["json"]),
                         force=options["force"], script=Path(argv[at]),
                         script_args=forwarded[1:] if forwarded[:1] == ["--"] else forwarded)


class argparse_free:
    def __init__(self, **values):
        self.__dict__.update(values)


def run_main(args):
    from .runner import print_run, run_script

    script = args.script.resolve()
    if not script.is_file():
        return None
    if not args.plan.is_file():
        return None
    if args.json:
        args.json = args.json.resolve()
    report = run_script(script, args.script_args, args.plan.resolve(), args.force)
    print_run(report)
    if args.json:
        try:
            args.json.write_text(json.dumps(report, indent=2, allow_nan=False) + "\n", encoding="utf-8")
        except OSError as exc:
            print(f"recompyler: could not write report: {exc}", file=sys.stderr)
            return 2
    if report["exit_code"] not in (None, 0):
        return report["exit_code"] if isinstance(report["exit_code"], int) else 1
    return 0


def main(argv=None):
    quick = quick_run(sys.argv[1:] if argv is None else list(argv))
    if quick is not None:
        status = run_main(quick)
        if status is not None:
            return status
    import argparse

    parser = argparse.ArgumentParser(prog="recompyler", description="Profile Python and test verified speedups.")
    commands = parser.add_subparsers(dest="command", required=True)
    profile = commands.add_parser("profile", help="run a Python script and report its hotspots")
    profile.add_argument("--json", type=Path, help="also save the report as JSON")
    profile.add_argument("--format", choices=("text", "compact"), default="text",
                         help="emit a human-readable report or versioned compact JSON")
    profile.add_argument("--limit", type=positive, default=128,
                         help="compiler-attempt ceiling (default: 128); hotspot count with --no-compile")
    profile.add_argument("--samples", type=positive, default=64, help="maximum captured calls per helper")
    profile.add_argument("--no-compile", action="store_true", help="only profile the script")
    profile.add_argument("--include", type=Path, action="append", default=[], metavar="PATH",
                         help="also time functions in this file or folder (repeatable)")
    profile.add_argument("--types", action="append", default=[], metavar="SOURCE=TYPE[,TYPE]",
                         help="number types an input can select, e.g. args.exact=int,float; "
                              "those variants are checked and built too (repeatable)")
    profile.add_argument("script", type=Path)
    profile.add_argument("script_args", nargs=argparse.REMAINDER)
    deps = commands.add_parser("map", help="show a script's call graph, regions and what depends on its inputs")
    deps.add_argument("--plan", type=Path, help="a JSON report from recompyler profile, for calls and times")
    deps.add_argument("--json", type=Path, help="also save the map as JSON")
    deps.add_argument("script", type=Path)
    run = commands.add_parser("run", help="run a script with the compiled versions a profile recommended")
    run.add_argument("--plan", type=Path, help="a JSON report from recompyler profile")
    run.add_argument("--cache-dir", type=Path, help="library decision and native artifact cache")
    run.add_argument("--library-package", action="append", default=[], help="limit opt-in imports to this package (repeatable)")
    run.add_argument("--library-profile", action="store_true", help="count library calls without retaining arguments")
    run.add_argument("--json", type=Path, help="also save the call counts as JSON")
    run.add_argument("--force", action="store_true",
                     help="use the recommended functions even if loading the compiler costs more than they save")
    run.add_argument("script", type=Path)
    run.add_argument("script_args", nargs=argparse.REMAINDER)
    aot = commands.add_parser("compile", help="prepare native artifacts for loaded package definitions")
    aot.add_argument("--cache-dir", type=Path)
    aot.add_argument("--json", type=Path)
    aot.add_argument("--budget", type=positive, default=120)
    aot.add_argument("package")
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
        forwarded = args.script_args[1:] if args.script_args[:1] == ["--"] else args.script_args
        if args.plan is None:
            if args.force: parser.error('--force requires --plan')
            if args.json and (args.json==script or args.json.exists() and args.json.samefile(script)):
                parser.error('the report path must differ from the script path')
            from .libraries.cli import run_script as run_library_script, ensure_entry_backend
            if argv is None: ensure_entry_backend()
            report=run_library_script(script,forwarded,cache_dir=args.cache_dir,
                                      packages=args.library_package,profile=args.library_profile,restore=False)
        else:
            if not args.plan.is_file(): parser.error(f"plan does not exist: {args.plan}")
            report = run_script(script, forwarded, args.plan.resolve(), args.force)
            print_run(report)
    elif args.command == "compile":
        import importlib.util
        if args.json:
            spec=importlib.util.find_spec(args.package)
            if spec and spec.origin and Path(spec.origin).is_file():
                source=Path(spec.origin).resolve()
                if args.json==source or args.json.exists() and args.json.samefile(source):
                    parser.error('the report path must differ from the package source')
        from .libraries.cli import compile_package
        report=compile_package(args.package,cache_dir=args.cache_dir,budget=args.budget)
        if args.json:
            for filename in report['source_files']:
                source=Path(filename)
                if args.json==source or args.json.exists() and source.exists() and args.json.samefile(source):
                    parser.error('the report path must differ from package source files')
        print(f"recompyler: prepared {report['prepared']}/{report['total']}, portable {report['portable']}, installed {report['installed']}",file=sys.stderr)
    elif args.command == "map":
        from .depmap import main_map

        script = args.script.resolve()
        if not script.is_file():
            parser.error(f"script does not exist: {script}")
        main_map(script, args.plan, args.json)
        return 0
    elif args.command == "profile":
        from .profiler import profile_script, print_profile
        from .variants import parse, print_variants

        try:
            declared = parse(args.types)
        except ValueError as exc:
            parser.error(str(exc))

        script = args.script.resolve()
        if not script.is_file():
            parser.error(f"script does not exist: {script}")
        if args.json and (args.json == script or (args.json.exists() and args.json.samefile(script))):
            parser.error("the report path must differ from the script path")
        forwarded = args.script_args
        if forwarded[:1] == ["--"]:
            forwarded = forwarded[1:]
        report = profile_script(script, forwarded, args.limit, args.samples, not args.no_compile,
                                [path.resolve() for path in args.include], declared)
        if compact:
            from .report import compact_profile

            report = compact_profile(report)
            print(json.dumps(report, separators=(",", ":"), allow_nan=False), file=sys.stderr)
        else:
            print_profile(report)
            print_variants(report.get("declared"), sys.stderr)
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
    if args.command == 'run' and args.plan is None:
        if report.get('exit_message') is not None: print(report['exit_message'],file=sys.stderr)
        return report['exit_code'] if report['exit_code'] is not None else 0
    if args.command == "run" and report["exit_code"] not in (None, 0):
        return report["exit_code"] if isinstance(report["exit_code"], int) else 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
