# 📝 PLAN DE IMPLEMENTACIÓN: OPTIMIZACIÓN Y CORTEX v2

Basado en el progreso actual, vamos a llevar el Dashboard al siguiente nivel de sofisticación (Vibe Coding + E.T.A.P.A).

## 1. UX Avanzada: Drag & Drop en Kanban
**Objetivo:** Permitir mover proyectos entre estados arrastrándolos físicamente.
- [ ] Integrar `SortableJS` via CDN.
- [ ] Configurar las 4 columnas (`briefing`, `production`, `qc`, `completed`) para permitir el flujo entre ellas.
- [ ] Implementar el evento `onEnd` para actualizar automáticamente el estado en Supabase cuando se suelta una tarjeta.
- [ ] Añadir feedback visual de "procesando" durante la actualización.

## 2. Cortex AI v2 (Asistente Inteligente)
**Objetivo:** Que Cortex pueda realizar cálculos y filtrado de datos complejos.
- [ ] Mejorar el motor de procesamiento de lenguaje (regex avanzado) para entender consultas como:
    - "¿Qué proyectos tiene pendientes [Editor]?"
    - "¿Cuánto le debemos a [Editor]?"
    - "Dime el estado de los proyectos de [Cliente]."
    - "¿Cuál es la prioridad más alta ahora?"
- [ ] Añadir una "personalidad" más profesional a las respuestas.

## 3. Pulido Visual y Micro-interacciones
**Objetivo:** Estética Premium y Fluidez (Skills: `ui-ux-pro-max`, `frontend-design`).
- [ ] Añadir gradientes animados a las tarjetas de "Prioridad Urgente".
- [ ] Implementar un sistema de "Toasts" (notificaciones pequeñas) para acciones exitosas (en lugar de `alert`).
- [ ] Pulir el diseño del Sidebar y los modales para que se sientan más "App Nativa".

## 4. Estabilización de Finanzas
- [ ] Asegurar que el cálculo de balances reste los pagos realizados si se implementa una tabla de "deuda vs pago". (Actualmente solo suma pagos realizados).
- [ ] Añadir filtro por fechas en la vista de pagos.

---

**¿Procedo con la implementación del Drag & Drop y la mejora de Cortex primero?**
