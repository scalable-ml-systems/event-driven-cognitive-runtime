ADR‑0005: DAG Contract and Execution
Context
Fraud cases require multi‑step reasoning: feature extraction, rules evaluation, LLM assessments, verification, and decision proposal. Without a formal execution model, workflows become ad‑hoc and brittle.

Decision
All case processing follows a deterministic DAG contract:

Each step is a single‑responsibility, idempotent task.

The orchestrator executes the DAG over Kafka events.

Steps declare inputs, outputs, deadlines, and retry semantics.

The DAG is versioned and immutable once deployed.

Consequences
Positive:

Predictable, reproducible workflows.

Clear separation of concerns across actors.

Easy to add, remove, or reorder steps via DAG versioning.

Negative:

Requires tooling to visualize, validate, and deploy DAGs.

Increases upfront design effort for new workflows.
