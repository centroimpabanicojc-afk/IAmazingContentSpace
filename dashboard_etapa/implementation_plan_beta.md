# 📝 PLAN DE IMPLEMENTACIÓN: FASE BETA (Automatización y Finanzas)

Este plan detalla los pasos para completar los objetivos "MUST" del Roadmap y las tareas pendientes en el registro de desarrollo.

## 1. Módulo de Gastos (Pagos a Editores)
**Objetivo:** Permitir el seguimiento financiero de lo adeudado a cada editor por proyecto.

- [ ] **A. Preparación de Arquitectura:**
    - Asegurar que la tabla `project_payments` esté operativa (basada en `03_expenses_schema.sql`).
- [ ] **B. Interfaz de Usuario (UI):**
    - Añadir una nueva sección/pestaña "Pagos" en `dashboard.html`.
    - Crear un Modal para "Registrar Pago" vinculado a un `project_id`.
    - Mostrar un resumen de balances pendientes por miembro del equipo.
- [ ] **C. Lógica de Negocio:**
    - Implementar la función `loadPayments()` para visualizar datos financieros.
    - Implementar `registerPayment()` para insertar registros en Supabase.

## 2. Automatización WhatsApp (Webhooks)
**Objetivo:** Notificar al cliente automáticamente cuando su video entra en revisión (QC) o está listo (Completed).

- [ ] **A. Configuración de Disparadores:**
    - Añadir una función en el Dashboard que detecte el cambio de estado.
    - Configurar una URL de Webhook (n8n/Make) en las variables de entorno o constantes.
- [ ] **B. Implementación:**
    - Crear la función `sendWhatsAppNotification(project, type)`.
    - Integrar la llamada en el flujo de `updateStatus`.

## 3. Optimización Kanban (UX Avanzada)
**Objetivo:** Hacer la gestión más fluida y visual.

- [ ] **A. Gestión de Brutos (Assets):**
    - Añadir columna `raw_assets_url` a la tabla `projects` (SQL).
    - Actualizar la UI para mostrar íconos diferenciados: 📁 (Brutos) y 🎬 (Final).
- [ ] **B. Drag & Drop Visual (Opcional pero recomendado):**
    - Evaluar la integración de una librería ligera o drag-and-drop nativo para mover tarjetas entre columnas.

---

## 📅 Cronograma Sugerido
1. **Hoy (Mañana):** Módulo de Gastos completo y Registro de Archivos.
2. **Hoy (Tarde):** Lógica de Webhooks para WhatsApp.
3. **Siguiente:** Pulido de UX y Preparación para CORTEX.

**¿Deseas que proceda con la implementación del Módulo de Gastos ahora mismo?**
