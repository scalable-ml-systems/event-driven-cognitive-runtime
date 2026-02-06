ADR‑0003: Replay Semantics
Context
Fraud investigations, audits, and model debugging require deterministic reconstruction of historical case timelines. Without explicit replay semantics, reprocessing events risks nondeterministic outcomes or side effects.

Decision
Replay becomes a first‑class system capability:

All events are idempotent.

All workflow steps are deterministic given the same inputs.

Side effects (e.g., external calls) are isolated behind replay‑aware boundaries.

A dedicated replay mode rehydrates state without triggering external actions.

Consequences
Positive:

Enables regulator‑grade audit trails.

Supports model debugging, counterfactuals, and forensics.

Simplifies recovery from corruption or partial failures.

Negative:

Requires strict separation of pure vs. impure operations.

Increases engineering discipline around state transitions.
