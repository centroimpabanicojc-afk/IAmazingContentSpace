-- 🛡️ SECURITY FIX: Permisos para la Oficina
-- Ejecutar en SQL Editor de Supabase

-- Eliminar políticas restrictivas previas (si existen con este nombre exacto)
drop policy if exists "Enable insert for authenticated users" on public.clients;
drop policy if exists "Enable insert for authenticated users" on public.team_members;
drop policy if exists "Enable insert for authenticated users" on public.projects;

-- 1. CLIENTES: La oficina puede crear y ver clientes
create policy "Office access: Select Clients" on public.clients for select using (true);
create policy "Office access: Insert Clients" on public.clients for insert with check (true);
create policy "Office access: Update Clients" on public.clients for update using (true);

-- 2. PROYECTOS: La oficina puede crear y gestionar proyectos
create policy "Office access: Select Projects" on public.projects for select using (true);
create policy "Office access: Insert Projects" on public.projects for insert with check (true);
create policy "Office access: Update Projects" on public.projects for update using (true);

-- 3. MÉTRICAS: El sistema puede actualizar métricas
create policy "Office access: All Metrics" on public.production_metrics for all using (true);

-- 4. EQUIPO: Lectura pública del organigrama
create policy "Office access: Select Team" on public.team_members for select using (true);
