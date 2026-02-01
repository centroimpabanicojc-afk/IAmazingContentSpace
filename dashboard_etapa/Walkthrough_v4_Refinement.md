# Walkthrough: IAmazing Dashboard - Fase 3.1: Refinamiento de Procesos y Flujo de Trabajo

Este documento detalla las mejoras de flujo de trabajo implementadas para optimizar la operación de la agencia, mejorar la calidad de las entregas y reducir el cuello de botella gerencial.

## ✅ Objetivos Cumplidos

1.  **Pull System (Bolsa de Tareas):** Implementación de una sección en "Mi Escritorio" para que los editores puedan auto-asignarse proyectos sin intervención manual del manager.
2.  **Checklist de Feedback (QC):** Integración de un sistema de notas tipo checklist en las tarjetas de proyecto (visibles en QC) para que los supervisores dejen correcciones accionables.
3.  **Auto-Prioridad (Deadlines):** Identificación visual automática de proyectos que vencen en menos de 24 horas (Bordes rojos animados y flag de urgencia).
4.  **Action Blockers (Seguridad):** Bloqueo técnico que impide mover un proyecto a "Completado" si no se ha ingresado el link de entrega final.

## 🛠️ Cambios Técnicos

### 1. Backend & Esquema
*   **Archivo:** `architecture/05_checklist_and_feedback.sql`
*   **Acción:** Se añadió la columna `checklist` (JSONB) a la tabla `projects` para almacenar dinámicamente los items de feedback.

### 2. Frontend & UI (`ui/dashboard.html`)
*   **Gestión de Datos:**
    *   `loadDashboard`: Ahora calcula el flag `is_expiring` basándose en el campo `deadline`.
    *   `createCard`: Modificada para renderizar el checklist y el botón "Tomar Proyecto" según el contexto.
*   **Lógica de Flujo:**
    *   `claimProject`: Permite la auto-asignación y cambia el estado a 'production'.
    *   `updateStatus`: Incluye validación de `production_url` antes de permitir el cierre.
    *   `toggleCheckItem` / `addCheckItem`: Funciones de persistencia para el sistema de feedback.
*   **Identidad Visual:**
    *   Implementación de clases CSS `priority-5` (Urgente) y efectos de pulsación para deadlines próximos.

## 🧪 Validación (Manual & Logic Check)

*   **Bolsa de Tareas:** Los proyectos en 'briefing' y 'sin asignar' aparecen correctamente en el pool del editor.
*   **Checklist:** Al estar en estado 'QC', aparece el input para añadir notas. Al marcar/desmarcar, se actualiza la base de datos en tiempo real.
*   **Bloqueador:** Al intentar "Entregar" un video sin link, el sistema lanza un Toast de advertencia y detiene la acción.
*   **Auto-Prioridad:** Proyectos cercanos a su deadline destacan visualmente en el panel.

## 🚀 Siguiente Paso sugerido
*   Integrar **Cortex AI** para que pueda leer estos checklists y alertar al usuario sobre feedback pendiente en sus tareas.
