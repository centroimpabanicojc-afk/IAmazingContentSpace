-- 🛠️ ARCHITECTURE: 11_UNIFIED_AUTH.SQL
-- Protocolo E.T.A.P.A. - Fase A (Arquitectura)
-- Ejecutar en SQL Editor de Supabase

-- 1. Agregar columna 'password' a clients si no existe
ALTER TABLE public.clients 
ADD COLUMN IF NOT EXISTS password text DEFAULT 'client123';

-- 2. Asegurar que 'email' existe y es único para login (opcional but recommended)
-- ALTER TABLE public.clients ADD COLUMN IF NOT EXISTS email text;
-- CREATE UNIQUE INDEX IF NOT EXISTS clients_email_idx ON public.clients (email);

-- 3. Comentario descriptivo
COMMENT ON COLUMN public.clients.password IS 'Contraseña de acceso para el portal de clientes';

-- 4. RLS: Permitir que los clientes vean sus PROPIOS proyectos
-- Asumiendo que usaremos el nombre del cliente o un ID para el login local
-- Nota: Para seguridad real se recomienda Supabase Auth, esto es para el prototipo funcional.

CREATE POLICY "Clients can view their own projects" ON public.projects
FOR SELECT USING (
  EXISTS (
    SELECT 1 FROM public.clients c
    WHERE c.id = projects.client_id
    -- AND c.id = auth.uid() -- Esto sería con Supabase Auth
  )
);

-- 5. Confirmación visual
SELECT name, whatsapp, password FROM public.clients;
