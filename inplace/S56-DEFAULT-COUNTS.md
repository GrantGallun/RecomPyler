# Default-route report after the flat prototype

The private FlatLifted candidate is not installed in default routing. These are observed default-route counts, not a deployment or speed claim:

- Matrix:243native /773declined /0wrong /0crash,1016rows.
- Held-out:194captured /60verified and complete-native functions /375defined;35safe programs completed,0errors.
- Deployment selection was not run. Last accepted default selection remains2/33programs; no new deployment is attributed to the flat prototype.

Commands (below-normal, off-lock):

    python matrix/run_matrix.py --output inplace/s56-default-matrix.jsonl
    python inplace/flat-preparation/report_default_counts.py

Raw logs are inplace/s56-default-matrix.txt and inplace/s56-default-heldout.txt; held-out summary is inplace/s56-default-heldout/counts.json. The older peer report had59complete-native functions on its branch; this current60is not attributed to the inactive flat route. This report is a count, not an acceptance gate (S58).
