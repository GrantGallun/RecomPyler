# Remaining native costs and generalizable numeric proofs

The user wants the tools used to identify and attack the remaining 5.21x Barnes–Hut/C gap, first understanding which Python constraints can be relaxed manually and then making their removal generalizable.

Start from current integration0aeb157 (producte35dce1), not earlier source. Existing uninstrumented 47.4893ms and separate diagnostic27.4435ms native/12.7478ms load+write-back are evidence for hypotheses, not an additive causal decomposition. The C9.1083ms whole workload includes C final energy; native-entry time alone is not a matched C-body comparison.

Produce controlled fresh measurements using explicit saved-source/plan/artifact hashes and real execution modes. Compare the unchanged current workload with limited step grouping, internal force-zero normalization and a declared float-only numeric contract. All cases perform100 advances with the same inputs and include final energy in the original kernel boundary. Preserve raw samples and compare numeric bits, types and alias/shape observations separately. Type-contract changes must never be presented as equivalent arbitrary Python optimization.

Grouped regions retain transient trees in the bump arena; record capacity/high-water/retries, and do not label the difference pure boundary overhead. Do not reset arena memory without a real escape/lifetime proof. Existing constructor initialization escape checks are insufficient.

Propose a bounded compiler proof rule supported by the experiment and source analysis. The leading candidate is zero-or-float facts for recursive helper returns/accumulators: preserve numeric tags where observable, while proving integer-range checks redundant when the integer case can only be zero. Unknown/nonzero integer sources must invalidate the proof. Field refinement additionally needs input guards and alias/write validity. No blanket fast-math, float coercion, layout assumption or name-specific production optimization.

Historical evidence and the user's working checkout remain untouched. Serialize heavy compilation/timing. Build only the selected bounded production rule if its implementation/proof is concrete and sound; otherwise deliver the measured experiment and explicit implementation design rather than shipping unsafe assumptions.
