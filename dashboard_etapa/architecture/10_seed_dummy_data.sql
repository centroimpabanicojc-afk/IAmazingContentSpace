-- 🌱 SEED DATA: POPULATE DASHBOARD
-- Ejecutar en SQL Editor de Supabase
-- Rellena el dashboard con datos de prueba para ver las métricas y listas activas

-- 1. Insertar Clientes (si no existen)
INSERT INTO public.clients (name, type, whatsapp, tier, status) VALUES
('TechFlow Agency', 'agency', '34600112233', 'agency_500', 'active'),
('Yoga with Sarah', 'creator', '34600445566', 'creator_15', 'active'),
('CryptoKing', 'creator', '34600778899', 'blackmarket_flex', 'lead'),
('Urban Eats', 'pyme', '34600223344', 'pyme_100', 'active')
ON CONFLICT (whatsapp) DO NOTHING;

-- 2. Variables para IDs (Usando subqueries para ser dinámico)
-- No usamos variables DECLARE porque Supabase SQL Editor a veces lo limita. Usamos INSERT con SELECT.

-- 3. Insertar Proyectos (Asignados a Marco, Pedro, etc)
INSERT INTO public.projects (client_id, assigned_to, service_type, status, priority, deadline, created_at, delivered_at)
SELECT 
    c.id, 
    tm.id,
    'video', 
    'briefing', 
    5, 
    NOW() + INTERVAL '2 days',
    NOW(),
    NULL
FROM public.clients c, public.team_members tm 
WHERE c.name = 'TechFlow Agency' AND tm.first_name = 'Marco'
LIMIT 1;

INSERT INTO public.projects (client_id, assigned_to, service_type, status, priority, deadline, created_at, delivered_at)
SELECT 
    c.id, 
    tm.id,
    'reel', 
    'production', 
    3, 
    NOW() + INTERVAL '1 day',
    NOW(),
    NULL
FROM public.clients c, public.team_members tm 
WHERE c.name = 'Yoga with Sarah' AND tm.first_name = 'Pedro'
LIMIT 1;

INSERT INTO public.projects (client_id, assigned_to, service_type, status, priority, deadline, created_at, delivered_at)
SELECT 
    c.id, 
    tm.id,
    'thumbnail', 
    'qc', 
    1, 
    NOW() + INTERVAL '5 days',
    NOW(),
    NULL
FROM public.clients c, public.team_members tm 
WHERE c.name = 'Urban Eats' AND tm.first_name = 'Yara'
LIMIT 1;

-- Proyectos Completados (Para Analíticas)
INSERT INTO public.projects (client_id, assigned_to, service_type, status, priority, deadline, created_at, delivered_at)
SELECT 
    c.id, 
    tm.id,
    'pack', 
    'completed', 
    3, 
    NOW() - INTERVAL '10 days',
    NOW() - INTERVAL '15 days',
    NOW() - INTERVAL '10 days'
FROM public.clients c, public.team_members tm 
WHERE c.name = 'TechFlow Agency' AND tm.first_name = 'Pedro'
LIMIT 1;

INSERT INTO public.projects (client_id, assigned_to, service_type, status, priority, deadline, created_at, delivered_at)
SELECT 
    c.id, 
    tm.id,
    'video', 
    'completed', 
    5, 
    NOW() - INTERVAL '5 days',
    NOW() - INTERVAL '8 days',
    NOW() - INTERVAL '5 days'
FROM public.clients c, public.team_members tm 
WHERE c.name = 'Yoga with Sarah' AND tm.first_name = 'Marco'
LIMIT 1;

-- 4. Insertar Pagos (Para Gráficas de Revenue)
INSERT INTO public.project_payments (project_id, editor_id, amount, status, created_at)
SELECT 
    p.id, 
    p.assigned_to, 
    150.00, 
    'paid', 
    NOW() - INTERVAL '10 days'
FROM public.projects p
WHERE p.status = 'completed' AND p.service_type = 'pack'
LIMIT 1;

INSERT INTO public.project_payments (project_id, editor_id, amount, status, created_at)
SELECT 
    p.id, 
    p.assigned_to, 
    75.50, 
    'paid', 
    NOW() - INTERVAL '5 days'
FROM public.projects p
WHERE p.status = 'completed' AND p.service_type = 'video'
LIMIT 1;

-- Verificación
SELECT COUNT(*) as proyectos_creados FROM public.projects;
