# 🚀 Guía de Despliegue en Vercel (Híbrido)

He preparado el proyecto para que puedas desplegar el Frontend en Vercel mientras mantienes los agentes potentes.

## Paso 1: Subida a Vercel
1.  Entra en [Vercel.com](https://vercel.com) y conecta tu repositorio de GitHub.
2.  Importa el proyecto `IAmazingContentSpace`.
3.  Vercel detectará automáticamente el archivo `vercel.json` que he creado.

## Paso 2: Configuración del Backend (Agents)
Debido a que los agentes tardan más de 10 segundos en responder, Vercel (en su plan gratuito) cortará la conexión si intentamos correr los agentes directamente allí.

### Tienes 2 opciones recomendadas:

**Opción A: Ejecución Local (Túnel)**
Mantén `server.py` corriendo en tu computadora y usa un túnel (como Cloudflare Tunnel o ngrok) para que Vercel pueda hablar con tu PC de forma segura.

**Opción B: Railway.app (Recomendado para 24/7)**
Railway es como Vercel pero sin límites estrictos de tiempo.
1.  Sube el mismo repositorio a Railway.
2.  Railway leerá el `requirements.txt` y pondrá a los agentes a trabajar.

## Paso 3: Variables de Entorno
En el panel de Vercel/Railway, debes añadir estas variables:
- `GROQ_API_KEY`: Tu llave de Groq.
- `SUPABASE_URL`: Tu URL de base de datos.
- `SUPABASE_ANON_KEY`: Tu llave pública de Supabase.

---
> [!TIP]
> Si prefieres mantenerlo simple, podemos seguir usando el servidor local como hasta ahora. ¡El sistema ya es 100% funcional así!
