# 📄 SOP: CONTROL DE CALIDAD (QC)
> **Ref:** architecture/sop_quality_control.md
> **Versión:** 1.0

## 1. OBJETIVO
Garantizar que todo contenido producido cumpla con los estándares premium de IAmazing antes de ser entregado al cliente.

## 2. PROCESO DE REVISIÓN

### 1. Entrega Interna
*   **Actor:** Editor asignado (Pedro/Charlotte/Emeve).
*   **Acción:** Cambiar estado del proyecto a `qc_internal` (vía `manage_projects.ps1 -Action set_status -Status qc`).

### 2. Auditoría Creativa
*   **Actor:** Josué (Coordinador de Producción).
*   **Criterios:**
    - Ortografía y subtítulos correctos.
    - Sincronización de audio.
    - Color grade según branding.
    - Duración solicitada.

## 3. DECISIÓN DETERMINISTA
*   **Aprobado:** El Coordinador mueve el proyecto a `client_review`.
*   **Rechazado:** El Coordinador mueve el proyecto de vuelta a `production` con una nota en el `activity_log`.

## 4. REGLAS DE CONTROL
1.  **Bloqueo de Auto-Aprobación:** Un editor no puede aprobar su propio proyecto. Solo Josué o Marco tienen permisos de QC.
2.  **Tiempo de Respuesta:** El QC debe realizarse en un máximo de 4 horas hábiles tras la entrega interna.
