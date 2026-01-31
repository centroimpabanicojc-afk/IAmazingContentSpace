# 🔧 Guía de Configuración del Dashboard IAmazing

Esta guía te ayudará a configurar el Dashboard desde cero.

---

## 📋 Requisitos

- Navegador web moderno (Chrome, Edge, Firefox, Safari)
- Cuenta de Supabase (gratuita)
- Editor de texto (VS Code, Notepad++, etc.)

---

## 🗄️ Paso 1: Crear Proyecto en Supabase

1. **Crear cuenta en Supabase**
   - Ve a [https://supabase.com](https://supabase.com)
   - Regístrate o inicia sesión
   - Crea un nuevo proyecto

2. **Guardar credenciales**
   - En el dashboard de Supabase, ve a **Settings → API**
   - Copia:
     - Project URL (ejemplo: `https://xxxxx.supabase.co`)
     - Anon/Public Key (clave `anon public`)

---

## 📊 Paso 2: Aplicar Migraciones SQL

Ejecuta los archivos SQL en el **SQL Editor** de Supabase **en este orden**:

1. `architecture/00_init_supabase.sql` - Crea tablas base
2. `architecture/01_fix_permissions.sql` - Configura permisos RLS
3. `architecture/02_add_production_fields.sql` - Añade campos de producción
4. `architecture/03_expenses_schema.sql` - Módulo de gastos
5. `architecture/04_kanban_assets.sql` - Campos para Kanban
6. `architecture/05_checklist_and_feedback.sql` - Sistema de feedback
7. `architecture/06_auth_expansion.sql` - Sistema de autenticación

### Cómo ejecutar:
1. Abre Supabase Dashboard → **SQL Editor**
2. Click en **New Query**
3. Copia el contenido del archivo SQL
4. Click en **Run**
5. Verifica que no haya errores

---

## ⚙️ Paso 3: Configurar Credenciales

1. **Navega a** `dashboard_etapa/ui/`

2. **Crea el archivo de configuración**:
   - Copia `config.example.js` y renómbralo a `config.js`
   - O crea un nuevo archivo llamado `config.js`

3. **Edita `config.js`** con tus credenciales:

```javascript
// ⚙️ CONFIGURACIÓN DEL DASHBOARD IAMAZING
const SUPABASE_CONFIG = {
    URL: "https://TU_PROYECTO.supabase.co",      // ← Pega tu Project URL aquí
    ANON_KEY: "eyJhbGciOiJI...."                    // ← Pega tu Anon Key aquí
};

export default SUPABASE_CONFIG;
```

4. **Guarda el archivo**

> ⚠️ **IMPORTANTE**: No compartas este archivo públicamente ni lo subas a GitHub

---

## 👥 Paso 4: Crear Usuarios Iniciales

Necesitas crear al menos un miembro del equipo para poder hacer login.

### Opción A: Usando el SQL Editor de Supabase

```sql
INSERT INTO team_members (name, role, department, password)
VALUES 
  ('Admin', 'ceo', 'Gerencia', 'admin123'),
  ('Editor 1', 'operator', 'Edición', 'editor123');
```

### Opción B: Usando el script PowerShell

```powershell
cd tools
.\manage_team.ps1
```

---

## 🚀 Paso 5: Ejecutar el Dashboard

1. **Navega a** `dashboard_etapa/ui/`
2. **Abre** `dashboard.html` con doble click
3. **En el login**:
   - Selecciona tu perfil
   - Ingresa la contraseña que configuraste
4. ¡Listo! 🎉

---

## 🧪 Paso 6: Verificar Funcionamiento

Prueba estas funciones básicas:

- ✅ Login exitoso
- ✅ Se cargan los proyectos (aunque esté vacío)
- ✅ Se puede crear un nuevo proyecto
- ✅ Las vistas cambian correctamente (Dashboard, Mi Escritorio, Métricas)
- ✅ Cortex responde a preguntas

Si todo funciona, ¡la instalación fue exitosa!

---

## 🔒 Seguridad

### ⚠️ Archivo `config.js`
- **NO lo compartas** con nadie fuera del equipo
- **NO lo subas** a GitHub u otros repositorios públicos
- Mantenlo solo en tu computadora local

### 🔐 Contraseñas
Para cambiar contraseñas de usuarios:
1. Inicia sesión como **CEO** o **Manager**
2. Ve a la vista **"Gestión de Equipo"**
3. Click en el ícono de llave junto al usuario
4. Ingresa la nueva contraseña

---

## 🆘 Solución de Problemas

### El dashboard no carga / Pantalla en blanco
- Abre la **Consola del Navegador** (F12)
- Revisa si hay errores relacionados con Supabase
- Verifica que `config.js` tenga las credenciales correctas

### Error: "Invalid API Key"
- Confirma que copiaste la **Anon Key** completa (es muy larga)
- Verifica que no haya espacios extra al inicio o final

### No puedo hacer login
- Verifica que existan usuarios en la tabla `team_members`
- Confirma que la contraseña sea correcta (case-sensitive)

### Los proyectos no se cargan
- Verifica que las migraciones SQL se ejecutaron correctamente
- En Supabase, ve a **Table Editor** y confirma que existen las tablas:
  - `clients`
  - `team_members`
  - `projects`
  - `project_payments`

---

## 📞 Soporte

Si necesitas ayuda adicional:
- Revisa el archivo `DEV_LOG.md` para contexto técnico
- Consulta los `Walkthrough_vX.md` para detalles de funcionalidades
- Contacta al administrador del sistema

---

**¡Éxito con tu instalación!** 🚀
