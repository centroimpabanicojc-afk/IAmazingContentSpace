-- 🏗️ ARCHITECTURE: 06_AUTH_EXPANSION.SQL
-- Protocolo E.T.A.P.A. - Fase A (Seguridad)

-- 1. Añadir campo de contraseña a la tabla de equipo
alter table public.team_members 
add column if not exists password text default '123123';

comment on column public.team_members.password is 'Contraseña de acceso local asignada por gerencia';

-- 2. Asegurar que los miembros existentes tengan una contraseña inicial
update public.team_members set password = '123123' where password is null;
