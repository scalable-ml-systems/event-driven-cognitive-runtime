ADR‑0001: Kafka Ledger as Source of Truth
Context
Fraud decisioning requires a durable, append‑only, regulator‑friendly record of every state transition. Traditional databases struggle to provide immutable history, replay, and cross‑service consistency. The system needs a single, authoritative event log that all downstream consumers can trust.

Decision
Kafka becomes the system‑of‑record for all fraud case events. Every state transition is emitted as an immutable event. Services derive their local state from the event stream rather than treating their own storage as authoritative.

Consequences
Positive:

Full auditability and replayability.

Deterministic reconstruction of case state at any point in time.

Loose coupling between services; consumers subscribe to events they need.

Negative:

Requires strict schema governance and versioning.

Operational complexity increases (retention, compaction, DLQs).

Local stores must be treated as materialized views, not truth.
