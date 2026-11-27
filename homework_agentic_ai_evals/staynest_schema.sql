-- StayNest homework schema. Safe to run again (IF NOT EXISTS).

CREATE TABLE IF NOT EXISTS sn_guests (
    id      INTEGER PRIMARY KEY,
    name    TEXT NOT NULL,
    email   TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS sn_bookings (
    booking_id   TEXT PRIMARY KEY,                       -- format SN-2001
    guest_id     INTEGER NOT NULL REFERENCES sn_guests(id),
    hotel_name   TEXT NOT NULL,
    check_in     DATE NOT NULL,
    check_out    DATE NOT NULL,
    amount_paid  NUMERIC(10, 2) NOT NULL,
    rate_type    TEXT NOT NULL CHECK (rate_type IN ('FLEXIBLE', 'NON_REFUNDABLE')),
    status       TEXT NOT NULL CHECK (status IN
                 ('CONFIRMED', 'CHECKED_IN', 'COMPLETED', 'CANCELLED', 'HOTEL_CANCELLED'))
);

CREATE TABLE IF NOT EXISTS sn_reviewers (
    reviewer_id TEXT PRIMARY KEY,
    name        TEXT NOT NULL,
    role        TEXT NOT NULL CHECK (role IN ('REVIEWER', 'SENIOR')),
    active      BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS sn_refunds (
    refund_id       BIGSERIAL PRIMARY KEY,
    booking_id      TEXT NOT NULL REFERENCES sn_bookings(booking_id),
    guest_id        INTEGER NOT NULL,
    amount          NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    approval_level  TEXT NOT NULL CHECK (approval_level IN ('AUTO', 'REVIEWER', 'SENIOR')),
    status          TEXT NOT NULL DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED')),
    decided_by      TEXT,
    decision_note   TEXT,
    decided_at      TIMESTAMPTZ,
    idempotency_key TEXT NOT NULL UNIQUE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
