--  Add Inventory Locations Table and Link to Inventory Stock
create table public.inventory_locations (
    id uuid primary key default gen_random_uuid(),
    name text not null,
    description text,
    created_at timestamp default now()
);

alter table public.inventory_stock
add column location_id uuid;

alter table public.inventory_stock
add constraint inventory_stock_location_fkey
foreign key (location_id) references inventory_locations(id);

-- Add Movement Batches Table
create table public.movement_batches (
    id uuid primary key default gen_random_uuid(),
    type text not null,
    reference_id uuid,
    created_at timestamp default now()
);

-- Add Check Constraint for Movement Batches Type

alter table public.movement_batches
add constraint movement_batches_type_check
check (type in (
    'production',
    'purchase',
    'waste',
    'manual_adjustment',
    'sale'
));