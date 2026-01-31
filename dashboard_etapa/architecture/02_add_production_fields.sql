-- 🏗️ ARCHITECTURE: 02_ADD_PRODUCTION_FIELDS.SQL
-- Protocolo E.T.A.P.A. - Fase A (Evolución)
-- Ejecutar en SQL Editor de Supabase

-- 1. Añadir campo para el link del video/entrega
alter table public.projects 
add column if not exists production_url text;

-- 2. Asegurar que los permisos RLS cubran la nueva columna (ya lo hacen con 'for update', pero por si acaso)
comment on column public.projects.production_url is 'Link de Google Drive o Dropbox con el entregable del proyecto';
