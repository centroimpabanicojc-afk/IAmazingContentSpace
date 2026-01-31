# 🔌 SETUP_REQUIREMENTS.MD
> **Fase:** Tests (Preparación)
> **Objetivo:** Definir las "tuberías" necesarias antes de pasar agua.

Para activar el Dashboard E.T.A.P.A. con Supabase, necesitamos las siguientes credenciales. Por favor, obtenlas y guárdalas (no las escribas aquí en texto plano, prepáralas para un archivo `.env`).

## 1. Supabase (Core Backend)
Necesitas crear un nuevo proyecto en Supabase (o usar uno existente).
*   **Project URL:** `NEXT_PUBLIC_SUPABASE_URL`
*   **Anon Key:** `NEXT_PUBLIC_SUPABASE_ANON_KEY` (Para el cliente web)
*   **Service Role Key:** `SUPABASE_SERVICE_ROLE_KEY` (Para scripts de administración/backend, Nivel Rojo)

## 2. OpenAI / Gemini (Motor CORTEX)
Para la inteligencia del dashboard.
*   **API Key:** `OPENAI_API_KEY` o `GEMINI_API_KEY`

## 3. Configuración del Proyecto Supabase (SQL Inicial)
Como no tenemos acceso directo, he preparado el script SQL de inicialización en `architecture/00_init_supabase.sql`. Deberás ejecutar esto en el SQL Editor de Supabase dashboard.

## 4. WhatsApp Business (Futuro)
*   Dejaremos esto marcado como pendiente para la Fase 2, para no bloquear el MVP.

---
**Acción Requerida:**
1. Confirma cuando hayas creado el proyecto en Supabase.
2. Copia el contenido de `architecture/00_init_supabase.sql` y ejecútalo en Supabase.
3. Confirma cuando tengas las URLs y Keys listas.
