BEGIN;

-- =====================================================
-- INVENTORY LOCATIONS
-- =====================================================

CREATE TABLE IF NOT EXISTS public.inventory_locations (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name text NOT NULL,
    description text,
    created_at timestamp DEFAULT now()
);

-- =====================================================
-- DEFAULT LOCATION
-- =====================================================

INSERT INTO public.inventory_locations (
    name,
    description
)
SELECT
    'Main Warehouse',
    'Default inventory location'
WHERE NOT EXISTS (
    SELECT 1
    FROM public.inventory_locations
    WHERE name = 'Main Warehouse'
);

-- =====================================================
-- INVENTORY STOCK
-- =====================================================

ALTER TABLE public.inventory_stock
ADD COLUMN IF NOT EXISTS location_id uuid;

ALTER TABLE public.inventory_stock
DROP CONSTRAINT IF EXISTS inventory_stock_location_fkey;

ALTER TABLE public.inventory_stock
ADD CONSTRAINT inventory_stock_location_fkey
FOREIGN KEY (location_id)
REFERENCES public.inventory_locations(id);

-- Backfill existing records

UPDATE public.inventory_stock
SET location_id = (
    SELECT id
    FROM public.inventory_locations
    WHERE name = 'Main Warehouse'
    LIMIT 1
)
WHERE location_id IS NULL;

-- Make location required

ALTER TABLE public.inventory_stock
ALTER COLUMN location_id SET NOT NULL;

-- Remove dangerous auto-generated item ids

ALTER TABLE public.inventory_stock
ALTER COLUMN item_id DROP DEFAULT;

-- Prevent duplicate stock records

CREATE UNIQUE INDEX IF NOT EXISTS inventory_stock_unique_item_location
ON public.inventory_stock (
    item_type,
    item_id,
    location_id
);

-- =====================================================
-- INVENTORY MOVEMENTS
-- =====================================================

ALTER TABLE public.inventory_movements
ADD COLUMN IF NOT EXISTS location_id uuid;

ALTER TABLE public.inventory_movements
DROP CONSTRAINT IF EXISTS inventory_movements_location_fkey;

ALTER TABLE public.inventory_movements
ADD CONSTRAINT inventory_movements_location_fkey
FOREIGN KEY (location_id)
REFERENCES public.inventory_locations(id);

-- Remove dangerous auto-generated item ids

ALTER TABLE public.inventory_movements
ALTER COLUMN item_id DROP DEFAULT;

-- =====================================================
-- REMOVE MOVEMENT BATCHES
-- =====================================================

DROP TABLE IF EXISTS public.movement_batches CASCADE;

-- =====================================================
-- SET NOT NULL CONSTRAINTS for item_id columns
-- =====================================================

ALTER TABLE public.inventory_movements
ALTER COLUMN item_id SET NOT NULL;

ALTER TABLE public.inventory_stock
ALTER COLUMN item_id SET NOT NULL;

COMMIT;