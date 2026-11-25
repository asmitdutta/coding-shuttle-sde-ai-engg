-- SwiftParcel homework schema. Safe to run again (IF NOT EXISTS).

CREATE TABLE IF NOT EXISTS sp_customers (
    id          INTEGER PRIMARY KEY,
    name        TEXT NOT NULL,
    email       TEXT NOT NULL,
    phone       TEXT NOT NULL,
    tier        TEXT NOT NULL CHECK (tier IN ('STANDARD', 'GOLD'))
);

CREATE TABLE IF NOT EXISTS sp_parcels (
    tracking_id      TEXT PRIMARY KEY,                 -- format SP-12345678
    customer_id      INTEGER NOT NULL REFERENCES sp_customers(id),
    description      TEXT NOT NULL,
    status           TEXT NOT NULL CHECK (status IN
                     ('PENDING_PICKUP', 'IN_TRANSIT', 'OUT_FOR_DELIVERY', 'DELIVERED', 'LOST', 'RETURNED')),
    declared_value   NUMERIC(10, 2) NOT NULL,
    promised_date    DATE NOT NULL,
    delivered_at     TIMESTAMPTZ,
    reschedule_count INTEGER NOT NULL DEFAULT 0,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS sp_reschedules (
    id              BIGSERIAL PRIMARY KEY,
    tracking_id     TEXT NOT NULL REFERENCES sp_parcels(tracking_id),
    customer_id     INTEGER NOT NULL,
    new_date        DATE NOT NULL,
    idempotency_key TEXT NOT NULL UNIQUE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS sp_claims (
    id              BIGSERIAL PRIMARY KEY,
    tracking_id     TEXT NOT NULL REFERENCES sp_parcels(tracking_id),
    customer_id     INTEGER NOT NULL,
    claim_type      TEXT NOT NULL CHECK (claim_type IN ('LOST', 'DAMAGED', 'LATE')),
    amount          NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    description     TEXT NOT NULL,
    status          TEXT NOT NULL DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED')),
    decided_by      TEXT,
    decision_note   TEXT,
    decided_at      TIMESTAMPTZ,
    idempotency_key TEXT NOT NULL UNIQUE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Used in homework 3
CREATE TABLE IF NOT EXISTS sp_threads (
    thread_id   TEXT PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    name        TEXT NOT NULL,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (customer_id, name)
);

CREATE TABLE IF NOT EXISTS sp_preferences (
    customer_id INTEGER NOT NULL,
    key         TEXT NOT NULL,
    value       TEXT NOT NULL,
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (customer_id, key)
);
