# 🔐 Sistema de Módulos por Departamento

## Resumen

El dashboard IAmazing ahora cuenta con un **sistema de módulos basado en roles** que permite a cada usuario ver solo las vistas relevantes para su departamento y función.

---

## 📋 Departamentos y Roles

### 1. **Ventas** (`sales`)
**Roles:** `sales_head`, `sales_intern`

**Módulos Disponibles:**
- 📈 **Pipeline** - Gestión de leads (Nuevo → Contactado → Propuesta → Cerrado)
- 👥 **Clientes** - Lista de clientes activos y prospectos
- 💰 **Comisiones** - Historial de comisiones ganadas

**Permisos:**
- ✅ Crear y editar clientes
- ✅ Ver proyectos de sus clientes
- ✅ Ver sus comisiones
- ❌ No puede ver finanzas globales
- ❌ No puede asignar proyectos

---

### 2. **Producción Audiovisual** (`production`)
**Roles:** `coord_prod`, `editor_sr`, `editor_std`, `designer`

**Módulos Disponibles:**
- 💼 **Mi Escritorio** - Proyectos asignados personalmente
- 📦 **Tareas Disponibles** - Pool de proyectos sin asignar (sistema Pull)
- 📅 **Calendario** - Deadlines y planificación
- 💰 **Mi Balance** - Pagos personales y finanzas

**Permisos:**
- ✅ Tomar proyectos del pool
- ✅ Subir entregables (production_url)
- ✅ Solicitar feedback/QC
- ✅ Ver su balance personal
- ❌ No puede ver clientes ni ventas
- ❌ No puede aprobar pagos (solo `coord_prod` puede solicitar)

---

### 3. **I+D (Investigación y Desarrollo)** (`rd`)
**Roles:** `ai_bot`

**Módulos Disponibles:**
- 🧪 **Experimentos** - Proyectos de investigación activos
- 📚 **Base de Conocimiento** - Documentación y hallazgos
- 📊 **Métricas IA** - Performance de bots (Antigravity, IA Editor, RenderBot)

**Permisos:**
- ✅ Crear y documentar experimentos
- ✅ Acceso a datos históricos para análisis
- ❌ No puede ver finanzas
- ❌ No puede modificar proyectos en producción

---

### 4. **Administración** (`admin`)
**Roles:** `pm`

**Módulos Disponibles:**
- 📊 **Dashboard Global** - Vista de todos los departamentos
- 👥 **Equipo** - Gestión de miembros y roles
- 💰 **Finanzas** - Pagos, balances, ingresos/gastos
- 📈 **Métricas** - Análisis y reportes completos

**Permisos:**
- ✅ **Acceso total** a todos los módulos
- ✅ Aprobar miembros del equipo
- ✅ Asignar/reasignar proyectos
- ✅ Ver y aprobar pagos
- ✅ Configurar sistema

---

## 🔧 Implementación Técnica

### Archivos Creados

```
IAmazingContentDocumentation/
├── MIGRATION_DEPARTMENTS.sql          # Migración de base de datos
├── assets/
│   ├── js/
│   │   └── modules-system.js          # Lógica de permisos y navegación
│   └── css/
│       └── ux-improvements.css        # Estilos mejorados
└── modules/
    ├── sales-views.html               # Vistas de Ventas
    ├── production-views.html          # Vistas de Producción
    └── rd-common-views.html           # Vistas de I+D y Comunes
```

---

## 🚀 Pasos para Activar

### 1. Ejecutar Migración en Supabase

```sql
-- Copiar y pegar MIGRATION_DEPARTMENTS.sql en SQL Editor de Supabase
-- Esto creará:
-- - Tabla departments
-- - Tabla module_permissions
-- - Funciones check_user_permission() y get_user_modules()
-- - RLS Policies
```

### 2. Verificar Datos

```sql
-- Verificar que los departamentos se crearon
SELECT * FROM public.departments;

-- Verificar que los usuarios tienen departamento asignado
SELECT first_name, role, departments.display_name 
FROM team_members 
JOIN departments ON team_members.department_id = departments.id;

-- Verificar permisos
SELECT * FROM public.module_permissions WHERE role = 'editor_sr';
```

### 3. Deploy a Vercel

```bash
git add -A
git commit -m "feat(modules): implement role-based departmental modules"
git push origin main
```

---

## 🎯 Uso del Sistema

### Para Usuarios

1. **Login** - Ingresar con usuario y contraseña
2. **Navegación Automática** - El sidebar mostrará solo los módulos de tu departamento
3. **Áreas Comunes** - Todos tienen acceso a Notificaciones y Chat

### Para Administradores

1. **Asignar Departamento** - Al crear un usuario, se asigna automáticamente según su rol
2. **Modificar Permisos** - Editar `module_permissions` para ajustar accesos
3. **Vista Global** - El rol `pm` siempre ve todo

---

## 🔒 Seguridad

### Row Level Security (RLS)

Todas las tablas sensibles tienen políticas RLS:

```sql
-- Ejemplo: Solo ventas y admin ven clientes
CREATE POLICY "Department-based client access" ON public.clients
FOR SELECT USING (
    EXISTS (
        SELECT 1 FROM team_members tm
        JOIN departments d ON tm.department_id = d.id
        WHERE tm.id = auth.uid()
        AND (d.name IN ('admin', 'sales'))
    )
);
```

### Validación Doble

- **Frontend**: `canAccessModule()` oculta módulos no permitidos (UX)
- **Backend**: RLS policies bloquean acceso a datos (Seguridad real)

---

## 📊 Métricas de Éxito

- ✅ Cada usuario ve solo su módulo relevante
- ✅ Tiempo de carga < 2s por vista
- ✅ 0 errores de permisos en producción
- ✅ 100% de cobertura en tests de RLS

---

## 🐛 Troubleshooting

### Problema: Usuario no ve ningún módulo

**Solución:**
```sql
-- Verificar que tiene departamento asignado
SELECT * FROM team_members WHERE id = 'USER_ID';

-- Si department_id es NULL, asignar manualmente
UPDATE team_members 
SET department_id = (SELECT id FROM departments WHERE name = 'production')
WHERE id = 'USER_ID';
```

### Problema: "No tienes permiso para ver X"

**Solución:**
```sql
-- Verificar permisos del rol
SELECT * FROM module_permissions WHERE role = 'editor_sr';

-- Agregar permiso faltante
INSERT INTO module_permissions (role, module_name, can_read, can_create, can_update, can_delete)
VALUES ('editor_sr', 'projects', true, false, true, false);
```

---

## 🔄 Próximas Mejoras

- [ ] Sistema de notificaciones en tiempo real
- [ ] Chat integrado con canales por departamento
- [ ] Calendario compartido con eventos
- [ ] Biblioteca de assets común
- [ ] Reportes personalizados por departamento

---

## 📞 Soporte

Para dudas o problemas, contactar al administrador del sistema o revisar los logs en la consola del navegador.

**Versión:** 1.0.0  
**Última actualización:** 2026-02-03
