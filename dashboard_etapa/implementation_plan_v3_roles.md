# 🧠 PLAN DE IMPLEMENTACIÓN: ESCRITORIOS PERSONALES & ROLES (v3)

Este plan detalla la transformación del Dashboard en un sistema multi-perfil donde cada usuario tiene una experiencia a medida.

## 1. Sistema de Identidad "Zero-Auth"
Dado que el Dashboard es portátil (file://), implementaremos un selector de perfil persistente.
- [ ] **Componente:** Selector de perfil en la esquina superior derecha (Avatar + Nombre).
- [ ] **Persistencia:** Guardar el `current_user_id` en `localStorage`.
- [ ] **Handshake:** Al iniciar, si no hay usuario, forzar la selección de uno de los miembros de `team_members`.

## 2. Lógica de "Escritorios" por Rol
Modificaremos la UI para que se adapte dinámicamente:

### 👑 CEO (MARCO) - Vista Global
- **Filtro:** Ver TODO.
- **Widgets extra:** Resumen financiero (Ingresos totales, Deudas totales), Métricas de conversión.
- **Cortex:** Acceso a reportes ejecutivos.

### 👨‍💼 Supervisores (JOSUÉ, BOBBY) - Vista Departamental
- **Filtro:** Ver proyectos de su departamento o todos (coordinación).
- **Acciones:** Capacidad de re-asignar editores y cambiar prioridades.
- **Cortex:** Auditoría de cuellos de botella ("¿Quién está saturado?").

### 💻 Operativos (EDITORES, DISEÑADORES) - Escritorio Personal
- **Filtro:** "Mis Tareas" (Solo proyectos donde `assigned_to` == `current_user_id`).
- **Widgets:** Balance personal (Cuánto he ganado), Deadline más próximo.
- **Cortex:** Asistente técnico (SOPs, guías de edición).

## 3. Cortex v3: Conciencia de Contexto
- [ ] Modificar `sendCortex` para que reciba el objeto `currentUser`.
- [ ] **Respuestas Personalizadas:**
    - Si soy Editor: "Tienes 3 videos pendientes, el más urgente es del Cliente X."
    - Si soy Marco: "La agencia ha facturado $X este mes con un margen del Y%."

## 4. Estética de "Panel de Control"
- [ ] Dividir el Dashboard en "Mi Escritorio" (Vista Personal) y "Agencia" (Vista Global - Solo para Managers).
- [ ] Añadir una sección de "Feed de Actividad" para ver qué ha pasado recientemente.

---
**¿Deseas que proceda con la creación del selector de perfiles y la lógica de filtrado por rol?**
