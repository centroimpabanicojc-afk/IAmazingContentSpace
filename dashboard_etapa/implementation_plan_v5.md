# Plan de Implementación: IAmazing Dashboard - Fase 3.2 (Interacción & IA Avanzada)

Este plan detalla los pasos para completar las funciones planificadas y mejorar la inteligencia del dashboard.

## 1. Implementación de Drag & Drop (SortableJS)
- [ ] Definir la función `initSortable` en `dashboard.html`.
- [ ] Configurar los contenedores de Kanban (`col-briefing`, `col-production`, `col-qc`, `col-completed`) para permitir el arrastre.
- [ ] Implementar el evento `onEnd` para actualizar el estado del proyecto en Supabase tras el movimiento.
- [ ] Asegurar que el movimiento a "Completado" siga activando el bloqueador de seguridad (si falta la URL).

## 2. Evolución de Cortex AI (Inteligencia Operativa)
- [ ] Actualizar `sendCortex` para que pueda:
    - [ ] Informar sobre ítems pendientes en el `checklist` de feedback del usuario.
    - [ ] Responder sobre la disponibilidad del equipo (quién tiene menos tareas).
    - [ ] Reportar sobre proyectos que están por expirar (Deadlines < 24h).
- [ ] Mejorar el prompt de Cortex para que sea más proactivo y contextual.

## 3. Pulido de UI/UX
- [ ] Asegurar que las animaciones de "Auto-Prioridad" funcionen correctamente en todas las vistas.
- [ ] Refinar los modales de edición para que sean más intuitivos.
- [ ] Verificar la persistencia del sistema de roles tras las recargas.

## 4. Validación & Entrega
- [ ] Probar el flujo de arrastre manual entre columnas.
- [ ] Probar consultas de IA sobre feedback y deadlines.
- [ ] Generar `Walkthrough_v5_Interactive_AI.md`.
- [ ] Actualizar `CODEBASE_MAP.md` y `DEV_LOG.md`.
