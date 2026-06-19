-- Add Inventory Movement Status
alter table public.inventory_movements
add column status text not null default 'confirmed';

alter table public.inventory_movements
add constraint inventory_movements_status_check
check (status in ('pending', 'confirmed', 'reversed'));

-- Add Inventory Stock Non-Negative Constraint
alter table public.inventory_stock
add constraint inventory_stock_non_negative
check (quantity >= 0);

-- Add Inventory Movement Created By Column
alter table public.inventory_movements
add column created_by uuid;

-- Add Foreign Key Constraint for Created By Column
alter table public.inventory_movements
add constraint inventory_movements_created_by_fkey
foreign key (created_by) references public.profiles(id);


-- Add Not Null Constraints for Inventory Stock Columns
alter table public.inventory_stock
alter column item_id set not null;

alter table public.inventory_stock
alter column item_type set not null;

-- Add Check Constraint for Inventory Stock Item Type
alter table public.inventory_stock
add constraint inventory_stock_type_check
check (item_type in ('product', 'supply'));