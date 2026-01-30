ECR Platform — Technology Stack

Purpose
This document defines the canonical technology stack for the Event-Driven Cognitive Runtime (ECR).
The stack is designed to be enterprise-grade, production-ready, auditable, and credible in real-world environments (fraud, risk, compliance, decisioning).

1. Guiding Principles

Event-native: immutable events are the source of truth

Contract-driven: schemas are governed, versioned, and enforced

Policy-first: cost, latency, and safety are explicit

Observability-as-memory: no hidden state

LLMs are optional: AI is a signal, not the control plane

GitOps only: no imperative production changes

2. Cloud & Infrastructure
Cloud Provider

AWS

Core Infrastructure

EKS — Kubernetes control plane

VPC (multi-AZ) — private subnets, controlled egress

ALB / NLB — ingress (HTTP/TCP)

Route 53 — DNS

ACM — TLS certificates

Infrastructure as Code

Terraform

VPC

EKS

IAM / IRSA

RDS

ElastiCache

S3

ECR

3. GitOps & Delivery
Deployment Model

Argo CD (App-of-Apps) — mandatory

Helm — deployment units

GitHub Actions — CI pipelines

Amazon ECR — container registry

Environments

dev

staging

prod

All promotion occurs via Git commits, never manual kubectl.

4. Event Backbone (System of Record)
Streaming Platform

Apache Kafka (self-managed)

Strimzi Operator on EKS

Schema Governance

Confluent Schema Registry

Compatibility level: BACKWARD

Protobuf schemas only for event contracts

Core Topics

ecr-events-*

ecr-steps-*

ecr-decisions-*

ecr-audit-*

ecr-dlq-*

Kafka is the authoritative timeline and memory of the system.

5. Contracts & Schemas
Event Contracts (Canonical)

Protobuf

Stored in protos/ecr/v1/*

Enforced via:

Schema Registry

CI breaking-change checks (Buf)

Service Contracts

Pydantic v2

Used for:

HTTP APIs

Internal validation

Developer ergonomics

Protobuf defines what is persisted.
Pydantic defines how services interact.

6. Cognitive Runtime (Application Core)
Core Services

Gateway

AuthN/AuthZ

Rate limiting

Schema validation

Orchestrator

DAG execution

Idempotency

Run lifecycle

Planner

Plan selection (cheap / full / degraded)

Policy Engine

Budgets

Thresholds

Allowlists

Context Projector

Context plane assembly

Context window enforcement

Runtime Stores

Postgres (RDS)

Run index

Policy snapshots

Idempotency keys

Redis (ElastiCache)

Rate limiting

Actor health cache

Short-lived state

7. Actor Fleet (Evaluation Layer)
Actor Characteristics

Single responsibility

Schema-in / schema-out

Cost-estimated

Health-checked

Stateless

Example Actors

Rules Actor

Velocity / Feature Actor

Device Risk Actor

Model Scorer Actor (optional)

Actors produce signals, not decisions.

8. AI / Model Inference (Optional, Controlled)
Baseline

CPU-first inference

vLLM (CPU mode) for small models

Guardrails

Strict input/output schemas

Context budgets

Timeouts

Rate limits

Policy-gated execution

LLM Observability

Langfuse

Used only for model-scoring steps

Complements OpenTelemetry

LLMs never:

control execution

own memory

bypass policy

9. Arbitration & Verification
Arbitration

Signal aggregation

Disagreement scoring

Confidence computation

Policy-based thresholds

Verification

Safety invariants

Fail-closed behavior

Degrade-mode enforcement

No single signal (or model) can decide alone.

10. Observability & Audit (Memory Layer)
Telemetry

OpenTelemetry (standard instrumentation)

Metrics

Prometheus

Alertmanager

Dashboards

Grafana (provisioned as code)

Tracing

Tempo (or AWS X-Ray)

Logs

Loki (or CloudWatch Logs)

Structured JSON logs with:

run_id

trace_id

tenant_id

policy_snapshot_id

Audit & Replay

Kafka audit topics

Replay controller

Drift detection reports (stored in S3)

11. Security & Governance
Identity & Access

IRSA (IAM Roles for Service Accounts)

Least-privilege IAM policies

Secrets

AWS Secrets Manager

External Secrets Operator

Cluster Policy

Kyverno or OPA Gatekeeper

Admission controls

Required labels / annotations

Network Security

Kubernetes NetworkPolicies

Namespace isolation

12. Durable Workflows (Out of Hot Path)
Temporal (Optional)

Used only for:

Long-running investigations

Human-in-the-loop workflows

Disputes

Backfills

Offline analysis

Not used for real-time decision execution.

13. Testing & Quality Gates
Contracts

Buf linting

Breaking-change detection

Schema compatibility enforcement

Testing

Unit tests (pytest)

Integration tests (Kafka/Postgres/Redis)

Load tests (k6)

Security

SAST (CodeQL or equivalent)

Dependency scanning

14. Cost & Reliability Tooling

Cost estimation per actor

Budget enforcement via policy

Kubernetes resource limits

Optional: Kubecost

AWS Cost Explorer alarms

15. Summary

ECR’s stack is intentionally:

boring

explicit

auditable

defensible

This is not an agent framework.
This is a world-class AI automation platform for real-time business decisioning.
