-- 🏗️ UTILITY: RESET PASSWORDS FOR TESTING
-- Ejecutar en SQL Editor de Supabase para resetear accesos

UPDATE public.team_members 
SET password = '123123';

-- Confirmación
SELECT first_name, role, password FROM public.team_members;
