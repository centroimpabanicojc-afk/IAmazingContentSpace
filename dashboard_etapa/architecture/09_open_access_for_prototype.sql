-- 🔓 OPEN ACCESS FOR PROTOTYPE (ALLOW ANON ACCESS)
-- Ejecutar en SQL Editor de Supabase
-- Explicación: El sistema de login actual es "simulado" (local), por lo que la conexión a Supabase
-- se realiza técnicamente como usuario "anónimo". Las políticas anteriores requerían usuario "autenticado".

-- 1. Tabla: CLIENTS
DROP POLICY IF EXISTS "Enable read access for authenticated users" ON public.clients;
DROP POLICY IF EXISTS "Enable insert for authenticated users" ON public.clients;

CREATE POLICY "Allow public access to clients" ON public.clients
FOR ALL USING (true) WITH CHECK (true);

-- 2. Tabla: TEAM_MEMBERS
DROP POLICY IF EXISTS "Enable read access for authenticated users" ON public.team_members;
DROP POLICY IF EXISTS "Enable insert for authenticated users" ON public.team_members;

CREATE POLICY "Allow public access to team_members" ON public.team_members
FOR ALL USING (true) WITH CHECK (true);

-- 3. Tabla: PROJECTS
DROP POLICY IF EXISTS "Enable read access for authenticated users" ON public.projects;
DROP POLICY IF EXISTS "Enable insert for authenticated users" ON public.projects;

CREATE POLICY "Allow public access to projects" ON public.projects
FOR ALL USING (true) WITH CHECK (true);

-- 4. Tabla: PRODUCTION_METRICS
DROP POLICY IF EXISTS "Enable read access for authenticated users" ON public.production_metrics;

CREATE POLICY "Allow public access to production_metrics" ON public.production_metrics
FOR ALL USING (true) WITH CHECK (true);

-- 5. Tabla: PROJECT_PAYMENTS (Reasegurar)
DROP POLICY IF EXISTS "Allow all access to project_payments" ON public.project_payments;

CREATE POLICY "Allow public access to project_payments" ON public.project_payments
FOR ALL USING (true) WITH CHECK (true);

-- Confirmación visual de que la base de datos es accesible
SELECT 'Acceso público configurado correctamente' as status;
