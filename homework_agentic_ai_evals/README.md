# StayNest homeworks

Two homeworks share the same story (a hotel-booking platform), the same tables (prefix `sn_`) and the same data, so they do not touch the Zomato tables.

| File | What it is |
| --- | --- |
| `homework_03_staynest_langgraph_workflow.ipynb` | Homework 3 (Notebook 5): build the support workflow with LangGraph, human approval and Langfuse tracing |
| `homework_04_staynest_evals_observability.ipynb` | Homework 4 (Notebook 6): measure the assistant with evals and observability in Langfuse |
| `staynest_schema.sql` | Tables: guests, bookings, reviewers, refunds (used by both) |
| `staynest_seed.sql` | Three guests, twelve bookings, four reviewers (one inactive). Dates are relative to the day you load it |
| `data/staynest_policies.csv` | Eight policies, grouped by topic (also the documents for the RAG answers in Homework 4) |

## Homework 3: the workflow

1. State, the `understand` node (one typed Jev call) and the router with a parallel fan-out
2. The rules engine (plain Python) and the join
3. Idempotent write, human approval with reviewer checks, and durable PostgreSQL checkpoints
4. Observability with Langfuse: spans, reading traces back, scores
5. Failure paths and eight golden cases

## Homework 4: evals and observability

Homework 4 does not need your Homework 3 code. It gives you a compact StayNest assistant (same rules, same data) and asks you to measure it.

1. Typed and custom observations, and prompt versioning (a `guardrail` observation, prompt v1 and v2 with labels)
2. A golden dataset and code evaluators for the agent: outcome, approval and trajectory, plus a deliberate regression
3. RAG evals and a Jev LLM judge in one experiment, then compare two prompt versions
4. Human annotation: fill a queue with flagged and random answers, score by hand, compare with the judge
5. Online evaluation: code scores and user feedback from the app, a sampled judge, a dashboard and an alert, tested with a fire drill

Topics from Notebook 6 that are **not** in this homework (they are covered later): Ragas metrics and LLM security.

## Setup

Same `.env` as the other notebooks (`DATABASE_URL`, `OPENROUTER_API_KEY`, `OPENROUTER_MODEL`, the three `LANGFUSE_*` values). Open the notebook from this folder so the relative `staynest_*.sql` and `data/` paths work. The notebooks create and reload the tables themselves. Homework 4 makes a few hundred real Jev and chat-model calls (a few cents) and needs an LLM connection in the Langfuse dashboard for Task 5.
