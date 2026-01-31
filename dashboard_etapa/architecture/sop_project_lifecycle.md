# 📄 SOP: CICLO DE VIDA DEL PROYECTO (E.T.A.P.A)
> **Ref:** architecture/sop_project_lifecycle.md
> **Versión:** 1.0

## 1. OBJETIVO
Definir el flujo determinista de un proyecto creativo en la base de datos para asegurar el control total por parte de los supervisores (Marco/Josué).

## 2. ETAPAS Y ESTADOS (PROYECTO)

### E - ENTRADA (Briefing)
*   **Estado:** `briefing`
*   **Acción:** Registro en tabla `projects`.
*   **Trigger:** Input de cliente (Manual o WhatsApp API).
*   **Dato Requerido:** `client_id`, `service_type`, `priority`.

### T - TRABAJO (Producción)
*   **Estado:** `production`
*   **Acción:** Asignación a un miembro del equipo (`assigned_to`).
*   **Trigger:** Cambio manual en dashboard o asignación por `ai_bot`.
*   **Actores:** Editores, Diseñadores.

### A - APROBACIÓN (Quality Control)
*   **Estado:** `qc`
*   **Acción:** Revisión por Josué.
*   **Trigger:** Editor marca como "Listo para Revisión".
*   **Salida:** `Aprobado` (pasa a `review`) o `Rechazado` (regresa a `production`).

### P - PUBLICACIÓN (Entrega)
*   **Estado:** `review` -> `completed`
*   **Acción:** Entrega al cliente y aprobación final.
*   **Trigger:** Cliente da el OK.
*   **Dato Final:** `delivered_at`, registro en `activity_log`.

### A - ANÁLISIS (Métricas)
*   **Estado:** `completed`
*   **Acción:** Actualización automática de `production_metrics`.
*   **Trigger:** Al completar proyecto.

## 3. REGLAS DE NEGOCIO (INVARIANTES)
1.  Un proyecto no puede pasar a `qc` si no tiene un editor asignado.
2.  Solo el rol `coord_prod` o `pm` puede mover un proyecto de `qc` a `review`.
3.  Todo cambio de estado debe generar un registro en `activity_log`.

## 4. MAPEADO DE ERRORES
*   **Error 404 (Client Not Found):** Bloquear creación de proyecto.
*   **Error 403 (Unauthorized Role):** Bloquear transición de estado.
