-- 📊 ACTUALIZACIÓN: MODELO FINANCIERO AUTOMATIZADO (SOTA)
-- Implementa la lógica de negocio "Business Dynamics" directamente en la base de datos

-- 1. Agregar Roles de Ventas al Enum de Roles (Si no existen, modificamos el constraint)
-- Nota: Supabase maneja los roles como texto simple en nuestra app, así que no es estricto, 
-- pero es bueno documentarlo: 'sales_rep', 'prod_coordinator'.

-- 2. Modificar tabla DELIVERIES para incluir fechas clave y Vendedor
ALTER TABLE public.deliveries 
ADD COLUMN IF NOT EXISTS sales_rep_id uuid REFERENCES public.team_members(id),
ADD COLUMN IF NOT EXISTS commission_date timestamp with time zone DEFAULT now();

-- 3. Implementar COLUMNAS CALCULADAS (Generated Columns)
-- Esto garantiza que la matemática SIEMPRE sea correcta y no dependa del frontend.

-- A) Fee de Agencia (20% del Precio Bruto) - "Ganancia Neta Compañía"
ALTER TABLE public.deliveries 
ADD COLUMN IF NOT EXISTS fee_agency decimal 
GENERATED ALWAYS AS (total_price * 0.20) STORED;

-- B) Subtotal Neto ("Sub") - Lo que queda para repartir (80%)
ALTER TABLE public.deliveries 
ADD COLUMN IF NOT EXISTS amount_net_sub decimal 
GENERATED ALWAYS AS (total_price - (total_price * 0.20)) STORED;

-- C) I+D (10% del Sub) - "Estructura de Tokens y Software"
ALTER TABLE public.deliveries 
ADD COLUMN IF NOT EXISTS fee_rnd decimal 
GENERATED ALWAYS AS ((total_price - (total_price * 0.20)) * 0.10) STORED;

-- D) Coordinador de Producción (10% del Sub)
ALTER TABLE public.deliveries 
ADD COLUMN IF NOT EXISTS fee_prod_coord decimal 
GENERATED ALWAYS AS ((total_price - (total_price * 0.20)) * 0.10) STORED;

-- E) Comisión de Ventas (15% del Sub) - Para el "Seller"
ALTER TABLE public.deliveries 
ADD COLUMN IF NOT EXISTS commission_sales decimal 
GENERATED ALWAYS AS ((total_price - (total_price * 0.20)) * 0.15) STORED;

-- F) Pago al Productor/Coworker (65% del Sub) - Para "assigned_to"
ALTER TABLE public.deliveries 
ADD COLUMN IF NOT EXISTS pay_producer decimal 
GENERATED ALWAYS AS ((total_price - (total_price * 0.20)) * 0.65) STORED;

-- 4. Comentario de Documentación
COMMENT ON COLUMN public.deliveries.amount_net_sub IS 'Subtotal repartible (80% del Gross)';
COMMENT ON COLUMN public.deliveries.pay_producer IS 'Pago neto al Coworker (65% del Sub)';
