drop extension if exists "pg_net";


  create table "public"."account_access_log" (
    "id" bigint generated always as identity not null,
    "account_id" uuid,
    "user_id" uuid,
    "action" text,
    "timestamp" timestamp without time zone default now()
      );


alter table "public"."account_access_log" enable row level security;


  create table "public"."activity_logs" (
    "id" bigint generated always as identity not null,
    "user_id" uuid,
    "action" text,
    "table_name" text,
    "record_id" text,
    "timestamp" timestamp without time zone default now()
      );


alter table "public"."activity_logs" enable row level security;


  create table "public"."customers" (
    "id" uuid not null default gen_random_uuid(),
    "name" text,
    "phone" text,
    "email" text,
    "address" text,
    "source" text,
    "created_at" timestamp without time zone default now()
      );


alter table "public"."customers" enable row level security;


  create table "public"."equipment" (
    "id" bigint generated always as identity not null,
    "name" text not null,
    "cost" numeric(12,2) not null,
    "purchase_date" date not null default CURRENT_DATE,
    "status" text not null default 'active'::text,
    "notes" text,
    "created_at" timestamp without time zone default now(),
    "payment_method" text,
    "reference_number" text
      );


alter table "public"."equipment" enable row level security;


  create table "public"."external_accounts" (
    "id" uuid not null default gen_random_uuid(),
    "platform" text,
    "account_name" text,
    "username_or_email" text,
    "access_type" text,
    "encrypted_secret" text,
    "expires_at" timestamp without time zone,
    "notes" text,
    "created_at" timestamp without time zone default now()
      );


alter table "public"."external_accounts" enable row level security;


  create table "public"."financial_transactions" (
    "id" bigint generated always as identity not null,
    "type" text,
    "amount" numeric(12,2),
    "payment_source" text,
    "reference_type" text,
    "notes" text,
    "created_at" timestamp without time zone default now(),
    "sale_id" bigint,
    "transaction_date" date,
    "equipment_id" bigint,
    "logistic_expense_id" bigint,
    "purchase_id" bigint,
    "category" text
      );


alter table "public"."financial_transactions" enable row level security;


  create table "public"."inventory_movements" (
    "id" bigint generated always as identity not null,
    "item_type" text,
    "item_id" uuid default gen_random_uuid(),
    "change_quantity" numeric(12,3),
    "movement_type" text,
    "reference_type" text,
    "reference_id" text,
    "cost_per_unit" numeric(12,2),
    "created_at" timestamp without time zone default now()
      );


alter table "public"."inventory_movements" enable row level security;


  create table "public"."inventory_stock" (
    "id" bigint generated always as identity not null,
    "item_type" text,
    "item_id" uuid default gen_random_uuid(),
    "quantity" numeric(12,3),
    "updated_at" timestamp without time zone default now()
      );


alter table "public"."inventory_stock" enable row level security;


  create table "public"."logistic_expenses" (
    "id" bigint generated always as identity not null,
    "type" text not null,
    "cost" numeric(12,2) not null,
    "description" text,
    "expense_date" date not null default CURRENT_DATE,
    "created_at" timestamp without time zone default now(),
    "payment_method" text,
    "reference_number" text
      );


alter table "public"."logistic_expenses" enable row level security;


  create table "public"."obligations" (
    "id" bigint generated always as identity not null,
    "type" text not null,
    "amount" numeric(12,2) not null,
    "paid_amount" numeric(12,2) not null default 0,
    "status" text not null default 'pending'::text,
    "due_date" date,
    "party_name" text not null,
    "reference_type" text,
    "reference_id" bigint,
    "notes" text,
    "created_at" timestamp with time zone not null default now()
      );


alter table "public"."obligations" enable row level security;


  create table "public"."product_ingredients" (
    "id" uuid not null default gen_random_uuid(),
    "product_id" uuid,
    "ingredient_id" uuid,
    "quantity_needed" numeric(12,3),
    "name" text not null default '.'::text
      );


alter table "public"."product_ingredients" enable row level security;


  create table "public"."production" (
    "id" uuid not null default gen_random_uuid(),
    "product_id" uuid,
    "quantity_planned" numeric(12,3),
    "quantity_produced_actual" numeric(12,3),
    "production_start_time" timestamp without time zone,
    "production_end_time" timestamp without time zone,
    "production_hours" numeric(10,2),
    "ingredient_cost_total" numeric(12,2),
    "labor_cost_total" numeric(12,2),
    "waste_cost_estimate" numeric(12,2),
    "total_cost" numeric(12,2),
    "cost_per_unit" numeric(12,2),
    "yield_percentage" numeric(5,2),
    "created_at" timestamp without time zone default now()
      );


alter table "public"."production" enable row level security;


  create table "public"."production_items" (
    "id" uuid not null default gen_random_uuid(),
    "production_id" uuid,
    "ingredient_id" uuid,
    "quantity_used" numeric(12,3),
    "cost_at_time" numeric(12,2)
      );


alter table "public"."production_items" enable row level security;


  create table "public"."production_labor" (
    "id" uuid not null default gen_random_uuid(),
    "production_id" uuid,
    "worker_name" text,
    "hours_worked" numeric(10,2),
    "rate_per_hour" numeric(12,2),
    "total_cost" numeric(12,2)
      );


alter table "public"."production_labor" enable row level security;


  create table "public"."production_waste" (
    "id" uuid not null default gen_random_uuid(),
    "production_id" uuid,
    "type" text,
    "quantity" numeric(12,3),
    "estimated_cost" numeric(12,2)
      );


alter table "public"."production_waste" enable row level security;


  create table "public"."products" (
    "id" uuid not null default gen_random_uuid(),
    "name" text,
    "price" numeric(12,2)
      );


alter table "public"."products" enable row level security;


  create table "public"."profiles" (
    "id" uuid not null,
    "full_name" text,
    "role" text,
    "phone" text,
    "created_at" timestamp without time zone default now()
      );


alter table "public"."profiles" enable row level security;


  create table "public"."promos" (
    "id" uuid not null default gen_random_uuid(),
    "code" text not null,
    "name" text,
    "description" text,
    "discount_type" text not null,
    "discount_value" numeric(12,2) not null,
    "min_purchase" numeric(12,2),
    "max_discount" numeric(12,2),
    "start_date" timestamp without time zone,
    "end_date" timestamp without time zone,
    "usage_limit" integer,
    "usage_count" integer default 0,
    "is_active" boolean default true,
    "created_at" timestamp without time zone default now(),
    "scope" text not null default ''::text
      );


alter table "public"."promos" enable row level security;


  create table "public"."purchase_items" (
    "id" bigint generated always as identity not null,
    "purchase_id" bigint,
    "supply_id" uuid,
    "quantity" numeric(12,3),
    "unit_cost" numeric(12,2),
    "line_total" numeric(12,2)
      );


alter table "public"."purchase_items" enable row level security;


  create table "public"."purchases" (
    "id" bigint generated always as identity not null,
    "supplier_id" bigint,
    "purchase_date" date,
    "total_cost" numeric(12,2),
    "notes" text,
    "payment_method" text,
    "reference_number" text
      );


alter table "public"."purchases" enable row level security;


  create table "public"."sale_items" (
    "id" bigint generated always as identity not null,
    "sale_id" bigint,
    "product_id" uuid,
    "quantity_ordered" numeric(12,3) not null default '0'::numeric,
    "unit_price" numeric(12,2),
    "line_total" numeric(12,2),
    "quantity_delivered" numeric not null default '0'::numeric,
    "promo_id" uuid default gen_random_uuid(),
    "discount_amount" numeric
      );


alter table "public"."sale_items" enable row level security;


  create table "public"."sale_payments" (
    "id" bigint generated always as identity not null,
    "sale_id" bigint not null,
    "payment_date" date not null,
    "amount" numeric(12,2) not null,
    "payment_method" text not null,
    "reference_number" text,
    "notes" text,
    "created_at" timestamp with time zone not null default now()
      );


alter table "public"."sale_payments" enable row level security;


  create table "public"."sales" (
    "id" bigint generated always as identity not null,
    "customer_id" uuid,
    "sale_date" date,
    "total_amount" numeric(12,2),
    "discount_amount" numeric,
    "final_amount" numeric,
    "payment_status" text,
    "payment_method" text,
    "reference_number" text,
    "promo_id" uuid,
    "notes" text,
    "created_at" timestamp with time zone default now(),
    "source" text
      );


alter table "public"."sales" enable row level security;


  create table "public"."staging_customers" (
    "name" text,
    "phone" text,
    "email" text,
    "address" text
      );


alter table "public"."staging_customers" enable row level security;


  create table "public"."staging_sales" (
    "customer_name" text,
    "sale_date" timestamp without time zone,
    "total_amount" numeric(12,2)
      );


alter table "public"."staging_sales" enable row level security;


  create table "public"."suppliers" (
    "id" bigint generated always as identity not null,
    "name" text,
    "contact_person" text,
    "phone" text,
    "notes" text
      );


alter table "public"."suppliers" enable row level security;


  create table "public"."supplies" (
    "id" uuid not null default gen_random_uuid(),
    "name" text,
    "unit" text,
    "type" text
      );


alter table "public"."supplies" enable row level security;

CREATE UNIQUE INDEX account_access_log_pkey ON public.account_access_log USING btree (id);

CREATE UNIQUE INDEX activity_logs_pkey ON public.activity_logs USING btree (id);

CREATE UNIQUE INDEX cash_transactions_pkey ON public.financial_transactions USING btree (id);

CREATE UNIQUE INDEX customers_pkey ON public.customers USING btree (id);

CREATE UNIQUE INDEX equipment_pkey ON public.equipment USING btree (id);

CREATE UNIQUE INDEX external_accounts_pkey ON public.external_accounts USING btree (id);

CREATE UNIQUE INDEX inventory_movements_pkey ON public.inventory_movements USING btree (id);

CREATE UNIQUE INDEX inventory_stock_pkey ON public.inventory_stock USING btree (id);

CREATE UNIQUE INDEX logistic_expenses_pkey ON public.logistic_expenses USING btree (id);

CREATE UNIQUE INDEX obligations_pkey ON public.obligations USING btree (id);

CREATE UNIQUE INDEX product_ingredients_pkey ON public.product_ingredients USING btree (id);

CREATE UNIQUE INDEX production_items_pkey ON public.production_items USING btree (id);

CREATE UNIQUE INDEX production_labor_pkey ON public.production_labor USING btree (id);

CREATE UNIQUE INDEX production_pkey ON public.production USING btree (id);

CREATE UNIQUE INDEX production_waste_pkey ON public.production_waste USING btree (id);

CREATE UNIQUE INDEX products_pkey ON public.products USING btree (id);

CREATE UNIQUE INDEX profiles_pkey ON public.profiles USING btree (id);

CREATE UNIQUE INDEX promos_code_key ON public.promos USING btree (code);

CREATE UNIQUE INDEX promos_pkey ON public.promos USING btree (id);

CREATE UNIQUE INDEX purchase_items_pkey ON public.purchase_items USING btree (id);

CREATE UNIQUE INDEX purchases_pkey ON public.purchases USING btree (id);

CREATE UNIQUE INDEX sale_items_pkey ON public.sale_items USING btree (id);

CREATE UNIQUE INDEX sale_payments_pkey ON public.sale_payments USING btree (id);

CREATE UNIQUE INDEX sales_pkey ON public.sales USING btree (id);

CREATE UNIQUE INDEX suppliers_pkey ON public.suppliers USING btree (id);

CREATE UNIQUE INDEX supplies_pkey ON public.supplies USING btree (id);

alter table "public"."account_access_log" add constraint "account_access_log_pkey" PRIMARY KEY using index "account_access_log_pkey";

alter table "public"."activity_logs" add constraint "activity_logs_pkey" PRIMARY KEY using index "activity_logs_pkey";

alter table "public"."customers" add constraint "customers_pkey" PRIMARY KEY using index "customers_pkey";

alter table "public"."equipment" add constraint "equipment_pkey" PRIMARY KEY using index "equipment_pkey";

alter table "public"."external_accounts" add constraint "external_accounts_pkey" PRIMARY KEY using index "external_accounts_pkey";

alter table "public"."financial_transactions" add constraint "cash_transactions_pkey" PRIMARY KEY using index "cash_transactions_pkey";

alter table "public"."inventory_movements" add constraint "inventory_movements_pkey" PRIMARY KEY using index "inventory_movements_pkey";

alter table "public"."inventory_stock" add constraint "inventory_stock_pkey" PRIMARY KEY using index "inventory_stock_pkey";

alter table "public"."logistic_expenses" add constraint "logistic_expenses_pkey" PRIMARY KEY using index "logistic_expenses_pkey";

alter table "public"."obligations" add constraint "obligations_pkey" PRIMARY KEY using index "obligations_pkey";

alter table "public"."product_ingredients" add constraint "product_ingredients_pkey" PRIMARY KEY using index "product_ingredients_pkey";

alter table "public"."production" add constraint "production_pkey" PRIMARY KEY using index "production_pkey";

alter table "public"."production_items" add constraint "production_items_pkey" PRIMARY KEY using index "production_items_pkey";

alter table "public"."production_labor" add constraint "production_labor_pkey" PRIMARY KEY using index "production_labor_pkey";

alter table "public"."production_waste" add constraint "production_waste_pkey" PRIMARY KEY using index "production_waste_pkey";

alter table "public"."products" add constraint "products_pkey" PRIMARY KEY using index "products_pkey";

alter table "public"."profiles" add constraint "profiles_pkey" PRIMARY KEY using index "profiles_pkey";

alter table "public"."promos" add constraint "promos_pkey" PRIMARY KEY using index "promos_pkey";

alter table "public"."purchase_items" add constraint "purchase_items_pkey" PRIMARY KEY using index "purchase_items_pkey";

alter table "public"."purchases" add constraint "purchases_pkey" PRIMARY KEY using index "purchases_pkey";

alter table "public"."sale_items" add constraint "sale_items_pkey" PRIMARY KEY using index "sale_items_pkey";

alter table "public"."sale_payments" add constraint "sale_payments_pkey" PRIMARY KEY using index "sale_payments_pkey";

alter table "public"."sales" add constraint "sales_pkey" PRIMARY KEY using index "sales_pkey";

alter table "public"."suppliers" add constraint "suppliers_pkey" PRIMARY KEY using index "suppliers_pkey";

alter table "public"."supplies" add constraint "supplies_pkey" PRIMARY KEY using index "supplies_pkey";

alter table "public"."account_access_log" add constraint "account_access_log_account_id_fkey" FOREIGN KEY (account_id) REFERENCES public.external_accounts(id) not valid;

alter table "public"."account_access_log" validate constraint "account_access_log_account_id_fkey";

alter table "public"."account_access_log" add constraint "account_access_log_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profiles(id) not valid;

alter table "public"."account_access_log" validate constraint "account_access_log_user_id_fkey";

alter table "public"."activity_logs" add constraint "activity_logs_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profiles(id) not valid;

alter table "public"."activity_logs" validate constraint "activity_logs_user_id_fkey";

alter table "public"."equipment" add constraint "equipment_status_check" CHECK ((status = ANY (ARRAY['active'::text, 'sold'::text, 'broken'::text]))) not valid;

alter table "public"."equipment" validate constraint "equipment_status_check";

alter table "public"."financial_transactions" add constraint "financial_transactions_equipment_id_fkey" FOREIGN KEY (equipment_id) REFERENCES public.equipment(id) ON UPDATE CASCADE not valid;

alter table "public"."financial_transactions" validate constraint "financial_transactions_equipment_id_fkey";

alter table "public"."financial_transactions" add constraint "financial_transactions_logistic_expense_id_fkey" FOREIGN KEY (logistic_expense_id) REFERENCES public.logistic_expenses(id) ON UPDATE CASCADE not valid;

alter table "public"."financial_transactions" validate constraint "financial_transactions_logistic_expense_id_fkey";

alter table "public"."financial_transactions" add constraint "financial_transactions_purchase_id_fkey" FOREIGN KEY (purchase_id) REFERENCES public.purchases(id) ON UPDATE CASCADE not valid;

alter table "public"."financial_transactions" validate constraint "financial_transactions_purchase_id_fkey";

alter table "public"."financial_transactions" add constraint "financial_transactions_sale_id_fkey" FOREIGN KEY (sale_id) REFERENCES public.sales(id) ON DELETE SET NULL not valid;

alter table "public"."financial_transactions" validate constraint "financial_transactions_sale_id_fkey";

alter table "public"."obligations" add constraint "obligations_status_check" CHECK ((status = ANY (ARRAY['pending'::text, 'partial'::text, 'paid'::text, 'cancelled'::text]))) not valid;

alter table "public"."obligations" validate constraint "obligations_status_check";

alter table "public"."obligations" add constraint "obligations_type_check" CHECK ((type = ANY (ARRAY['payable'::text, 'receivable'::text]))) not valid;

alter table "public"."obligations" validate constraint "obligations_type_check";

alter table "public"."product_ingredients" add constraint "product_ingredients_ingredient_id_fkey" FOREIGN KEY (ingredient_id) REFERENCES public.supplies(id) not valid;

alter table "public"."product_ingredients" validate constraint "product_ingredients_ingredient_id_fkey";

alter table "public"."product_ingredients" add constraint "product_ingredients_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public.products(id) not valid;

alter table "public"."product_ingredients" validate constraint "product_ingredients_product_id_fkey";

alter table "public"."production" add constraint "production_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE RESTRICT not valid;

alter table "public"."production" validate constraint "production_product_id_fkey";

alter table "public"."production_items" add constraint "production_items_ingredient_id_fkey" FOREIGN KEY (ingredient_id) REFERENCES public.supplies(id) not valid;

alter table "public"."production_items" validate constraint "production_items_ingredient_id_fkey";

alter table "public"."production_items" add constraint "production_items_production_id_fkey" FOREIGN KEY (production_id) REFERENCES public.production(id) ON DELETE CASCADE not valid;

alter table "public"."production_items" validate constraint "production_items_production_id_fkey";

alter table "public"."production_labor" add constraint "production_labor_production_id_fkey" FOREIGN KEY (production_id) REFERENCES public.production(id) ON DELETE CASCADE not valid;

alter table "public"."production_labor" validate constraint "production_labor_production_id_fkey";

alter table "public"."production_waste" add constraint "production_waste_production_id_fkey" FOREIGN KEY (production_id) REFERENCES public.production(id) ON DELETE CASCADE not valid;

alter table "public"."production_waste" validate constraint "production_waste_production_id_fkey";

alter table "public"."profiles" add constraint "profiles_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."profiles" validate constraint "profiles_id_fkey";

alter table "public"."promos" add constraint "promos_code_key" UNIQUE using index "promos_code_key";

alter table "public"."purchase_items" add constraint "purchase_items_purchase_id_fkey" FOREIGN KEY (purchase_id) REFERENCES public.purchases(id) ON DELETE CASCADE not valid;

alter table "public"."purchase_items" validate constraint "purchase_items_purchase_id_fkey";

alter table "public"."purchase_items" add constraint "purchase_items_supply_id_fkey" FOREIGN KEY (supply_id) REFERENCES public.supplies(id) not valid;

alter table "public"."purchase_items" validate constraint "purchase_items_supply_id_fkey";

alter table "public"."purchases" add constraint "purchases_supplier_id_fkey" FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id) not valid;

alter table "public"."purchases" validate constraint "purchases_supplier_id_fkey";

alter table "public"."sale_items" add constraint "sale_items_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public.products(id) not valid;

alter table "public"."sale_items" validate constraint "sale_items_product_id_fkey";

alter table "public"."sale_items" add constraint "sale_items_promo_id_fkey" FOREIGN KEY (promo_id) REFERENCES public.promos(id) ON UPDATE RESTRICT ON DELETE SET NULL not valid;

alter table "public"."sale_items" validate constraint "sale_items_promo_id_fkey";

alter table "public"."sale_items" add constraint "sale_items_sale_id_fkey" FOREIGN KEY (sale_id) REFERENCES public.sales(id) ON DELETE CASCADE not valid;

alter table "public"."sale_items" validate constraint "sale_items_sale_id_fkey";

alter table "public"."sale_payments" add constraint "sale_payments_amount_check" CHECK ((amount > (0)::numeric)) not valid;

alter table "public"."sale_payments" validate constraint "sale_payments_amount_check";

alter table "public"."sale_payments" add constraint "sale_payments_sale_id_fkey" FOREIGN KEY (sale_id) REFERENCES public.sales(id) ON DELETE CASCADE not valid;

alter table "public"."sale_payments" validate constraint "sale_payments_sale_id_fkey";

alter table "public"."sales" add constraint "sales_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE SET NULL not valid;

alter table "public"."sales" validate constraint "sales_customer_id_fkey";

alter table "public"."sales" add constraint "sales_promo_id_fkey" FOREIGN KEY (promo_id) REFERENCES public.promos(id) ON DELETE SET NULL not valid;

alter table "public"."sales" validate constraint "sales_promo_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.add_equipment_expense(p_name text, p_cost numeric, p_purchase_date date, p_payment_method text, p_reference_number text, p_category text, p_notes text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_equipment_id BIGINT;
BEGIN

    ---------------------------------------------------
    -- 1. CREATE EQUIPMENT RECORD
    ---------------------------------------------------
    INSERT INTO equipment (
        name,
        cost,
        purchase_date,
        payment_method,
        reference_number,
        notes
    )
    VALUES (
        p_name,
        p_cost,
        p_purchase_date,
        p_payment_method,
        p_reference_number,
        p_notes
    )
    RETURNING id INTO v_equipment_id;

    ---------------------------------------------------
    -- 2. CREATE FINANCIAL TRANSACTION
    ---------------------------------------------------
    INSERT INTO financial_transactions (
        type,
        amount,
        payment_source,
        reference_type,
        category,
        notes,
        transaction_date,
        equipment_id
    )
    VALUES (
        'expense',
        p_cost,
        p_payment_method,
        'equipment',
        p_category,
        p_notes,
        p_purchase_date,
        v_equipment_id
    );

    RETURN v_equipment_id;

END;
$function$
;

CREATE OR REPLACE FUNCTION public.add_logistic_expense(p_type text, p_cost numeric, p_description text, p_expense_date date, p_payment_method text, p_reference_number text, p_category text, p_notes text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_logistic_id BIGINT;
BEGIN

    ---------------------------------------------------
    -- 1. CREATE LOGISTICS EXPENSE
    ---------------------------------------------------
    INSERT INTO logistic_expenses (
        type,
        cost,
        description,
        expense_date,
        payment_method,
        reference_number
    )
    VALUES (
        p_type,
        p_cost,
        p_description,
        p_expense_date,
        p_payment_method,
        p_reference_number
    )
    RETURNING id INTO v_logistic_id;

    ---------------------------------------------------
    -- 2. CREATE FINANCIAL TRANSACTION
    ---------------------------------------------------
    INSERT INTO financial_transactions (
        type,
        amount,
        payment_source,
        reference_type,
        category,
        notes,
        transaction_date,
        logistic_expense_id
    )
    VALUES (
        'expense',
        p_cost,
        p_payment_method,
        'logistics',
        p_category,
        p_notes,
        p_expense_date,
        v_logistic_id
    );

    RETURN v_logistic_id;

END;
$function$
;

CREATE OR REPLACE FUNCTION public.create_purchase_accounting(p_supply_id uuid, p_quantity numeric, p_unit_cost numeric, p_payment_source text, p_reference_number text, p_category text, p_notes text, p_purchase_date date)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_purchase_id BIGINT;
    v_total NUMERIC(12,2);
BEGIN

    v_total := p_quantity * p_unit_cost;

    INSERT INTO purchases (
        purchase_date,
        payment_method,
        total_cost,
        notes,
        reference_number
    )
    VALUES (
        p_purchase_date,
        p_payment_source,
        v_total,
        p_notes,
        p_reference_number
    )
    RETURNING id INTO v_purchase_id;

    INSERT INTO purchase_items (
        purchase_id,
        supply_id,
        quantity,
        unit_cost,
        line_total
    )
    VALUES (
        v_purchase_id,
        p_supply_id,
        p_quantity,
        p_unit_cost,
        v_total
    );

    INSERT INTO financial_transactions (
        type,
        amount,
        payment_source,
        reference_type,
        category,
        purchase_id,
        notes,
        transaction_date
    )
    VALUES (
        'expense',
        v_total,
        p_payment_source,
        'purchases',
        p_category,
        v_purchase_id,
        p_notes,
        p_purchase_date
    );

    RETURN v_purchase_id;

END;
$function$
;

CREATE OR REPLACE FUNCTION public.create_sale_transaction(p_sale_date date, p_customer_id uuid, p_sale_promo_id uuid, p_product_id uuid, p_item_promo_id uuid, p_payment_method text, p_payment_status text, p_reference_number text, p_quantity integer, p_notes text, p_source text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_sale_id BIGINT;

    -- pricing
    v_unit_price NUMERIC;
    v_line_total NUMERIC;

    -- after item promo
    v_item_discounted_total NUMERIC;
    v_item_discount_amount NUMERIC;

    -- after sale promo
    v_final_total NUMERIC;
    v_sale_discount_amount NUMERIC;

BEGIN

    -- Create Sale

    INSERT INTO sales (
        sale_date,
        customer_id,
        payment_method,
        payment_status,
        reference_number,
        promo_id,
        notes,
        source
    )
    VALUES (
        p_sale_date,
        p_customer_id,
        p_payment_method,
        p_payment_status,
        NULLIF(p_reference_number, ''),
        p_sale_promo_id,
        p_notes,
        p_source
    )
    RETURNING id
    INTO v_sale_id;

    -- Get Product Price

    SELECT price
    INTO v_unit_price
    FROM products
    WHERE id = p_product_id;

    IF v_unit_price IS NULL THEN
        RAISE EXCEPTION 'Product % not found or has no price', p_product_id;
    END IF;

    -- Base Total

    v_line_total := v_unit_price * p_quantity;

    -- Apply Item Promo

    v_item_discounted_total := v_line_total;

    IF p_item_promo_id IS NOT NULL THEN

        SELECT
            CASE
                WHEN discount_type = 'percent'
                    THEN v_line_total * (1 - discount_value / 100.0)

                WHEN discount_type = 'fixed'
                    THEN GREATEST(
                        v_line_total - (p_quantity * discount_value),
                        0
                    )

                ELSE v_line_total
            END
        INTO v_item_discounted_total
        FROM promos
        WHERE id = p_item_promo_id;

    END IF;

    v_item_discount_amount :=
        v_line_total - v_item_discounted_total;

    -- Create Sale Item

    INSERT INTO sale_items (
        sale_id,
        product_id,
        quantity_ordered,
        quantity_delivered,
        unit_price,
        line_total,
        discount_amount,
        promo_id
    )
    VALUES (
        v_sale_id,
        p_product_id,
        p_quantity,
        0,
        v_unit_price,
        v_item_discounted_total,
        v_item_discount_amount,
        p_item_promo_id
    );

    -- Apply Sale Promo

    v_final_total := v_item_discounted_total;

    IF p_sale_promo_id IS NOT NULL THEN

        SELECT
            CASE
                WHEN discount_type = 'percent'
                    THEN v_item_discounted_total *
                         (1 - discount_value / 100.0)

                WHEN discount_type = 'fixed'
                    THEN GREATEST(
                        v_item_discounted_total - discount_value,
                        0
                    )

                ELSE v_item_discounted_total
            END
        INTO v_final_total
        FROM promos
        WHERE id = p_sale_promo_id;

    END IF;

    v_sale_discount_amount :=
        v_item_discounted_total - v_final_total;

    -- Update Sale Totals

    UPDATE sales
    SET
        total_amount = v_item_discounted_total,
        discount_amount = v_sale_discount_amount,
        final_amount = v_final_total
    WHERE id = v_sale_id;

    RETURN v_sale_id;

END;
$function$
;

CREATE OR REPLACE FUNCTION public.receive_sale_payment(p_sale_id bigint, p_payment_date date, p_amount numeric, p_payment_method text, p_reference_number text DEFAULT NULL::text, p_notes text DEFAULT NULL::text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_total_paid NUMERIC;
    v_total_amount NUMERIC;
BEGIN

    -- safety
    IF p_sale_id IS NULL THEN
        RAISE EXCEPTION 'Sale ID is required';
    END IF;

    IF p_amount <= 0 THEN
        RAISE EXCEPTION 'Payment must be greater than 0';
    END IF;

    -- 1. Insert into sale payments (operational record)
    INSERT INTO sale_payments (
        sale_id,
        payment_date,
        amount,
        payment_method,
        reference_number,
        notes
    )
    VALUES (
        p_sale_id,
        p_payment_date,
        p_amount,
        p_payment_method,
        p_reference_number,
        p_notes
    );

    -- 2. Insert into financial ledger (ACCOUNTING LAYER)
    INSERT INTO financial_transactions (
        type,
        amount,
        payment_source,
        reference_type,
        reference_number,
        notes,
        sale_id,
        transaction_date,
        category
    )
    VALUES (
        'income',
        p_amount,
        p_payment_method,
        'sale_payment',
        p_reference_number,
        p_notes,
        p_sale_id,
        p_payment_date,
        'sales'
    );

    -- 3. Recalculate total paid
    SELECT COALESCE(SUM(amount), 0)
    INTO v_total_paid
    FROM sale_payments
    WHERE sale_id = p_sale_id;

    -- 4. Get sale total
    SELECT total_amount
    INTO v_total_amount
    FROM sales
    WHERE id = p_sale_id;

    IF v_total_amount IS NULL THEN
        RAISE EXCEPTION 'Sale not found';
    END IF;

    -- 5. Update status
    UPDATE sales
    SET payment_status =
        CASE
            WHEN v_total_paid >= v_total_amount THEN 'Paid'
            WHEN v_total_paid > 0 THEN 'Partially Paid'
            ELSE 'Unpaid'
        END
    WHERE id = p_sale_id;

END;
$function$
;


