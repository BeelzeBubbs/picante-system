BEGIN;

-- =========================================================
-- 1. INVENTORY LOCATION
-- =========================================================
INSERT INTO public.inventory_locations (id, name, description)
VALUES (
  gen_random_uuid(),
  'Main Production Kitchen',
  'Primary kitchen & cold storage, Antipolo'
);

-- =========================================================
-- 2. SUPPLIERS
-- =========================================================
INSERT INTO public.suppliers (name, contact_person, phone, notes) VALUES
('Manila Prime Meats Corp', 'Ramon Cruz', '+639171234567', 'Primary pork supplier, weekly delivery'),
('GoodTaste Condiments Trading', 'Liza Fernandez', '+639281234567', 'Soy sauce & sugar supplier'),
('PackPro Supplies Inc.', 'Edwin Santos', '+639391234567', 'Packaging supplier');

-- =========================================================
-- 3. SUPPLIES
-- =========================================================
INSERT INTO public.supplies (id, name, unit, type, standard_unit) VALUES
(gen_random_uuid(), 'Pork Shoulder', 'kg', 'meat', 'kg'),
(gen_random_uuid(), 'Bamboo Skewer Sticks', 'pcs', 'packaging', 'pcs'),
(gen_random_uuid(), 'Soy Sauce', 'L', 'condiment', 'l'),
(gen_random_uuid(), 'Brown Sugar', 'kg', 'condiment', 'kg'),
(gen_random_uuid(), 'Vacuum Packaging Bags', 'pcs', 'packaging', 'pcs');

-- =========================================================
-- 4. PRODUCTS
-- =========================================================
INSERT INTO public.products (id, name, price) VALUES
(gen_random_uuid(), 'Picante Classic Pork BBQ Skewer (10pcs)', 220),
(gen_random_uuid(), 'Picante Spicy Pork BBQ Skewer (10pcs)', 240),
(gen_random_uuid(), 'Picante Family Pack BBQ Skewer (25pcs)', 520);

-- =========================================================
-- 5. CUSTOMERS
-- =========================================================
INSERT INTO public.customers (id, name, phone, email, address, source) VALUES
(gen_random_uuid(), 'Maria Santos', '+639051112222', 'maria.santos@gmail.com', 'Antipolo, Rizal', 'Facebook'),
(gen_random_uuid(), 'Jericho Tan', '+639061113333', 'jericho.tan@gmail.com', 'Marikina City', 'Instagram'),
(gen_random_uuid(), 'Angela Reyes', '+639071114444', 'angela.reyes@yahoo.com', 'Quezon City', 'TikTok'),
(gen_random_uuid(), 'Paolo Mendoza', '+639081115555', 'paolo.mendoza@gmail.com', 'Pasig City', 'Referral'),
(gen_random_uuid(), 'Cristina Dela Cruz', '+639091116666', 'cristina.delacruz@gmail.com', 'Cainta, Rizal', 'Facebook');

-- =========================================================
-- 6. PROMOS
-- =========================================================
INSERT INTO public.promos
(id, code, name, description, discount_type, discount_value, min_purchase, max_discount, start_date, end_date, usage_limit, usage_count, is_active, scope)
VALUES
(gen_random_uuid(), 'LAUNCH10', 'Launch 10% Off', 'Launch promo', 'percent', 10, 200, 100, '2026-05-01', '2026-05-15', 100, 3, TRUE, 'order'),
(gen_random_uuid(), 'FAMPACK50', 'Family Pack Discount', '₱50 off family pack', 'fixed', 50, 500, 50, '2026-05-01', '2026-06-30', 50, 2, TRUE, 'item'),
(gen_random_uuid(), 'WELCOME5', 'Welcome Discount', '5% off first order', 'percent', 5, 0, 50, '2026-04-01', '2026-12-31', 200, 1, TRUE, 'order');

-- =========================================================
-- 7. PURCHASES + ITEMS
-- =========================================================
INSERT INTO public.purchases (supplier_id, purchase_date, total_cost, notes, payment_method, reference_number)
VALUES
(1, '2026-05-02', 22400, 'Pork shoulder bulk', 'bank_transfer', 'MP-1001'),
(3, '2026-05-03', 14000, 'Packaging restock', 'gcash', 'PP-2041'),
(2, '2026-05-04', 3000, 'Condiments restock', 'cash', 'GT-3302'),
(1, '2026-05-12', 17100, 'Mid pork restock', 'bank_transfer', 'MP-1087'),
(3, '2026-05-18', 9600, 'Packaging top-up', 'gcash', 'PP-2115');

-- =========================================================
-- 8. PRODUCTION
-- =========================================================
INSERT INTO public.production
(id, product_id, quantity_planned, quantity_produced_actual,
 production_start_time, production_end_time,
 production_hours, ingredient_cost_total, labor_cost_total,
 waste_cost_estimate, total_cost, cost_per_unit, yield_percentage)
VALUES
(gen_random_uuid(), (SELECT id FROM products LIMIT 1 OFFSET 0),
60, 58, '2026-05-05 06:00', '2026-05-05 12:30',
6.5, 9800, 900, 500, 11200, 193.1, 96.7),

(gen_random_uuid(), (SELECT id FROM products LIMIT 1 OFFSET 1),
50, 50, '2026-05-13 06:00', '2026-05-13 11:45',
5.75, 8600, 850, 400, 9850, 197, 100),

(gen_random_uuid(), (SELECT id FROM products LIMIT 1 OFFSET 2),
30, 28, '2026-05-19 06:00', '2026-05-19 14:00',
8, 12500, 1200, 900, 14600, 521, 93.3);

-- =========================================================
-- 9. SALES
-- =========================================================
INSERT INTO public.sales
(customer_id, sale_date, total_amount, discount_amount, final_amount,
 payment_status, payment_method, reference_number, notes, source)
VALUES
((SELECT id FROM customers LIMIT 1 OFFSET 0), '2026-05-06', 660, 66, 594, 'paid', 'gcash', 'S1', 'Launch order', 'Facebook'),
((SELECT id FROM customers LIMIT 1 OFFSET 1), '2026-05-07', 700, 0, 700, 'partial', 'cod', 'S2', 'Mixed order', 'Instagram'),
((SELECT id FROM customers LIMIT 1 OFFSET 2), '2026-05-08', 470, 0, 470, 'paid', 'gcash', 'S3', 'Family order', 'TikTok'),
((SELECT id FROM customers LIMIT 1 OFFSET 3), '2026-05-14', 960, 0, 960, 'partial', 'bank_transfer', 'S4', 'Bulk office', 'Referral'),
((SELECT id FROM customers LIMIT 1 OFFSET 4), '2026-05-14', 920, 46, 874, 'paid', 'gcash', 'S5', 'Welcome promo', 'Facebook');

-- =========================================================
-- 10. SALE PAYMENTS
-- =========================================================
INSERT INTO public.sale_payments (sale_id, payment_date, amount, payment_method, reference_number, notes)
VALUES
(1, '2026-05-06', 594, 'gcash', 'P1', 'full'),
(2, '2026-05-07', 300, 'gcash', 'P2', 'deposit'),
(2, '2026-05-09', 400, 'cod', 'P3', 'balance'),
(3, '2026-05-08', 470, 'gcash', 'P4', 'full'),
(4, '2026-05-15', 500, 'bank_transfer', 'P5', 'partial');

-- =========================================================
-- 11. EQUIPMENT
-- =========================================================
INSERT INTO public.equipment (name, cost, purchase_date, status, notes, payment_method, reference_number)
VALUES
('Grill Station', 18500, '2026-04-20', 'active', 'main grill', 'bank_transfer', 'EQ1'),
('Vacuum Sealer', 12800, '2026-04-22', 'active', 'packing', 'gcash', 'EQ2'),
('Freezer 500L', 32000, '2026-04-25', 'active', 'storage', 'bank_transfer', 'EQ3'),
('Scale 30kg', 2450, '2026-04-26', 'active', 'weighing', 'cash', 'EQ4'),
('Mixer', 6200, '2026-05-01', 'active', 'marinade', 'gcash', 'EQ5');

-- =========================================================
-- 12. LOGISTICS
-- =========================================================
INSERT INTO public.logistic_expenses (type, cost, description, expense_date, payment_method, reference_number)
VALUES
('delivery_fuel', 850, 'Week 1 fuel', '2026-05-06', 'cash', 'L1'),
('courier', 1200, 'office delivery', '2026-05-14', 'gcash', 'L2'),
('packaging', 650, 'cooler bags', '2026-05-10', 'cash', 'L3'),
('delivery_fuel', 920, 'week 3 fuel', '2026-05-20', 'cash', 'L4'),
('courier', 450, 'grab express', '2026-05-21', 'gcash', 'L5');

-- =========================================================
-- 13. FINANCIAL TRANSACTIONS (SIMPLIFIED SAFE VERSION)
-- =========================================================
INSERT INTO public.financial_transactions
(type, amount, payment_source, reference_type, notes, transaction_date, category)
VALUES
('expense', 22400, 'bank_transfer', 'purchase', 'pork', '2026-05-02', 'supplies'),
('expense', 18500, 'bank_transfer', 'equipment', 'grill', '2026-04-20', 'equipment'),
('expense', 850, 'cash', 'logistics', 'fuel', '2026-05-06', 'logistics'),
('income', 594, 'gcash', 'sale_payment', 'S1 payment', '2026-05-06', 'sales'),
('income', 300, 'gcash', 'sale_payment', 'S2 deposit', '2026-05-07', 'sales');

COMMIT;