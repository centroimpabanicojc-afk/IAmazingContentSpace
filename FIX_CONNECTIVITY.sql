-- 🚨 FIX DEFINITIVO: CONECTIVIDAD, PERMISOS Y FUNCIONES RPC
-- Ejecuta este script para restaurar el acceso total al Dashboard.

-- 1. Permisos de Login y Acceso Público (ANON)
ALTER TABLE public.team_members ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Enable read access for login" ON public.team_members;
CREATE POLICY "Enable read access for login" ON public.team_members 
FOR SELECT TO anon USING (status = 'active');

ALTER TABLE public.clients ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Enable read access for client login" ON public.clients;
CREATE POLICY "Enable read access for client login" ON public.clients 
FOR SELECT TO anon USING (true);

-- 2. Asegurar Columnas Críticas
DO $$ 
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='team_members' AND column_name='status') THEN
        ALTER TABLE public.team_members ADD COLUMN status text DEFAULT 'active';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='team_members' AND column_name='password') THEN
        ALTER TABLE public.team_members ADD COLUMN password text DEFAULT '123';
    END IF;
END $$;

-- 3. FUNCIONES RPC (Faltantes en el Dashboard)
-- Esta función es vital para cargar los módulos del usuario
CREATE OR REPLACE FUNCTION public.get_user_modules(p_user_id uuid)
RETURNS TABLE(
    module_name text,
    can_read boolean,
    can_create boolean,
    can_update boolean,
    can_delete boolean,
    filters jsonb
) AS $$
DECLARE
    v_role text;
BEGIN
    SELECT role::text INTO v_role FROM public.team_members WHERE id = p_user_id;
    IF v_role = 'pm' OR v_role = 'manager' THEN
        RETURN QUERY SELECT DISTINCT mp.module_name, true, true, true, true, '{}'::jsonb FROM public.module_permissions mp;
    ELSE
        RETURN QUERY SELECT mp.module_name, mp.can_read, mp.can_create, mp.can_update, mp.can_delete, mp.filters
        FROM public.module_permissions mp WHERE mp.role = v_role AND mp.can_read = true;
    END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 4. Actualizar Usuario de Prueba (Marco)
UPDATE public.team_members 
SET status = 'active', password = '123', role = 'pm' 
WHERE first_name ILIKE 'Marco';

-- 5. Habilitar Realtime
DO $$ 
BEGIN 
    BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.team_members; EXCEPTION WHEN duplicate_object THEN NULL; END;
    BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.deliveries; EXCEPTION WHEN duplicate_object THEN NULL; END;
END $$;

-- ✅ RESULTADO FINAL
SELECT 'Sistema restaurado. Funciones RPC creadas. Intenta loguearte ahora.' as mensaje;
