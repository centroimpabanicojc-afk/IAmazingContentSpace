-- ========================================
-- MÓDULOS POR DEPARTAMENTO - SPRINT 1
-- Base de Datos: Departamentos y Permisos
-- ========================================

-- 1. CREAR TABLA: departments
CREATE TABLE IF NOT EXISTS public.departments (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    name text NOT NULL UNIQUE,
    display_name text NOT NULL,
    description text,
    icon text,
    color text,
    created_at timestamptz DEFAULT now()
);

-- 2. SEED DATA: Departamentos
INSERT INTO public.departments (name, display_name, description, icon, color) VALUES
('sales', 'Ventas', 'Gestión de leads, clientes y comisiones', 'trending-up', '#10b981'),
('production', 'Producción Audiovisual', 'Proyectos, entregas y recursos', 'video', '#8b5cf6'),
('rd', 'I+D', 'Investigación, desarrollo e innovación', 'flask-conical', '#06b6d4'),
('admin', 'Administración', 'Vista global y configuración', 'shield-check', '#f59e0b')
ON CONFLICT (name) DO NOTHING;

-- 3. MODIFICAR TABLA: team_members
-- Agregar columna de departamento
ALTER TABLE public.team_members
ADD COLUMN IF NOT EXISTS department_id uuid REFERENCES public.departments(id);

-- Mapeo automático de roles a departamentos
UPDATE public.team_members SET department_id = (SELECT id FROM departments WHERE name = 'admin') WHERE role = 'pm';
UPDATE public.team_members SET department_id = (SELECT id FROM departments WHERE name = 'sales') WHERE role IN ('sales_head', 'sales_intern');
UPDATE public.team_members SET department_id = (SELECT id FROM departments WHERE name = 'production') WHERE role IN ('coord_prod', 'editor_sr', 'editor_std', 'designer');
UPDATE public.team_members SET department_id = (SELECT id FROM departments WHERE name = 'rd') WHERE role = 'ai_bot';

-- 4. CREAR TABLA: module_permissions
CREATE TABLE IF NOT EXISTS public.module_permissions (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    role text NOT NULL,
    module_name text NOT NULL,
    can_read boolean DEFAULT false,
    can_create boolean DEFAULT false,
    can_update boolean DEFAULT false,
    can_delete boolean DEFAULT false,
    filters jsonb DEFAULT '{}'::jsonb,
    created_at timestamptz DEFAULT now(),
    UNIQUE(role, module_name)
);

-- 5. SEED DATA: Permisos por Rol
-- ADMIN (pm) - Acceso Total
INSERT INTO public.module_permissions (role, module_name, can_read, can_create, can_update, can_delete, filters) VALUES
('pm', 'clients', true, true, true, true, '{}'),
('pm', 'projects', true, true, true, true, '{}'),
('pm', 'payments', true, true, true, true, '{}'),
('pm', 'team', true, true, true, true, '{}'),
('pm', 'analytics', true, true, true, true, '{}'),
('pm', 'settings', true, true, true, true, '{}')
ON CONFLICT (role, module_name) DO NOTHING;

-- VENTAS (sales_head, sales_intern)
INSERT INTO public.module_permissions (role, module_name, can_read, can_create, can_update, can_delete, filters) VALUES
('sales_head', 'clients', true, true, true, false, '{}'),
('sales_head', 'projects', true, false, false, false, '{"only_own_clients": true}'),
('sales_head', 'commissions', true, false, false, false, '{"only_own": true}'),
('sales_head', 'analytics', true, false, false, false, '{"sales_only": true}'),

('sales_intern', 'clients', true, true, false, false, '{}'),
('sales_intern', 'projects', true, false, false, false, '{"only_own_clients": true}'),
('sales_intern', 'commissions', true, false, false, false, '{"only_own": true}')
ON CONFLICT (role, module_name) DO NOTHING;

-- PRODUCCIÓN (coord_prod, editor_sr, editor_std, designer)
INSERT INTO public.module_permissions (role, module_name, can_read, can_create, can_update, can_delete, filters) VALUES
('coord_prod', 'projects', true, false, true, false, '{}'),
('coord_prod', 'payments', true, true, false, false, '{}'),
('coord_prod', 'team', true, false, false, false, '{"production_only": true}'),
('coord_prod', 'analytics', true, false, false, false, '{"production_only": true}'),

('editor_sr', 'projects', true, false, true, false, '{"only_assigned": true}'),
('editor_sr', 'payments', true, false, false, false, '{"only_own": true}'),

('editor_std', 'projects', true, false, true, false, '{"only_assigned": true}'),
('editor_std', 'payments', true, false, false, false, '{"only_own": true}'),

('designer', 'projects', true, false, true, false, '{"only_assigned": true}'),
('designer', 'payments', true, false, false, false, '{"only_own": true}')
ON CONFLICT (role, module_name) DO NOTHING;

-- I+D (ai_bot)
INSERT INTO public.module_permissions (role, module_name, can_read, can_create, can_update, can_delete, filters) VALUES
('ai_bot', 'experiments', true, true, true, false, '{}'),
('ai_bot', 'knowledge', true, true, true, false, '{}'),
('ai_bot', 'analytics', true, false, false, false, '{"rd_only": true}')
ON CONFLICT (role, module_name) DO NOTHING;

-- 6. FUNCIÓN: Verificar Permisos de Usuario
CREATE OR REPLACE FUNCTION public.check_user_permission(
    p_user_id uuid,
    p_module text,
    p_action text -- 'read', 'create', 'update', 'delete'
)
RETURNS boolean AS $$
DECLARE
    v_role text;
    v_has_permission boolean;
BEGIN
    -- Obtener rol del usuario
    SELECT role::text INTO v_role FROM public.team_members WHERE id = p_user_id;
    
    -- Si no se encuentra el usuario, denegar
    IF v_role IS NULL THEN
        RETURN false;
    END IF;
    
    -- Admin (pm) siempre tiene acceso
    IF v_role = 'pm' THEN
        RETURN true;
    END IF;
    
    -- Verificar en tabla de permisos
    SELECT 
        CASE p_action
            WHEN 'read' THEN can_read
            WHEN 'create' THEN can_create
            WHEN 'update' THEN can_update
            WHEN 'delete' THEN can_delete
            ELSE false
        END INTO v_has_permission
    FROM public.module_permissions
    WHERE role = v_role AND module_name = p_module;
    
    RETURN COALESCE(v_has_permission, false);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 7. FUNCIÓN: Obtener Módulos Disponibles para Usuario
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
    -- Obtener rol del usuario
    SELECT role::text INTO v_role FROM public.team_members WHERE id = p_user_id;
    
    -- Si es admin, devolver todos los módulos
    IF v_role = 'pm' THEN
        RETURN QUERY
        SELECT DISTINCT 
            mp.module_name,
            true::boolean,
            true::boolean,
            true::boolean,
            true::boolean,
            '{}'::jsonb
        FROM public.module_permissions mp;
    ELSE
        -- Devolver solo módulos permitidos para el rol
        RETURN QUERY
        SELECT 
            mp.module_name,
            mp.can_read,
            mp.can_create,
            mp.can_update,
            mp.can_delete,
            mp.filters
        FROM public.module_permissions mp
        WHERE mp.role = v_role AND mp.can_read = true;
    END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 8. ROW LEVEL SECURITY (RLS) POLICIES

-- Habilitar RLS en nuevas tablas
ALTER TABLE public.departments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.module_permissions ENABLE ROW LEVEL SECURITY;

-- Política: Todos pueden leer departamentos
DROP POLICY IF EXISTS "Public read access to departments" ON public.departments;
CREATE POLICY "Public read access to departments" ON public.departments
FOR SELECT USING (true);

-- Política: Todos pueden leer permisos (para UI dinámica)
DROP POLICY IF EXISTS "Public read access to permissions" ON public.module_permissions;
CREATE POLICY "Public read access to permissions" ON public.module_permissions
FOR SELECT USING (true);

-- Política: Solo admin puede modificar permisos
DROP POLICY IF EXISTS "Admin only write to permissions" ON public.module_permissions;
CREATE POLICY "Admin only write to permissions" ON public.module_permissions
FOR ALL USING (
    EXISTS (
        SELECT 1 FROM public.team_members
        WHERE id = auth.uid() AND role::text = 'pm'
    )
);

-- 9. POLÍTICA RLS: Clientes (Solo Ventas y Admin)
DROP POLICY IF EXISTS "Department-based client access" ON public.clients;
CREATE POLICY "Department-based client access" ON public.clients
FOR SELECT USING (
    EXISTS (
        SELECT 1 FROM public.team_members tm
        JOIN public.departments d ON tm.department_id = d.id
        WHERE tm.id = auth.uid()
        AND (d.name IN ('admin', 'sales'))
    )
);

-- 10. POLÍTICA RLS: Proyectos (Filtrado por Asignación)
DROP POLICY IF EXISTS "Production team project access" ON public.deliveries;
CREATE POLICY "Production team project access" ON public.deliveries
FOR SELECT USING (
    EXISTS (
        SELECT 1 FROM public.team_members tm
        WHERE tm.id = auth.uid()
        AND (
            tm.role::text = 'pm' OR
            tm.role::text = 'coord_prod' OR
            deliveries.assigned_to = tm.id
        )
    )
);

-- 11. POLÍTICA RLS: Pagos (Solo Admin, Coord y Propios)
DROP POLICY IF EXISTS "Payment access control" ON public.project_payments;
CREATE POLICY "Payment access control" ON public.project_payments
FOR SELECT USING (
    EXISTS (
        SELECT 1 FROM public.team_members tm
        WHERE tm.id = auth.uid()
        AND (
            tm.role::text IN ('pm', 'coord_prod') OR
            project_payments.editor_id = tm.id
        )
    )
);

-- 12. VERIFICACIÓN
SELECT 'Departamentos creados:' as status, COUNT(*) as count FROM public.departments;
SELECT 'Permisos configurados:' as status, COUNT(*) as count FROM public.module_permissions;
SELECT 'Usuarios con departamento:' as status, COUNT(*) as count FROM public.team_members WHERE department_id IS NOT NULL;

-- Test de funciones
SELECT 'Test check_user_permission:' as test, 
       public.check_user_permission(
           (SELECT id FROM team_members WHERE role::text = 'sales_head' LIMIT 1),
           'clients',
           'read'
       ) as result;

SELECT 'Test get_user_modules:' as test, * FROM public.get_user_modules(
    (SELECT id FROM team_members WHERE role::text = 'editor_sr' LIMIT 1)
);

-- ========================================
-- FIN DE MIGRACIÓN
-- ========================================
