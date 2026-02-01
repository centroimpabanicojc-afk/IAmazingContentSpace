# 🚀 IAmazing Content Documentation

> **Sistema de Control Operativo Inteligente para Agencias de Contenido**

Dashboard web portable de gestión de proyectos con inteligencia artificial integrada, diseñado específicamente para agencias de producción de contenido audiovisual.

---

## ✨ Características Principales

- 🎯 **Gestión Visual de Proyectos** - Sistema Kanban con Drag & Drop
- 🤖 **Cortex AI** - Asistente inteligente para auditorías y consultas operativas
- 👥 **Sistema de Roles** - CEO, Supervisor, Operador con permisos diferenciados
- 💰 **Módulo Financiero** - Seguimiento de pagos y balances por proyecto
- 📊 **Analytics en Tiempo Real** - Métricas de rendimiento y gráficas con Chart.js
- 🔐 **Autenticación Segura** - Sistema de login con contraseñas gestionadas
- 📱 **Zero-Install** - Funciona directamente desde el navegador (archivo HTML portable)

---

## 🏗️ Arquitectura

Este proyecto utiliza el stack **E.T.A.P.A** (Estrategia, Tests, Arquitectura, Pulido, Automatización):

### Stack Tecnológico
- **Frontend**: HTML5 + TailwindCSS + JavaScript Vanilla
- **Backend**: Supabase (PostgreSQL + Auth + Real-time)
- **Librerías**:
  - [Supabase JS Client](https://supabase.com/docs/reference/javascript/introduction) - Base de datos en tiempo real
  - [SortableJS](https://sortablejs.github.io/Sortable/) - Drag & Drop
  - [Chart.js](https://www.chartjs.org/) - Visualización de datos
  - [Lucide Icons](https://lucide.dev/) - Iconografía

### Estructura del Proyecto

```
IAmazingContentDocumentation/
├── dashboard_etapa/           # Dashboard principal
│   ├── ui/
│   │   ├── dashboard.html     # Aplicación principal (archivo único)
│   │   ├── config.js          # ⚠️ Credenciales (NO incluido en repo)
│   │   └── config.example.js  # Plantilla de configuración
│   ├── architecture/          # Migraciones SQL de Supabase
│   ├── tools/                 # Scripts de gestión (PowerShell)
│   └── DEV_LOG.md            # Historial de desarrollo
├── E.T.A.P.A/                # Metodología y SOPs
├── knowledge/                # Base de conocimiento
└── README.md                 # Este archivo
```

---

## 🚀 Inicio Rápido

### Requisitos Previos
- Navegador moderno (Chrome, Edge, Firefox, Safari)
- Cuenta de [Supabase](https://supabase.com) (gratuita)
- Conexión a internet

### Paso 1: Configurar Supabase

1. Crea un proyecto en [Supabase](https://app.supabase.com)
2. Ejecuta las migraciones SQL en orden desde `/dashboard_etapa/architecture/`:
   ```
   00_init_supabase.sql
   01_fix_permissions.sql
   02_add_production_fields.sql
   03_expenses_schema.sql
   04_kanban_assets.sql
   05_checklist_and_feedback.sql
   06_auth_expansion.sql
   ```

### Paso 2: Configurar Credenciales

1. Copia el archivo de ejemplo:
   ```bash
   cp dashboard_etapa/ui/config.example.js dashboard_etapa/ui/config.js
   ```

2. Edita `config.js` con tus credenciales de Supabase:
   ```javascript
   const SUPABASE_CONFIG = {
       URL: "https://tu-proyecto.supabase.co",
       ANON_KEY: "tu_clave_publica_aqui"
   };
   ```

   > 💡 Encuentra tus credenciales en: Supabase Dashboard → Settings → API

### Paso 3: Ejecutar

1. Navega a `dashboard_etapa/ui/`
2. Abre `dashboard.html` en tu navegador
3. ¡Listo! El dashboard cargará automáticamente

---

## 📖 Documentación

- **[DEV_LOG.md](dashboard_etapa/DEV_LOG.md)** - Historial completo de desarrollo
- **[ROADMAP.md](dashboard_etapa/ROADMAP.md)** - Hoja de ruta del proyecto
- **[Walkthroughs](dashboard_etapa/)** - Guías de cada fase de implementación
- **[README_OFFICE.md](dashboard_etapa/ui/README_OFFICE.md)** - Guía para usuarios finales

---

## 🎨 Características Detalladas

### Sistema Kanban Inteligente
- Transiciones automáticas de estado con validaciones
- Bloqueadores de acción (no puedes entregar sin URL de video)
- Auto-prioridad visual basada en fechas límite
- Persistencia en tiempo real con Supabase

### Cortex AI (Asistente Inteligente)
Pregunta a Cortex cosas como:
- *"¿Qué feedback tengo pendiente?"*
- *"¿Quién está libre en el equipo?"*
- *"¿Qué proyectos vencen pronto?"*
- *"Dame el balance de pagos de [Editor]"*

### Módulo de Finanzas
- Registro de pagos vinculados a proyectos
- Balance acumulado por editor
- Historial de transacciones
- Vista de ingresos por cliente

### Sistema de Roles
- **CEO/Manager**: Acceso total, gestión de equipo, métricas
- **Supervisor**: Vista completa, sin gestión de usuarios
- **Operador**: Vista personal ("Mi Escritorio")

---

## 🔒 Seguridad

- ✅ Row Level Security (RLS) configurado en Supabase
- ✅ Autenticación con contraseñas encriptadas
- ✅ Credenciales en archivos locales (no incluidos en el repo)
- ✅ Políticas de acceso por rol

> ⚠️ **IMPORTANTE**: Nunca compartas tu archivo `config.js` o `.env` públicamente

---

## 🛠️ Scripts de Gestión

El proyecto incluye scripts PowerShell para operaciones comunes:

```powershell
# Gestión de clientes
.\tools\manage_clients.ps1

# Gestión de proyectos
.\tools\manage_projects.ps1

# Cálculo de métricas
.\tools\calc_metrics.ps1

# Despliegue de schemas
.\tools\deploy_schema.ps1
```

---

## 🤝 Contribuir

Este es un proyecto privado de IAmazing. Si eres parte del equipo:

1. Clona el repositorio
2. Configura tu `config.js` local
3. Crea una rama para tu feature: `git checkout -b feature/nueva-funcionalidad`
4. Commit tus cambios: `git commit -m 'Descripción del cambio'`
5. Push a la rama: `git push origin feature/nueva-funcionalidad`
6. Abre un Pull Request

---

## 📝 Metodología E.T.A.P.A

Este proyecto fue desarrollado siguiendo la metodología **E.T.A.P.A**:

- **E**strategia: Definición de requerimientos y arquitectura
- **T**ests: Validación de conectividad y funcionalidad
- **A**rquitectura: Diseño de base de datos y estructura
- **P**ulido: Desarrollo de UI/UX premium
- **A**utomatización: Integración de IA y workflows automáticos

Lee más en [E.T.A.P.A/README.md](E.T.A.P.A/README.md)

---

## 📊 Estado del Proyecto

**Versión**: 4.1 (Auth Expansion)  
**Estado**: ✅ Producción (Fase Alpha Completada)  
**Última actualización**: 31 de Enero, 2026 (Sincronización Automática Activada 🚀)

### Fases Completadas
- [x] Fase Alpha: MVP Operativo
- [x] Fase Beta: Automatización y Finanzas
- [x] Fase 2: Optimización Operativa (Drag & Drop)
- [x] Fase 3: Escritorios Personales y Roles
- [x] Fase 3.1: Refinamiento de Procesos
- [x] Fase 3.2: IA Avanzada e Interactividad
- [x] Fase 4: Métricas y Analytics
- [x] Fase 4.1: Seguridad Operativa (Auth)

### Próximas Fases
- [ ] Integración n8n/WhatsApp para notificaciones
- [ ] Reportes PDF automáticos
- [ ] Modo oscuro/claro configurable

---

## 📄 Licencia

Proyecto propietario de **IAmazing Content Agency**. Todos los derechos reservados.

---

## 💬 Soporte

Para soporte interno del equipo, contacta al administrador del sistema o revisa la documentación en `/knowledge/`.

---

<div align="center">
  <strong>Hecho con 💜 por el equipo de IAmazing</strong>
</div>
