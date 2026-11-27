TRUNCATE sn_refunds, sn_bookings, sn_reviewers, sn_guests RESTART IDENTITY CASCADE;

INSERT INTO sn_guests (id, name, email) VALUES
    (401, 'Aarav Shah',  'aarav.shah@example.com'),
    (402, 'Isha Kapoor', 'isha.kapoor@example.com'),
    (403, 'Rohan Das',   'rohan.das@example.com');

-- Dates are relative to the day you load the data.
INSERT INTO sn_bookings (booking_id, guest_id, hotel_name, check_in, check_out, amount_paid, rate_type, status) VALUES
    -- Aarav
    ('SN-2001', 401, 'Lakeview Resort',  CURRENT_DATE + 10, CURRENT_DATE + 12,  4000, 'FLEXIBLE',       'CONFIRMED'),
    ('SN-2002', 401, 'Hilltop Inn',      CURRENT_DATE + 2,  CURRENT_DATE + 4,  12000, 'FLEXIBLE',       'CONFIRMED'),
    ('SN-2003', 401, 'Grand Palace',     CURRENT_DATE + 20, CURRENT_DATE + 24, 40000, 'FLEXIBLE',       'CONFIRMED'),
    ('SN-2010', 401, 'Old Fort Hotel',   CURRENT_DATE + 5,  CURRENT_DATE + 7,   7000, 'FLEXIBLE',       'CANCELLED'),
    -- Isha
    ('SN-2004', 402, 'Beach Hut',        CURRENT_DATE + 15, CURRENT_DATE + 17,  9000, 'NON_REFUNDABLE', 'CONFIRMED'),
    ('SN-2005', 402, 'City Suites',      CURRENT_DATE + 1,  CURRENT_DATE + 3,   8000, 'FLEXIBLE',       'CONFIRMED'),
    ('SN-2006', 402, 'Palm Retreat',     CURRENT_DATE - 1,  CURRENT_DATE + 2,  15000, 'FLEXIBLE',       'CHECKED_IN'),
    ('SN-2011', 402, 'Garden Villa',     CURRENT_DATE + 3,  CURRENT_DATE + 5,   5000, 'FLEXIBLE',       'CONFIRMED'),
    -- Rohan
    ('SN-2007', 403, 'Forest Lodge',     CURRENT_DATE + 7,  CURRENT_DATE + 9,  30000, 'NON_REFUNDABLE', 'HOTEL_CANCELLED'),
    ('SN-2008', 403, 'Riverside Hotel',  CURRENT_DATE + 4,  CURRENT_DATE + 6,  10000, 'FLEXIBLE',       'CONFIRMED'),
    ('SN-2009', 403, 'Metro Stay',       CURRENT_DATE - 10, CURRENT_DATE - 8,   6000, 'FLEXIBLE',       'COMPLETED'),
    ('SN-2012', 403, 'Cliffside Cottage',CURRENT_DATE + 2,  CURRENT_DATE + 4,  10002, 'FLEXIBLE',       'CONFIRMED');

INSERT INTO sn_reviewers (reviewer_id, name, role, active) VALUES
    ('rev-nisha', 'Nisha Rao',   'REVIEWER', TRUE),
    ('rev-omar',  'Omar Sheikh', 'REVIEWER', TRUE),
    ('sen-tara',  'Tara Menon',  'SENIOR',   TRUE),
    ('rev-old',   'Former Staff','REVIEWER', FALSE);
