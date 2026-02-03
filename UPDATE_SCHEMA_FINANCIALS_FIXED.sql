-- 📊 ACTUALIZACIÓN: MODELO FINANCIERO AUTOMATIZADO (SOTA) - FIXED
-- CORRECCIÓN: Usamos la fórmula base directamente para evitar errores de dependencia en Postgres.

-- 1. Agregar Roles y Columnas Base
ALTER TABLE public.deliveries 
ADD COLUMN IF NOT EXISTS sales_rep_id uuid REFERENCES public.team_members(id),
ADD COLUMN IF NOT EXISTS commission_date timestamp with time zone DEFAULT now();

-- 2. Implementar MATEMÁTICA DIRECTA (Evita conflicto de columnas generadas)
-- Base Formula: (CASE WHEN billing_type = 'per_minute' THEN duration_minutes * rate_applied ELSE rate_applied END)
-- Agency: 20%
-- Sub: 80% (Base de reparto)
-- R&D: 10% de Sub = 8% del Total
-- Coord Prod: 10% de Sub = 8% del Total
-- Sales: 15% de Sub = 12% del Total
-- Producer: 65% de Sub = 52% del Total

-- A) Fee de Agencia (20% del Bruto)
ALTER TABLE public.deliveries 
ADD COLUMN IF NOT EXISTS fee_agency decimal 
GENERATED ALWAYS AS (
    (CASE WHEN billing_type = 'per_minute' THEN duration_minutes * rate_applied ELSE rate_applied END) * 0.20
) STORED;

-- B) Subtotal Neto (80% del Bruto)
ALTER TABLE public.deliveries 
ADD COLUMN IF NOT EXISTS amount_net_sub decimal 
GENERATED ALWAYS AS (
    (CASE WHEN billing_type = 'per_minute' THEN duration_minutes * rate_applied ELSE rate_applied END) * 0.80
) STORED;

-- C) I+D (8% del Bruto)
ALTER TABLE public.deliveries 
ADD COLUMN IF NOT EXISTS fee_rnd decimal 
GENERATED ALWAYS AS (
    (CASE WHEN billing_type = 'per_minute' THEN duration_minutes * rate_applied ELSE rate_applied END) * 0.08
) STORED;

-- D) Coordinador de Producción (8% del Bruto)
ALTER TABLE public.deliveries 
ADD COLUMN IF NOT EXISTS fee_prod_coord decimal 
GENERATED ALWAYS AS (
    (CASE WHEN billing_type = 'per_minute' THEN duration_minutes * rate_applied ELSE rate_applied END) * 0.08
) STORED;

-- E) Comisión de Ventas (12% del Bruto)
ALTER TABLE public.deliveries 
ADD COLUMN IF NOT EXISTS commission_sales decimal 
GENERATED ALWAYS AS (
    (CASE WHEN billing_type = 'per_minute' THEN duration_minutes * rate_applied ELSE rate_applied END) * 0.12
) STORED;

-- F) Pago al Productor (52% del Bruto)
ALTER TABLE public.deliveries 
ADD COLUMN IF NOT EXISTS pay_producer decimal 
GENERATED ALWAYS AS (
    (CASE WHEN billing_type = 'per_minute' THEN duration_minutes * rate_applied ELSE rate_applied END) * 0.52
) STORED;

-- 3. Documentación
COMMENT ON COLUMN public.deliveries.amount_net_sub IS 'Subtotal repartible (80% del Gross)';
COMMENT ON COLUMN public.deliveries.pay_producer IS 'Pago neto al Coworker (52% del Gross / 65% del Sub)';
