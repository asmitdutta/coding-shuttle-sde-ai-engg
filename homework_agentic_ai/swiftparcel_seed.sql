TRUNCATE sp_claims, sp_reschedules, sp_parcels, sp_customers, sp_threads, sp_preferences RESTART IDENTITY CASCADE;

INSERT INTO sp_customers (id, name, email, phone, tier) VALUES
    (301, 'Meera Nair',   'meera.nair@example.com',   '+91 98765 43210', 'GOLD'),
    (302, 'Karan Mehta',  'karan.mehta@example.com',  '+91 91234 56789', 'STANDARD'),
    (303, 'Divya Rao',    'divya.rao@example.com',    '+91 99887 76655', 'STANDARD');

INSERT INTO sp_parcels (tracking_id, customer_id, description, status, declared_value, promised_date, delivered_at, reschedule_count) VALUES
    -- Meera (GOLD)
    ('SP-10000001', 301, 'Running shoes',        'IN_TRANSIT',       2500, CURRENT_DATE + 2,  NULL, 0),
    ('SP-10000002', 301, 'Birthday gift box',    'OUT_FOR_DELIVERY', 1200, CURRENT_DATE,      NULL, 0),
    ('SP-10000003', 301, 'Ceramic vase',         'DELIVERED',         800, CURRENT_DATE - 2,  NOW() - INTERVAL '1 day', 0),
    ('SP-10000004', 301, 'Laptop sleeve',        'LOST',             3000, CURRENT_DATE - 12, NULL, 0),
    -- Karan (STANDARD)
    ('SP-10000005', 302, 'Gaming keyboard',      'IN_TRANSIT',       4500, CURRENT_DATE + 3,  NULL, 2),
    ('SP-10000006', 302, 'Phone cover',          'DELIVERED',         450, CURRENT_DATE - 10, NOW() - INTERVAL '9 days', 0),
    ('SP-10000007', 302, 'Camera lens',          'PENDING_PICKUP',   6000, CURRENT_DATE + 5,  NULL, 0),
    -- Divya (STANDARD)
    ('SP-10000008', 303, 'Books (set of 6)',     'IN_TRANSIT',       1200, CURRENT_DATE + 1,  NULL, 0),
    ('SP-10000009', 303, 'Smart watch',          'DELIVERED',        7500, CURRENT_DATE - 1,  NOW() - INTERVAL '1 day', 0),
    ('SP-10000010', 303, 'Return: wrong size',   'RETURNED',          900, CURRENT_DATE - 6,  NULL, 0);
