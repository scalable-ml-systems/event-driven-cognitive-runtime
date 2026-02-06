# Kafka-Native Fraud Investigation Runtime 

## Purpose
Cold-path, event-sourced fraud investigation runtime that produces replayable, audit-grade case dossiers.

## Invariants (Non-negotiable)
1) Kafka case ledger is the source of truth for case facts.
2) Postgres is a projection only (rebuildable by replay).
3) Tools are deterministic; outputs are immutable artifacts referenced by hash.
4) AI outputs are structured claims only; AI is never authoritative.
5) Verifier is mandatory; no decision without VerifierApproved.
6) Replay reproduces identical dossier root hash; replay must not execute tools/AI.

## Non-goals
- Hot-path blocking
- UI
- Auth system replacement
- Free-text authority
