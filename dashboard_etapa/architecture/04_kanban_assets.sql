-- 04_kanban_assets.sql
-- Añadir columna para archivos brutos

ALTER TABLE public.projects 
ADD COLUMN IF NOT EXISTS raw_assets_url TEXT;

COMMENT ON COLUMN public.projects.raw_assets_url IS 'URL de los archivos brutos (Drive/Dropbox/etc).';
