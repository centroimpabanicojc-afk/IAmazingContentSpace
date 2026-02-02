-- 🛠️ FIX: ACTUALIZACIÓN DE SCHEMA PARA ONBOARDING Y PERFILES
-- Ejecuta este código en el SQL Editor de tu Dashboard de Supabase (https://supabase.com/dashboard/project/crisfmzsxqonuxkbguur/sql)

-- 1. Añadir columnas faltantes a la tabla team_members
ALTER TABLE public.team_members 
ADD COLUMN IF NOT EXISTS email text,
ADD COLUMN IF NOT EXISTS status text DEFAULT 'active',
ADD COLUMN IF NOT EXISTS interview_summary text,
ADD COLUMN IF NOT EXISTS personality_traits jsonb DEFAULT '{}'::jsonb,
ADD COLUMN IF NOT EXISTS last_name text;

-- 2. Expandir el ENUM de roles para permitir nuevos registros
-- Nota: Si falla porque el valor ya existe, no pasa nada.
DO $$ 
BEGIN 
    ALTER TYPE team_role ADD VALUE 'editor';
EXCEPTION WHEN duplicate_object THEN null;
END $$;

DO $$ 
BEGIN 
    ALTER TYPE team_role ADD VALUE 'copywriter';
EXCEPTION WHEN duplicate_object THEN null;
END $$;

DO $$ 
BEGIN 
    ALTER TYPE team_role ADD VALUE 'manager';
EXCEPTION WHEN duplicate_object THEN null;
END $$;

-- 3. Habilitar permisos de inserción para el proceso de Onboarding (Registro)
-- Por ahora permitimos a anon para facilitar el prototipo
DROP POLICY IF EXISTS "Enable insert for onboarding" ON public.team_members;
CREATE POLICY "Enable insert for onboarding" ON public.team_members FOR INSERT TO anon WITH CHECK (true);

-- 4. Confirmación visual
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'team_members';
