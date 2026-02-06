# ADR-0002: Schema Governance

## Context
A Kafka-native, event-sourced system with many event types risks semantic drift without strict schema governance. Fraud investigation systems operate in regulated environments where event structure, meaning, and evolution must remain auditable and replayable over time.

## Decision
All events in the system are governed by a strict schema process:

- JSON Schema draft 2020-12 is the canonical schema format.
- Event payload schemas are versioned as `EventName.vX.schema.json`.
- All schemas begin at `v1`; versions increment only on breaking compatibility changes.
- Backward-compatible changes are permitted within a schema version.
- Breaking changes require a new schema version and an explicit migration strategy.
- A centralized schema registry (or equivalent enforcement mechanism) is the source of truth for all event schemas.

### Enforcement
- Producers MUST validate events against the registered schema before publishing.
- CI pipelines MUST enforce backward-compatibility checks for any schema change.
- Consumers MUST validate events before processing.

### Runtime Failure Policy
- Events failing schema validation MUST NOT be processed.
- Invalid events are routed to a DLQ with an explicit reason code.
- Invalid events are never silently dropped.

## Consequences

### Positive
- Prevents accidental breaking changes.
- Enables safe schema evolution over time.
- Guarantees replayability across historical event streams.
- Supports audit and regulatory review.

### Negative
- Slows rapid iteration.
- Requires tooling for schema validation and CI enforcement.
