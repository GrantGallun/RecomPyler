"""S23 ranking regressions through profile_script; no real sampling or compilation.

The fake monitor supplies already measured records. Candidate compilation is the
expensive boundary replaced here; argument forwarding, ranking, coverage,
reporting and CLI parsing remain production behavior.
"""
import importlib
import re
from types import FunctionType, SimpleNamespace

import pytest

from recompyler import profiler


def _identity(value):
    return value


def _entry(name, own, inclusive, *, library=False, capture="ready"):
    return dict(name=name, own=own, inclusive=inclusive,
                library=library, capture=capture)


@pytest.fixture
def profile_records(monkeypatch, tmp_path):
    script = tmp_path / "program.py"
    script.write_text("pass\n", encoding="utf-8")

    def run(entries, *, limit=128, try_compile=True, compiler_available=True, candidate_result=None):
        records = []
        samplers = {}
        skipped = {}
        attempted = []
        for index, entry in enumerate(entries):
            filename = str(tmp_path / "library" / (entry["name"] + ".py")) if entry["library"] else str(script)
            key = (filename, entry["name"], index + 1)
            records.append(dict(
                function=entry["name"], qualname=entry["name"], file=filename,
                line=index + 1, calls=2, self_s=entry["own"],
                cumulative_s=entry["inclusive"], library_s=0.0, _key=key,
            ))
            if entry["capture"] == "missing":
                skipped[key] = "not a module-level function or a method"
                continue
            function = FunctionType(_identity.__code__, {}, entry["name"])
            function.__qualname__ = entry["name"]
            samples = [((1,), 1, (1,))] if entry["capture"] == "ready" else []
            samplers[key] = SimpleNamespace(
                function=function, samples=samples, signatures={("int",): 2},
                list_reuse=0.0, generator=False, extra=lambda: (),
                declines={"too large to capture": 2} if not samples else {},
            )

        class Monitor:
            backend = "synthetic"
            total_s = 1_000_000.0

            def __init__(self, watches, sample_limit, copier, **options):
                self.samplers = samplers if sample_limit else {}
                self.skipped = skipped
                self.sample_limit = sample_limit

            def __enter__(self):
                return self

            def __exit__(self, *exc):
                return False

            def rows(self):
                # Real monitor.rows returns new row dicts; profile_script pops _key.
                return [dict(row) for row in records]

        def candidate(function, inputs, calls, list_reuse=0.0, extra=(), cumulative_s=None):
            attempted.append(dict(name=function.__name__, inputs=inputs,
                                  calls=calls, cumulative_s=cumulative_s))
            return (dict(candidate_result) if candidate_result is not None
                    else dict(status="skipped", reason="synthetic unsupported body"))

        find_spec = importlib.util.find_spec
        monkeypatch.setattr(profiler, "CallMonitor", Monitor)
        monkeypatch.setattr(profiler, "test_candidate", candidate)
        monkeypatch.setattr(
            profiler.importlib.util, "find_spec",
            lambda name, *a, **kw: (object() if compiler_available else None)
            if name == "numba" else find_spec(name, *a, **kw),
        )
        report = profiler.profile_script(script, [], limit, 8, try_compile)
        return report, attempted

    return run


def _names(report):
    return [row["function"] for row in report["functions"]]


def test_inclusive_hot_script_caller_survives_forty_higher_self_library_rows(profile_records):
    """Old self-first top40 loses the caller; inclusive priority must attempt it."""
    entries = [_entry(f"library_{n:02d}", 2.0, 2.0, library=True) for n in range(40)]
    entries.append(_entry("hot_script_caller", 1.0, 100.0))
    report, attempts = profile_records(entries, limit=40)
    assert _names(report)[0] == "hot_script_caller"
    assert attempts[0]["name"] == "hot_script_caller"
    assert len(attempts) == 40
    assert report["candidate_ranking"]["stop_reason"] == "hard_limit"
    assert report["candidate_ranking"]["replayable_coverage"] == pytest.approx(79 / 81)


def test_uncaptured_module_prefix_cannot_consume_compiler_slots(profile_records):
    entries = [_entry(f"module_{n:02d}", 1000.0, 2000.0,
                      library=True, capture="missing") for n in range(40)]
    entries += [_entry("hot_script_caller", 1.0, 100.0),
                _entry("other_replayable", 1.0, 50.0)]
    report, attempts = profile_records(entries, limit=1)
    assert _names(report) == ["hot_script_caller"]
    assert [row["name"] for row in attempts] == ["hot_script_caller"]
    ranking = report["candidate_ranking"]
    assert ranking["attempted_candidates"] == 1
    assert ranking["observed_positive_self_s"] == pytest.approx(40002.0)
    assert ranking["replayable_positive_self_s"] == pytest.approx(2.0)
    assert ranking["selected_positive_self_s"] == pytest.approx(1.0)
    assert ranking["replayable_coverage"] == pytest.approx(0.5)
    assert ranking["all_observed_coverage"] == pytest.approx(1 / 40002)
    diagnostics = report["uncaptured_hotspots"]
    assert len(diagnostics) == 10
    assert all(row["capture_reason"] == "not a module-level function or a method"
               for row in diagnostics)


def test_empty_sampler_is_not_a_replayable_candidate(profile_records):
    entries = [_entry("oversized", 100.0, 500.0, capture="empty"),
               _entry("replayable", 2.0, 10.0)]
    report, attempts = profile_records(entries, limit=1)
    assert _names(report) == ["replayable"]
    assert [row["name"] for row in attempts] == ["replayable"]
    ranking = report["candidate_ranking"]
    assert ranking["replayable_positive_self_s"] == pytest.approx(2.0)
    assert ranking["replayable_coverage"] == pytest.approx(1.0)
    assert ranking["all_observed_coverage"] == pytest.approx(2 / 102)
    assert report["uncaptured_hotspots"][0]["capture_reason"] == "too large to capture"


def test_coverage_credits_disjoint_self_instead_of_inclusive_envelopes(profile_records):
    # Parent inclusive=100 overlaps child inclusive=98. Only 1+98 self is credited.
    entries = [_entry("parent", 1.0, 100.0),
               _entry("child", 98.0, 98.0),
               _entry("tail", 1.0, 1.0)]
    report, attempts = profile_records(entries)
    assert _names(report) == ["parent", "child"]
    assert [row["name"] for row in attempts] == ["parent", "child"]
    ranking = report["candidate_ranking"]
    assert ranking["priority"] == "cumulative_s"
    assert ranking["target_fraction"] == pytest.approx(0.99)
    assert ranking["hard_limit"] == 128
    assert ranking["attempted_candidates"] == 2
    assert ranking["observed_positive_self_s"] == pytest.approx(100.0)
    assert ranking["replayable_positive_self_s"] == pytest.approx(100.0)
    assert ranking["selected_positive_self_s"] == pytest.approx(99.0)
    assert ranking["replayable_coverage"] == pytest.approx(0.99)
    assert ranking["all_observed_coverage"] == pytest.approx(0.99)
    assert ranking["stop_reason"] == "target_reached"


def test_explicit_candidate_ceiling_reports_uncovered_replayable_mass(profile_records):
    entries = [_entry("outer", 10.0, 100.0),
               _entry("middle", 1.0, 90.0),
               _entry("leaf", 89.0, 89.0)]
    report, attempts = profile_records(entries, limit=2)
    assert _names(report) == ["outer", "middle"]
    assert len(attempts) == 2
    ranking = report["candidate_ranking"]
    assert ranking["hard_limit"] == 2
    assert ranking["selected_positive_self_s"] == pytest.approx(11.0)
    assert ranking["replayable_coverage"] == pytest.approx(0.11)
    assert ranking["stop_reason"] == "hard_limit"


def test_zero_and_negative_self_use_bounded_priority_without_fake_coverage(profile_records):
    entries = [_entry("zero", 0.0, 100.0),
               _entry("negative", -1.0, 50.0),
               _entry("also_zero", 0.0, 25.0)]
    report, attempts = profile_records(entries, limit=2)
    assert _names(report) == ["zero", "negative"]
    assert len(attempts) == 2
    ranking = report["candidate_ranking"]
    assert ranking["observed_positive_self_s"] == 0.0
    assert ranking["replayable_positive_self_s"] == 0.0
    assert ranking["selected_positive_self_s"] == 0.0
    assert ranking["replayable_coverage"] is None
    assert ranking["all_observed_coverage"] is None
    assert ranking["stop_reason"] == "hard_limit"


def test_zero_mass_stops_on_eligible_exhaustion_before_large_ceiling(profile_records):
    report, attempts = profile_records(
        [_entry("negative", -1.0, 1.0), _entry("zero", 0.0, 2.0)], limit=128,
    )
    assert _names(report) == ["zero", "negative"]
    assert len(attempts) == 2
    ranking = report["candidate_ranking"]
    assert ranking["attempted_candidates"] == 2
    assert ranking["replayable_coverage"] is None
    assert ranking["all_observed_coverage"] is None
    assert ranking["stop_reason"] == "eligible_exhausted"


def test_no_replayable_samples_do_not_claim_successful_time_coverage(profile_records):
    report, attempts = profile_records(
        [_entry("module", 100.0, 100.0, capture="missing")],
    )
    assert _names(report) == []
    assert attempts == []
    ranking = report["candidate_ranking"]
    assert ranking["attempted_candidates"] == 0
    assert ranking["replayable_coverage"] is None
    assert ranking["all_observed_coverage"] == 0.0
    assert ranking["stop_reason"] == "eligible_exhausted"
    assert report["uncaptured_hotspots"][0]["function"] == "module"


def test_flat_self_hotter_than_every_competitor_remains_first(profile_records):
    # Existing correct behavior: no claim that old self ordering itself was broken.
    entries = [_entry(f"cold_{n}", 1.0, 1.0, library=True) for n in range(40)]
    entries.append(_entry("hot", 50.0, 50.0))
    report, attempts = profile_records(entries, limit=1)
    assert _names(report) == ["hot"]
    assert attempts[0]["name"] == "hot"


def test_cumulative_tie_uses_measured_self_without_origin_priority(profile_records):
    entries = [_entry("script", 1.0, 10.0),
               _entry("library", 9.0, 10.0, library=True)]
    report, attempts = profile_records(entries, limit=1)
    assert _names(report) == ["library"]
    assert attempts[0]["name"] == "library"


def test_candidate_keeps_original_call_count_samples_and_cumulative_gate_input(profile_records):
    report, attempts = profile_records([_entry("caller", 1.0, 100.0)])
    assert _names(report) == ["caller"]
    assert attempts == [dict(name="caller", inputs=[((1,), 1, (1,))],
                             calls=2, cumulative_s=100.0)]


@pytest.mark.parametrize(
    "try_compile,compiler_available,reason,stop",
    [(False, True, "profiling only", "profiling_only"),
     (True, False, "install the compile extra", "compiler_unavailable")],
)
def test_without_compilation_normal_inclusive_hotspots_are_retained(
    profile_records, try_compile, compiler_available, reason, stop,
):
    report, attempts = profile_records(
        [_entry("self_heavy", 20.0, 20.0),
         _entry("inclusive_hot", 1.0, 100.0, capture="missing")],
        limit=2, try_compile=try_compile, compiler_available=compiler_available,
    )
    assert _names(report) == ["inclusive_hot", "self_heavy"]
    assert attempts == []
    assert all(row["candidate"]["status"] == "skipped" for row in report["functions"])
    assert all(reason in row["candidate"]["reason"] for row in report["functions"])
    ranking = report["candidate_ranking"]
    assert ranking["attempted_candidates"] == 0
    assert ranking["stop_reason"] == stop


@pytest.mark.parametrize("options,expected", [([], 128), (["--limit", "3"], 3)])
def test_cli_uses_default_ceiling_or_explicit_override(monkeypatch, tmp_path, options, expected):
    from recompyler import __main__ as cli
    script = tmp_path / "program.py"
    script.write_text("pass\n", encoding="utf-8")
    received = []

    def profile(script, arguments, limit, samples, try_compile, include=(), declared=None):
        received.append((script, arguments, limit, try_compile))
        return dict(script=str(script), functions=[])

    monkeypatch.setattr(profiler, "profile_script", profile)
    monkeypatch.setattr(profiler, "print_profile", lambda report: None)
    assert cli.main(["profile", *options, "--no-compile", str(script)]) == 0
    assert received == [(script.resolve(), [], expected, False)]

def _verified_not_recommended():
    """Complete normal candidate record; it must not cause an AOT build."""
    return dict(
        status="verified", engine="region", samples=1, compiled_samples=1,
        fallback_samples=0, rare_samples_checked=0, recommended=False,
        recommendation="cold start exceeds savings",
        net_s_first_run=-0.020, net_s_cached=-0.001,
        first_pass_s=0.030, warm_start_s=0.002,
        python_us_per_call=10.0, compiled_cpu_us_per_call=2.0, speedup=5.0,
        changes_arguments=False, disk_cached=True,
        batch_backends={}, backend_note="not batched: one region",
        batch_speedup=None, batch_size=1, best_backend=None,
    )


def _output_report():
    # Literal values make the two coverage denominators visibly different.
    return dict(
        script="/fixture/program.py",
        functions=[dict(function="hot_caller", line=7, calls=2,
                        self_s=0.25, cumulative_s=1.0,
                        candidate=_verified_not_recommended())],
        candidate_ranking=dict(
            priority="cumulative_s", target_fraction=0.99, hard_limit=2,
            attempted_candidates=1, observed_positive_self_s=1.0,
            replayable_positive_self_s=0.5, selected_positive_self_s=0.25,
            replayable_coverage=0.5, all_observed_coverage=0.25,
            stop_reason="hard_limit",
        ),
        uncaptured_hotspots=[
            dict(function=f"uncaptured_{n:02d}", file="/fixture/library.py",
                 line=n + 1, self_s=0.01, cumulative_s=0.1,
                 capture_reason="snapshot rule: custom copy hook")
            for n in range(12)
        ],
    )


def test_verified_not_recommended_candidate_is_preserved_without_native_build(
    profile_records, monkeypatch,
):
    def no_build(*args, **kwargs):
        raise AssertionError("an unprofitable candidate must not be built")

    monkeypatch.setattr(profiler, "build_ahead_of_time", no_build)
    monkeypatch.setattr(profiler, "build_regions_ahead_of_time", no_build)
    candidate = _verified_not_recommended()
    report, attempts = profile_records(
        [_entry("caller", 1.0, 100.0)], candidate_result=candidate,
    )
    assert report["functions"][0]["candidate"] == candidate
    assert [row["name"] for row in attempts] == ["caller"]
    assert "plan" not in report


def test_text_report_exposes_both_coverage_denominators_ceiling_and_declines(capsys):
    profiler.print_profile(_output_report())
    printed = capsys.readouterr()
    assert printed.out == ""
    text = printed.err
    assert "cumulative_s" in text and "1/2" in text and "99.0%" in text
    assert re.search(r"(?:replayable\s*[:=]?\s*50\.0%|50\.0%\s+(?:of\s+)?replayable)", text)
    assert re.search(r"(?:all[- ]observed\s*[:=]?\s*25\.0%|25\.0%\s+(?:of\s+)?all[- ]observed)", text)
    assert re.search(r"hard[-_ ]limit", text.lower())
    assert "uncaptured_00" in text and "uncaptured_09" in text
    assert "snapshot rule: custom copy hook" in text
    assert "uncaptured_10" not in text and "uncaptured_11" not in text
    assert "Not recommended" in text and "cold start exceeds savings" in text


def test_text_zero_positive_mass_is_unknown_not_zero_or_full_coverage(capsys):
    report = _output_report()
    report["candidate_ranking"].update(
        observed_positive_self_s=0.0, replayable_positive_self_s=0.0,
        selected_positive_self_s=0.0, replayable_coverage=None,
        all_observed_coverage=None, stop_reason="eligible_exhausted",
    )
    profiler.print_profile(report)
    text = capsys.readouterr().err
    assert "unknown" in text.lower()
    assert "100.0%" not in text and "0.0%" not in text
    assert re.search(r"eligible[-_ ]exhausted", text.lower())


def test_compact_report_retains_ranking_and_bounded_decline_reasons():
    from recompyler.report import compact_profile

    report = _output_report()
    report["uncaptured_hotspots"][0]["capture_reason"] = "snapshot decline: " + "x" * 200
    compact = compact_profile(report)
    assert compact["schema"] == "recompyler.profile.v1"
    assert compact["candidate_ranking"] == report["candidate_ranking"]
    diagnostics = compact["uncaptured_hotspots"]
    assert len(diagnostics) == 10
    assert [row["function"] for row in diagnostics] == [
        "uncaptured_00", "uncaptured_01", "uncaptured_02", "uncaptured_03",
        "uncaptured_04", "uncaptured_05", "uncaptured_06", "uncaptured_07",
        "uncaptured_08", "uncaptured_09",
    ]
    assert diagnostics[0]["capture_reason"] == report["uncaptured_hotspots"][0]["capture_reason"][:160]
    assert diagnostics[1]["capture_reason"] == "snapshot rule: custom copy hook"
    assert diagnostics[0]["file"] == "/fixture/library.py"
    assert diagnostics[0]["line"] == 1
    assert diagnostics[0]["self_s"] == 0.01 and diagnostics[0]["cumulative_s"] == 0.1
    assert compact["hotspots"][0]["recommended"] is False
    assert compact["hotspots"][0]["recommendation"] == "cold start exceeds savings"
    # Rendering may not truncate or otherwise mutate the raw report in place.
    assert len(report["uncaptured_hotspots"]) == 12
    assert len(report["uncaptured_hotspots"][0]["capture_reason"]) > 160


def test_compact_report_preserves_unknown_zero_mass_fractions():
    from recompyler.report import compact_profile

    report = _output_report()
    report["candidate_ranking"].update(
        observed_positive_self_s=0.0, replayable_positive_self_s=0.0,
        selected_positive_self_s=0.0, replayable_coverage=None,
        all_observed_coverage=None, stop_reason="eligible_exhausted",
    )
    compact = compact_profile(report)
    assert compact["candidate_ranking"]["replayable_coverage"] is None
    assert compact["candidate_ranking"]["all_observed_coverage"] is None
    assert compact["candidate_ranking"]["stop_reason"] == "eligible_exhausted"