# Topics 

## System of Record
- fraud.case.ledger  (partition key: case_id)

## Operational/Optional (if used later)
- fraud.case.dlq

## Rules
- Ledger events are immutable facts.
- Producers validate envelope + payload schema before publish.
- Consumers validate before process; invalid → DLQ with reason code.
- Replay reads ledger and rebuilds projections/dossiers deterministically.

## Topic Categories

### Fact Topics
- Represent immutable facts.
- Fully replayable.
- Used to rebuild projections and dossiers.
- Example:
  - fraud.case.ledger

### Command Topics (if introduced)
- Represent intent, not fact.
- Not replayed.
- Used for orchestration only.

### Internal / Operational Topics
- Used for retries, DLQs, metrics.
- Never treated as source of truth.
- Never replayed.
- Example:
  - fraud.case.dlq
