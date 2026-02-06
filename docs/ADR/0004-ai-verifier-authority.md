ADR‑0004: AI Verifier Authority
Context
LLM‑generated assessments introduce uncertainty. Fraud systems require a deterministic, defensible decision path. A verifier—human or automated—must validate AI outputs before they influence case outcomes.

Decision
The AI Verifier becomes the authoritative gatekeeper for all AI‑generated assessments.

LLM outputs are treated as proposals, not truth.

Verifier enforces policy, safety, and consistency.

Only verifier‑approved results advance the workflow.

Verifier decisions are logged as first‑class events.

Consequences
Positive:

Ensures defensibility and auditability of AI‑assisted decisions.

Prevents hallucinations from contaminating case state.

Enables ensemble arbitration and multi‑model cross‑checks.

Negative:

Adds latency to the decision pipeline.

Requires ongoing tuning of verifier rules and thresholds.
