# Walkthrough: IAmazing Dashboard - Fase 4.1: Seguridad Operativa (Auth)

Este documento detalla la implementación del nuevo sistema de seguridad que permite a la gerencia controlar el acceso de los empleados mediante contraseñas personalizadas.

## 🔐 Nuevas Funcionalidades de Seguridad

### 1. Sistema de Login en 2 Pasos
*   **Paso 1: Selección de Perfil.** El empleado selecciona su nombre de la lista visual (como antes).
*   **Paso 2: Autenticación por Password.** El sistema solicita una contraseña asignada por la gerencia. Solo tras introducir la clave correcta se permite el acceso al dashboard.
*   **Persistencia Segura:** El sistema valida que el ID guardado en local corresponda a un usuario existente en la base de datos con cada carga de página.

### 2. Panel de Gestión de Equipo (Solo Managers)
*   **Nueva Vista:** En el sidebar ha aparecido la opción "Equipo".
*   **Administración Centralizada:** Desde aquí, Marco o Josué pueden ver la lista completa de empleados y sus contraseñas actuales.
*   **Actualización en Caliente:** Puedes cambiar la contraseña de cualquier empleado directamente en la tabla. El cambio es instantáneo y el empleado deberá usar la nueva clave la próxima vez que inicie sesión.

### 3. Segregación de Vistas Reforzada
*   **Home Dinámico:** Si un editor entra, el sistema lo redirige automáticamente a "Mi Escritorio" y oculta las herramientas de gestión (Métricas, Equipo, Pagos) para evitar distracciones y proteger datos sensibles.

## 🛠️ Cambios Técnicos
- **Base de Datos:** Nueva columna `password` en `team_members` (Migration `06_auth_expansion.sql`).
- **UI:** Reestructuración del `login-modal` con lógica de pasos (`showLoginStep`).
- **JS:** Implementación de `attemptLogin()` con validación persistente.
- **JS:** Nueva función `updatePassword()` que sincroniza cambios con Supabase.

## 🧪 Cómo empezar
1.  **Contraseña Inicial:** Por defecto, todos los usuarios tienen la clave `IAmazing2026`.
2.  **Cambio de Clave:** Ve a la sección "Equipo" y cambia tu contraseña o la de tus compañeros por seguridad.
3.  **Cierre de Sesión:** Si deseas probar el login, limpia el `localStorage` o simplemente usa el sistema de cambio de contraseña para validar que el login la pida de nuevo.

## 🚀 Próximos Pasos
*   Integración de archivos adjuntos múltiples.
*   Modo Oscuro/Claro.
