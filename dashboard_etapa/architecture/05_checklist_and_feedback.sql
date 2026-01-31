-- 🏗️ ARCHITECTURE: 05_CHECKLIST_AND_FEEDBACK.SQL
-- Protocolo E.T.A.P.A. - Fase A (Refinamiento)

-- 1. Añadir campo para checklist de feedback en proyectos
alter table public.projects 
add column if not exists checklist jsonb default '[]'::jsonb;

comment on column public.projects.checklist is 'Lista de tareas o correcciones pendientes para el proyecto';
