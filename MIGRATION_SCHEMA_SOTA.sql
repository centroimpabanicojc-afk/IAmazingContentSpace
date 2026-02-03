-- 🚀 MIGRACIÓN: CARTELERA DE ENTREGAS SOTA (Excel -> Supabase)
-- Ejecuta esto en el SQL Editor de Supabase

-- 1. Actualizar tabla de CLIENTES (Asegurar campos para cobro)
ALTER TABLE public.clients 
ADD COLUMN IF NOT EXISTS whatsapp text,
ADD COLUMN IF NOT EXISTS default_rate decimal DEFAULT 0,
ADD COLUMN IF NOT EXISTS currency text DEFAULT 'USD',
ADD COLUMN IF NOT EXISTS billing_model text DEFAULT 'fixed'; -- 'fixed' o 'per_minute'

-- 2. Crear tabla de ENTREGAS (Deliveries) - El nuevo motor del sistema
CREATE TABLE IF NOT EXISTS public.deliveries (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    client_id uuid REFERENCES public.clients(id) ON DELETE CASCADE,
    name text NOT NULL, -- Nombre del video/proyecto
    status text DEFAULT 'briefing' CHECK (status IN ('briefing', 'production', 'qc', 'delivered', 'paid', 'archived')),
    priority integer DEFAULT 3, -- 1-5
    due_date timestamp with time zone,
    
    -- Campos de Facturación (SOTA)
    billing_type text DEFAULT 'fixed' CHECK (billing_type IN ('fixed', 'per_minute')),
    duration_minutes decimal DEFAULT 0,
    rate_applied decimal DEFAULT 0, -- Precio pactado o valor por minuto
    total_price decimal GENERATED ALWAYS AS (
        CASE 
            WHEN billing_type = 'per_minute' THEN duration_minutes * rate_applied 
            ELSE rate_applied 
        END
    ) STORED,

    delivery_url text, -- Link final (Drive/Dropbox)
    assigned_to uuid REFERENCES public.team_members(id),
    feedback_notes text
);

-- 3. Tabla para Registro de Notificaciones (WhatsApp Bridge)
CREATE TABLE IF NOT EXISTS public.notifications_log (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    delivery_id uuid REFERENCES public.deliveries(id),
    notification_type text, -- 'delay_alert', 'delivered_alert'
    sent_at timestamp with time zone DEFAULT now(),
    recipient text
);

-- 4. Habilitar Realtime para la nueva tabla (Para que el frontend se actualice solo)
ALTER PUBLICATION supabase_realtime ADD TABLE public.deliveries;

-- 5. Comentario de confirmación
COMMENT ON TABLE public.deliveries IS 'Tabla centralizada para la Cartelera de Entregas SOTA';
