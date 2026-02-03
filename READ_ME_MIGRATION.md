# ⚠️ ACCIÓN REQUERIDA: Migración de Base de Datos

Para que el nuevo sistema de entregas y facturación automática funcione, es **IMPERATIVO** que actualices tu base de datos en Supabase.

## Pasos a seguir:

1.  Abre tu proyecto en [Supabase Dashboard](https://supabase.com/dashboard).
2.  Ve a la sección **SQL Editor**.
3.  Crea una nueva consulta (Query).
4.  Copia y pega TODO el contenido del archivo `MIGRATION_SCHEMA_SOTA.sql` que he creado en esta carpeta.
5.  Haz clic en **Run**.

## ¿Qué hará esto?
- Creará la tabla `deliveries` optimizada.
- Habilitará el cálculo automático de precios (por minuto o fijos).
- Preparará el sistema para las notificaciones de WhatsApp.

**NOTA**: El frontend (`index.html`) ya ha sido actualizado para usar esta nueva tabla. Si no ejecutas el SQL, verás errores en el dashboard.
