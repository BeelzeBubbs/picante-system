-- Add Standard Unit Column to Supplies
alter table public.supplies
add column standard_unit text not null default 'pcs';

-- Add Check Constraint for Standard Unit
alter table public.supplies
add constraint supplies_unit_check
check (standard_unit in ('kg', 'g', 'pcs', 'ml', 'l'));