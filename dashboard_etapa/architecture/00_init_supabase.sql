-- 🏗️ ARCHITECTURE: 00_INIT_SUPABASE.SQL
-- Protocolo E.T.A.P.A. - Fase A (Arquitectura)
-- Ejecutar en SQL Editor de Supabase

-- 1. Habilitar UUIDs
create extension if not exists "uuid-ossp";

-- 2. ENUMS (Tipos de datos estrictos)
create type client_type as enum ('creator', 'pyme', 'agency', 'blackmarket');
create type client_tier as enum ('creator_15', 'pyme_100', 'agency_500', 'blackmarket_flex');
create type client_status as enum ('active', 'inactive', 'lead');
create type team_role as enum ('pm', 'coord_prod', 'sales_head', 'editor_sr', 'editor_std', 'designer', 'sales_intern', 'ai_bot');
create type service_type as enum ('video', 'reel', 'thumbnail', 'pack');
create type project_status as enum ('briefing', 'production', 'qc', 'review', 'completed');

-- 3. TABLA: CLIENTS
create table public.clients (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  type client_type not null default 'creator',
  tier client_tier not null default 'creator_15',
  whatsapp text unique not null,
  email text,
  status client_status default 'lead',
  metadata jsonb default '{}'::jsonb,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 4. TABLA: TEAM_MEMBERS
create table public.team_members (
  id uuid primary key default uuid_generate_v4(),
  supabase_user_id uuid references auth.users(id), -- Link opcional a auth
  first_name text not null,
  role team_role not null,
  specialty text,
  max_capacity int default 3,
  active boolean default true,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 5. TABLA: PROJECTS
create table public.projects (
  id uuid primary key default uuid_generate_v4(),
  client_id uuid references public.clients(id) on delete set null,
  assigned_to uuid references public.team_members(id) on delete set null,
  service_type service_type not null,
  status project_status default 'briefing',
  priority int default 3 check (priority between 1 and 5),
  deadline timestamp with time zone,
  delivered_at timestamp with time zone,
  metrics jsonb default '{}'::jsonb,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 6. TABLA: PRODUCTION_METRICS
create table public.production_metrics (
  date date primary key default current_date,
  total_projects int default 0,
  completed_projects int default 0,
  revenue float default 0,
  avg_cycle_time float default 0
);

-- 7. SEGURIDAD (RLS) - Nivel Inicial
alter table public.clients enable row level security;
alter table public.team_members enable row level security;
alter table public.projects enable row level security;
alter table public.production_metrics enable row level security;

-- Política de lectura global para usuarios autenticados (Ajustar en producción)
create policy "Enable read access for authenticated users" on public.clients for select to authenticated using (true);
create policy "Enable read access for authenticated users" on public.team_members for select to authenticated using (true);
create policy "Enable read access for authenticated users" on public.projects for select to authenticated using (true);
create policy "Enable read access for authenticated users" on public.production_metrics for select to authenticated using (true);

-- Política de escritura (Solo servicio o admins - Ajustar luego)
-- Por ahora, permitimos insert a autenticados para facilitar el setup inicial
create policy "Enable insert for authenticated users" on public.clients for insert to authenticated with check (true);
create policy "Enable insert for authenticated users" on public.team_members for insert to authenticated with check (true);
create policy "Enable insert for authenticated users" on public.projects for insert to authenticated with check (true);

-- 8. DATOS SEMILLA (SEED DATA) - ESTRUCTURA BASE
insert into public.team_members (first_name, role, specialty) values 
('Marco', 'pm', 'Management'),
('Josué', 'coord_prod', 'Quality Control'),
('Bobby', 'sales_head', 'Sales'),
('Pedro', 'editor_sr', 'Premium Editing'),
('Charlotte', 'editor_std', 'Standard Editing'),
('Emeve', 'editor_std', 'Intern Support'),
('Yara', 'designer', 'Graphic Design'),
('Isaac', 'sales_intern', 'Outreach'),
('Antigravity', 'ai_bot', 'Automation'),
('IA Editor', 'ai_bot', 'Pre-editing'),
('RenderBot', 'ai_bot', 'Rendering');

