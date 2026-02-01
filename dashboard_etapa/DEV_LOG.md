# 📓 REGISTRO DE DESARROLLO (DEV_LOG)
> **Proyecto:** Dashboard de Control Inteligente IAmazing
> **Tecnología Principal:** Supabase + HTML/JS (Zero-Install)
> **Metodología:** E.T.A.P.A (Estrategia, Tests, Arquitectura, Pulido, Automatización)

---

## [2026-01-30] - Sesión de Nacimiento y MVP
**Hito:** Del concepto a la herramienta operativa.

### 🎯 Estrategia (Fase E)
-   **Decisión:** Migración de Prisma local a **Supabase** para permitir acceso multi-usuario en la oficina sin despliegues complejos.
-   **Definición:** Mapeo de 11 departamentos (8 humanos + 3 agentes IA) como usuarios base.
-   **Schema:** Creación de tablas `clients`, `team_members`, `projects`, `production_metrics`.

### 🧪 Tests (Fase T)
-   **Verificación:** Handshake exitoso con la base de datos Supabase usando PowerShell.
-   **Descubrimiento:** El entorno del cliente no cuenta con Node.js pré-instalado.
-   **Corrección:** Se descarta Next.js en favor de un **Dashboard Portable (Single HTML File)**.

### 🏗️ Arquitectura (Fase A)
-   **SOPs:** Creación de manuales deterministas para Ciclo de Vida, Ventas y Control de Calidad (QC).
-   **Tools:** Implementación de scripts de gestión (`manage_clients.ps1`, `manage_projects.ps1`, `calc_metrics.ps1`).

### 🎨 Pulido (Fase P)
-   **Frontend:** Desarrollo de `dashboard.html` con Tailwind CSS y Supabase SDK.
-   **Fix Técnico:** Corrección de error de sombreado de variables (`let supabaseClient`) y eliminación de módulos ES para soporte total en protocolo `file://`.
-   **Seguridad:** Implementación de políticas RLS en Supabase para permitir acceso `ANON` desde la oficina.

## [2026-01-31] - Control Operativo Activo
**Hito:** El dashboard deja de ser pasivo para convertirse en el mando de la agencia.

### 🎯 Evolución (Fase P+)
-   **Funcionalidad:** Implementación de botones de transición de estado (`💻 Empezar`, `👀 Revisar`, `🚀 Entregar`).
-   **Gestión de Datos:** Añadida columna `production_url` en la tabla `projects` para centralizar links de Drive/Dropbox.
-   **Asignación:** Creado modal de edición para asignar editores específicos a cada proyecto desde la UI.
-   **UX:** Mejorada la legibilidad del equipo y real-time optimizado.

### ✅ Validación
- [x] Transición de estados (Briefing -> Production -> QC -> Completed) funcionando.
- [x] Persistencia de links de video.
- [x] Asignación dinámica de miembros del equipo.

---

## [2026-01-31] - Sesión Beta: Automatización y Finanzas
**Hito:** Implementación del Módulo de Gastos y Optimizaciones UX.

### 🏗️ Arquitectura (Fase A+)
-   **Schema:** Desplegada tabla `project_payments` para seguimiento financiero.
-   **Schema:** Añadida columna `raw_assets_url` a `projects`.
-   **Tools:** Actualizado script `deploy_v3.ps1` para manejo robusto de SQL via API.

### 🎨 Pulido (Fase P+)
-   **Finanzas:** Nueva sección "Pagos y Gastos" con historial de transacciones y balances por editor.
-   **UX:** Iconografía diferenciada para Brutos (📁) y Videos Finales (🎬).
-   **Gestión:** Modal de pagos integrado directamente en las tarjetas de proyecto.

### 🤖 Automatización (Fase T+)
-   **Webhooks:** Implementada lógica de notificaciones vía WhatsApp para cambios a estados `QC` y `Completed`.

---

## [2026-01-31] - Optimización Operativa (Vibe v2)
**Hito:** El dashboard evoluciona a una Single-Page App (SPA) interactiva.

### 🏗️ Arquitectura (Fase A++)
-   **Interacción:** Integración de `SortableJS` para flujo de trabajo basado en Drag & Drop.
-   **IA:** Evolución de Cortex a v2 con lógica de auditoría financiera y operativa.
-   **Feedback:** Sistema de notificaciones *Toast* para validación de acciones sin interrupciones.

### 🎨 Pulido (Fase P++)
-   **UX:** Filtros de búsqueda y cliente en tiempo real.
-   **Visual:** Gradientes dinámicos y animaciones "pulse" para proyectos de prioridad urgente.
-   **Clean Code:** Resolución de advertencias de linter y optimización de selectores.

### ✅ Validación Final
- [x] Drag & Drop funcional con persistencia en Supabase.
- [x] Cortex responde a consultas de balances y equipo.
- [x] Toasts confirman cada acción exitosa.

---

## [2026-01-31] - Fase 3: Escritorios Personales & Roles
**Hito:** Segregación inteligente de información y personalización de Cortex.

### 🏗️ Arquitectura (Fase A+++)
-   **Identidad:** Implementado sistema de "Zero-Auth" para identificación local persistente.
-   **Roles:** Definición de niveles de acceso (CEO, Supervisor, Operador).
-   **Segregación:** Creada la vista "Mi Escritorio" con filtros automáticos por `assigned_to`.

### 🎨 Pulido (Fase P+++)
-   **Finanzas:** Cada editor puede ver su balance acumulado de pagos directamente en su escritorio.
-   **IA:** Cortex v3 ahora reconoce al usuario, saludando por nombre y dando reportes específicos al rol.
-   **UX:** Sidebar dinámico que oculta/muestra secciones gerenciales según el perfil.

### ✅ Validación Final
- [x] Selector de perfiles funcional y persistente.
- [x] Filtro de proyectos por editor en "Mi Escritorio".
- [x] Cortex responde contextualmente al usuario activo.
- [x] **FASE 3.1: Refinamiento de Procesos**
    - [x] Bolsa de Tareas (Pull System).
    - [x] Sistema de Checklist/Feedback en tiempo real.
    - [x] Lógica de Auto-Prioridad visual.
    - [x] Bloqueador de entrega (Action Blocker).
    - [x] Limpieza y sanitización de código en `dashboard.html`.

---

## [2026-01-31] - Fase 3.2: IA Avanzada & Interactividad
**Hito:** Dashboard 100% interactivo con Drag & Drop y Cortex inteligente.

### 🏗️ Arquitectura (Fase A++++)
-   **Interacción:** Implementado `SortableJS` con persistencia en Supabase para el flujo Kanban.
-   **Finanzas:** Completado el flujo de registro de pagos y gestión de nuevos clientes.

### 🎨 Pulido (Fase P++++)
-   **Cortex AI:** Ahora lee checklists, deadlines y disponibilidad del equipo. Es una herramienta de consulta en tiempo real.
-   **UX:** Botón de pago integrado en tarjetas finalizadas para perfiles gerenciales.

### ✅ Validación Final
- [x] Drag & Drop actualiza estados y revierte si hay bloqueadores (p.ej. falta de URL).
- [x] Registro de clientes y pagos funcionando con persistencia.
- [x] Cortex responde proactivamente sobre feedback pendiente.

---

## [2026-01-31] - Fase 4: Métricas & Rendimiento (Analytics)
**Hito:** Lanzamiento del módulo de analítica predictiva y control de eficiencia.

### 🏗️ Arquitectura (Fase A+++++)
-   **Integración:** Integración de `Chart.js` para visualización de datos.
-   **Datos:** Implementada captura automática de `delivered_at` al completar proyectos para cálculo de Lead Time.

### 🎨 Pulido (Fase P+++++)
-   **UX:** Nueva vista "Métricas" con gráficas dinámicas de Revenue y Volumen por Cliente.
-   **Métricas:** Implementada lógica de cálculo de Lead Time Promedio y Tasa de Aprobación inicial.

### ✅ Validación Final
- [x] Gráficas se renderizan correctamente con datos reales de Supabase.
- [x] Lead Time calculado en base a timestamps de creación y entrega.
- [x] Navegación segregada funcional.

---

## [2026-01-31] - Fase 4.1: Seguridad Operativa (Auth)
**Hito:** Implementación de sistema de login con contraseñas gestionadas.

### 🏗️ Arquitectura (Fase A++++++)
-   **Seguridad:** Añadido campo `password` a la tabla `team_members`.
-   **Auth:** Implementado flujo de login en 2 pasos (Selección de Perfil -> Password).

### 🎨 Pulido (Fase P++++++)
-   **Administración:** Nueva vista "Gestión de Equipo" donde los managers pueden asignar o cambiar contraseñas de los empleados.
-   **UX:** Mejorada la segregación de vistas para que empleados solo vean sus herramientas y managers tengan control total.

### ✅ Validación Final
- [x] Login requiere contraseña correcta para entrar.
- [x] Managers pueden cambiar contraseñas y se reflejan en tiempo real.
- [x] Persistencia de sesión protegida por validación de ID en Supabase.

---

## 📝 Próximas Entradas (Pendiente)
-   [ ] Soporte para adjuntos múltiples en proyectos.
-   [ ] Modo Oscuro/Claro configurable.
-   [ ] Integración con Google Sheets para exportación de datos.
