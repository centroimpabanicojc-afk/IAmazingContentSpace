-- 03_expenses_schema.sql
-- Creación de la tabla de pagos para editores

CREATE TABLE IF NOT EXISTS public.project_payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID REFERENCES public.projects(id) ON DELETE CASCADE,
    editor_id UUID REFERENCES public.team_members(id),
    amount DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    status TEXT CHECK (status IN ('pending', 'paid')) DEFAULT 'pending',
    notes TEXT,
    paid_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Habilitar RLS
ALTER TABLE public.project_payments ENABLE ROW LEVEL SECURITY;

-- Política de acceso (Ajustada para el entorno actual de oficina)
-- En un entorno real, esto se restringiría a roles administrativos
CREATE POLICY "Allow all access to project_payments" ON public.project_payments
    FOR ALL USING (true) WITH CHECK (true);

-- Comentario informativo
COMMENT ON TABLE public.project_payments IS 'Registro de pagos efectuados a editores por proyecto.';
