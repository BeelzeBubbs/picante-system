-- =========================================================
-- Migration: Add production linkage to logistic_expenses
-- and extend production cost model to include logistics
-- =========================================================

BEGIN;

-- =========================================================
-- 1. LINK LOGISTICS EXPENSES TO PRODUCTION
-- =========================================================
ALTER TABLE public.logistic_expenses
ADD COLUMN production_id uuid;

ALTER TABLE public.logistic_expenses
ADD CONSTRAINT logistic_expenses_production_id_fkey
FOREIGN KEY (production_id)
REFERENCES public.production(id)
ON DELETE SET NULL;

-- =========================================================
-- 2. ADD LOGISTICS COST AGGREGATION TO PRODUCTION
-- =========================================================
ALTER TABLE public.production
ADD COLUMN logistics_cost_total numeric DEFAULT 0;


UPDATE public.production
SET logistics_cost_total = 0
WHERE logistics_cost_total IS NULL;

COMMIT;