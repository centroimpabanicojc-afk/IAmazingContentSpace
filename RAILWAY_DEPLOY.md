# 🚂 Guía de Despliegue en Railway (Backend)

Sigue estos pasos para subir tus agentes de IA a Railway.

## 1. Preparación del Repositorio
Asegúrate de tener los siguientes archivos en la raíz (ya los he creado por ti):
- `server.py`: El corazón del backend.
- `requirements.txt`: Todas las librerías necesarias (incluyendo `gunicorn`).
- `Procfile`: Instrucciones de inicio para Railway.
- `tools/`: Carpeta con todos los agentes.

## 2. Despliegue en Railway
1. Crea una cuenta en [Railway.app](https://railway.app/).
2. Haz clic en **New Project** -> **Deploy from GitHub repo**.
3. Selecciona tu repositorio.
4. **IMPORTANTE**: No despliegues todavía. Ve a la pestaña **Variables**.

## 3. Variables de Entorno
Añade estas variables en el panel de Railway:
- `GROQ_API_KEY`: Tu API Key de Groq.
- `SUPABASE_URL`: Tu URL de Supabase.
- `SUPABASE_ANON_KEY`: Tu clave anónima de Supabase.
- `PYTHON_VERSION`: `3.11` (opcional, pero recomendado).

Railway detectará automáticamente el `Procfile` y asignará un puerto dinámico mediante la variable `PORT`.

## 4. URL Pública
1. Ve a la pestaña **Settings** en Railway.
2. En la sección **Networking**, haz clic en **Generate Domain**.
3. Esa es la URL que debes pegar en los Ajustes del Dashboard de Vercel.
