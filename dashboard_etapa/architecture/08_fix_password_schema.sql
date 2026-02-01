-- 🛠️ FIX: ADD COLUMN AND RESET PASSWORDS
-- Ejecutar TODO este bloque en SQL Editor de Supabase

-- 1. Crear la columna 'password' si no existe
ALTER TABLE public.team_members 
ADD COLUMN IF NOT EXISTS password text DEFAULT '123123';

COMMENT ON COLUMN public.team_members.password IS 'Contraseña de acceso local asignada por gerencia';

-- 2. Actualizar todas las contraseñas a '123123'
UPDATE public.team_members 
SET password = '123123';

-- 3. Confirmación visual
SELECT first_name, role, password FROM public.team_members;
