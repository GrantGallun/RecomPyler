# S55 per-region entry budget and steering request

No region projects below its recorded Python time in the conservative provisional conversion-only model. This is the S55.3 request boundary; product edits for Steps2/3 have not begun. A read/store-only design cannot be accepted on this table.

The model grants zero cost to both measured load and write-back, and excludes observer bookkeeping. All other measured components are retained unchanged. These are estimates to be confirmed, not a speedup, a mathematical lower bound or a performance prediction for an unbuilt lazy runtime. Timers remain inside the retained components; both source-identical passes overlapped peer correctness. Python times are the prior normal selection context, so comparison is a design budget check rather than a new deployment verdict.

## Current components (us per observed replay)

Each range is min–max of the two pass means. Native is dispatcher/body/boxing, not isolated machine work. Residual names all remaining exclusive phases in S46-TEN-BOUND.md.

| Region | Python | Load | WB | Guards | Unloader init | Lookup | Binding | Result | Native | Observer bookkeeping | Residual |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Chaosgame.transform_point | 6.90 | 39.96–43.48 | 3.95–4.22 | 9.91–10.44 | 4.78–4.89 | 3.92–4.39 | 7.15–7.39 | 7.86–8.03 | 3.69–4.22 | 33.36–36.62 | 10.60–10.80 |
| Spline.__call__ | 2.39 | 11.61–15.28 | 1.73–2.02 | 4.53–6.11 | 2.95–3.61 | 3.39–3.81 | 5.61–7.81 | 6.65–8.04 | 2.08–2.99 | 19.14–22.82 | 9.32–10.72 |
| create_cycle | 3.21 | 11.31–24.45 | 74.56–81.70 | 3.89–5.15 | 2.40–3.49 | 3.41–5.56 | 6.39–7.30 | 0.80–0.90 | 1.85–2.61 | 21.54–32.25 | 8.94–11.38 |
| Hex.link_nodes | 15.07 | 153.46–171.57 | 17.09–19.60 | 6.05–7.26 | 6.30–8.09 | 4.24–5.38 | 7.56–8.34 | 0.89–1.04 | 6.51–7.40 | 26.81–31.66 | 21.55–31.44 |
| Done.filter_tiles | 5.94 | 20.39–20.93 | 11.78–14.35 | 5.09–5.29 | 4.09–4.30 | 3.71–3.89 | 6.14–12.72 | 0.86–0.89 | 3.51–8.97 | 22.48–23.82 | 9.65–9.84 |
| schedule | 7.14 | 112.64–140.03 | 176.89–185.78 | 16.95–18.29 | 32.48–33.06 | 4.09–4.46 | 6.47–9.97 | 0.95–1.05 | 2.95–6.04 | 52.96–53.20 | 9.43–10.40 |
| Task.runTask | 10.22 | 262.11–292.65 | 66.96–79.10 | 45.66–49.84 | 52.51–63.74 | 17.01–18.07 | 8.57–9.22 | 2.67–3.09 | 5.26–5.64 | 66.35–71.34 | 15.33–17.38 |
| HandlerTask.fn | 12.81 | 423.50–478.30 | 60.26–69.12 | 25.29–25.95 | 53.16–58.76 | 12.26–12.96 | 8.70–8.93 | 2.55–2.76 | 4.91–5.28 | 62.60–66.34 | 14.77–15.27 |
| DeviceTask.fn | 13.78 | 301.14–331.20 | 69.36–74.00 | 24.70–24.74 | 60.62–62.41 | 7.84–9.01 | 9.15–10.59 | 2.71–2.88 | 4.65–5.53 | 79.45–90.86 | 15.11–15.40 |
| Task.qpkt | 59.54 | 231.41–330.43 | 47.36–48.66 | 33.90–44.81 | 50.17–57.50 | 14.19–20.00 | 7.96–10.41 | 2.66–3.09 | 4.31–6.58 | 54.29–68.90 | 14.43–19.80 |

## Provisional projected components (us)

Load/WB/observer are estimated at0. Every other entry below is explicitly unchanged from current cost; no unsupported discount is taken for moving code to C.

| Region | Load | WB | Guards | Unloader init | Lookup | Binding | Result | Native | Residual | Complete estimate | Below Python | Largest named remainder |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---|---|
| Chaosgame.transform_point | 0.00–0.00 | 0.00–0.00 | 9.91–10.44 | 4.78–4.89 | 3.92–4.39 | 7.15–7.39 | 7.86–8.03 | 3.69–4.22 | 10.60–10.80 | 47.91–50.15 | No | guards |
| Spline.__call__ | 0.00–0.00 | 0.00–0.00 | 4.53–6.11 | 2.95–3.61 | 3.39–3.81 | 5.61–7.81 | 6.65–8.04 | 2.08–2.99 | 9.32–10.72 | 34.52–43.10 | No | result |
| create_cycle | 0.00–0.00 | 0.00–0.00 | 3.89–5.15 | 2.40–3.49 | 3.41–5.56 | 6.39–7.30 | 0.80–0.90 | 1.85–2.61 | 8.94–11.38 | 27.68–36.39 | No | binding |
| Hex.link_nodes | 0.00–0.00 | 0.00–0.00 | 6.05–7.26 | 6.30–8.09 | 4.24–5.38 | 7.56–8.34 | 0.89–1.04 | 6.51–7.40 | 21.55–31.44 | 53.10–68.94 | No | staged_payload_copy |
| Done.filter_tiles | 0.00–0.00 | 0.00–0.00 | 5.09–5.29 | 4.09–4.30 | 3.71–3.89 | 6.14–12.72 | 0.86–0.89 | 3.51–8.97 | 9.65–9.84 | 33.22–45.73 | No | binding |
| schedule | 0.00–0.00 | 0.00–0.00 | 16.95–18.29 | 32.48–33.06 | 4.09–4.46 | 6.47–9.97 | 0.95–1.05 | 2.95–6.04 | 9.43–10.40 | 76.50–80.09 | No | unloader_init |
| Task.runTask | 0.00–0.00 | 0.00–0.00 | 45.66–49.84 | 52.51–63.74 | 17.01–18.07 | 8.57–9.22 | 2.67–3.09 | 5.26–5.64 | 15.33–17.38 | 147.40–166.60 | No | unloader_init |
| HandlerTask.fn | 0.00–0.00 | 0.00–0.00 | 25.29–25.95 | 53.16–58.76 | 12.26–12.96 | 8.70–8.93 | 2.55–2.76 | 4.91–5.28 | 14.77–15.27 | 122.37–129.19 | No | unloader_init |
| DeviceTask.fn | 0.00–0.00 | 0.00–0.00 | 24.70–24.74 | 60.62–62.41 | 7.84–9.01 | 9.15–10.59 | 2.71–2.88 | 4.65–5.53 | 15.11–15.40 | 127.30–128.04 | No | unloader_init |
| Task.qpkt | 0.00–0.00 | 0.00–0.00 | 33.90–44.81 | 50.17–57.50 | 14.19–20.00 | 7.96–10.41 | 2.66–3.09 | 4.31–6.58 | 14.43–19.80 | 127.63–162.19 | No | unloader_init |

## What needs to change

The next architecture must validate object layout, exact kinds and binding dependencies at first touch on the executed native path, with per-interval deduplication. It must not walk every reachable object just to discover a numeric field or to copy the whole loader map into an _Unloader. Returned original objects need a demand-built handle-to-owner map; fresh outputs need conversion only for the returned graph. Live numeric/topology reads must be guarded when accessed. A class/object version cache is not assumed sound: it needs a proven invalidation mechanism, and no raw cached address survives a call. Callback-free dict/field probes must refuse possible user comparison/descriptor hooks rather than invoke them under borrowed state. The initial full-graph C walk in DESIGN93 is therefore superseded for the intended performance architecture.

Program lookup is not merely a dictionary access. Source in heap.py::attempt tries latest guards/load and can then walk retained variants, checking cache membership/guards and attempting load before finding the selected specialization. Timed scopes exclude the nested load/guard time but retain resolver work, repeated branches and instrumentation. The actual counts below explain a structural difference from the trivial scalar/single-variant path; they do not causally attribute every microsecond. DeviceTask.fn has one load attempt yet9us lookup, so repeated variants alone do not explain all of other.

| Region | Load/guard attempts per call v7 | v8 | Lookup scoped entries v7/v8 |
|---|---|---|---|
| Chaosgame.transform_point | [1] / [1] | [1] / [1] | [4] / [4] |
| Spline.__call__ | [1] / [1] | [1] / [1] | [4] / [4] |
| create_cycle | [1] / [1] | [1] / [1] | [4] / [4] |
| Hex.link_nodes | [1] / [1] | [1] / [1] | [4] / [4] |
| Done.filter_tiles | [1] / [1] | [1] / [1] | [4] / [4] |
| schedule | [1] / [1] | [1] / [1] | [4] / [4] |
| Task.runTask | [1, 2, 3, 4] / [1, 2, 3, 4] | [1, 2, 3, 4] / [1, 2, 3, 4] | [4, 6] / [4, 6] |
| HandlerTask.fn | [1, 2] / [1, 2] | [1, 2] / [1, 2] | [4, 6] / [4, 6] |
| DeviceTask.fn | [1] / [1] | [1] / [1] | [4] / [4] |
| Task.qpkt | [1, 2, 3, 4] / [1, 2, 3, 4] | [1, 2, 3, 4] / [1, 2, 3, 4] | [4, 6] / [4, 6] |

Use a guarded shallow call/dependency decision tree to choose retained variants without speculative full-graph loads. A live nested discriminator is inspected only with exact callback-free layout proof. A first-touch miss before effects declines; a miss after speculative stores rolls back; after a committed interpreter-fallback segment it must deopt from a continuation rather than replay earlier effects. This is missing runtime/compiler work, not a reason to skip target regions.

Step4b only addresses the remaining boundary after demand-based work; its roughly2us measured scale cannot remove these retained tens/hundreds of microseconds. For every row, the largest remainder above therefore needs the Step2/3 entry/result-owner rework, not a claim that vectorcall will make it deploy. The revised lazy runtime has no measured per-touch budget yet; no region is declared projected-profitable on an invented C cost.

## Steering request

Per S55.3, do not activate the conversion-only design. Request steering on the next bounded item: build an independently reviewed, callback-free demand-based entry/result-owner prototype (first-touch layout/kind/binding checks, per-interval owner map, shallow retained-variant selector), establish its cost and exact fallback/observer behavior on the existing ten target inputs, and then rewrite the Step2/3 projections before activating direct payload access. No further ten-region component recorder pass is requested. The shared owner must also fix original method-source binding (CO_METHOD) before8of10 target summaries can authorize consumption; six executed positive method queries and the source comparison are in REQUESTS.md.

This is an explicit incomplete-work request, not DONE. Direct reads/stores, S53 buffer-member runtime/SOR acceptance, Step4b and final kernel/selection acceptance remain open. Independent preparatory tests/design and the conservative shared-layer merge do not close them.
