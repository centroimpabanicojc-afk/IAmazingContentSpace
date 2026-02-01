# Reporte de Sesión: Depuración de Dashboard (Pantalla Negra)
**Fecha:** 31 Enero 2026
**Estado:** 🛑 Pausado (Sin resolver)

## 1. El Problema
El usuario reporta una **"Pantalla Negra"** o vacía en las secciones críticas del Dashboard ("Métricas" y "Equipo"), a pesar de múltiples intentos de renderizado.

## 2. Diagnóstico Técnico

### Lo que sabemos que FUNCIONA ✅
1.  **Navegador y JS Básico:** El archivo de prueba `simple_dashboard_test.html` funcionó correctamente. Esto prueba que el navegador del usuario PUEDE ejecutar Javascript estándar e inyectar HTML en el DOM.
2.  **Lógica Local:** El código fue modificado para no depender de la base de datos (Modo Mock/Offline), por lo que el error NO es falta de datos ni credenciales de Supabase.

### La Causa Raíz Probable 🔍
Todo apunta a un **Bloqueo de Red (Firewall/Corporativo) a los CDNs**.

El archivo `index.html` depende críticamente de librerías externas que se cargan desde internet:
*   **TailwindCSS (CDN):** Para TODOS los estilos.
*   **Supabase JS:** Para la conexión (aunque lo mitigamos con Mocks).
*   **Chart.js & Lucide:** Para gráficos e iconos.
*   **Google Fonts:** Tipografías.

**Evidencia:**
1.  El `debug_diagnostics.html` se colgaba en el paso de conexión.
2.  El comando `curl` a Supabase se quedó esperando.
3.  `simple_dashboard_test.html` (que NO usa librerías externas) funcionó.
4.  `index.html` (que SÍ usa librerías) falla, incluso cuando le quitamos la lógica compleja.

**Teoría del Fallo:**
Al no cargar **TailwindCSS**, las clases como `hidden`, `flex`, `grid`, `bg-black` pierden su significado. El navegador intenta renderizar sin estilos, pero si un script anterior (como la carga de Supabase) falla por timeout o error de red no manejado, **toda la ejecución de Javascript se detiene**.

El "Pantallazo Negro" probablemente es el fondo por defecto (o un estilo parcial que sí cargó) pero el contenido dinámico nunca se inyecta porque el JS crashea al intentar usar `Chart` o `supabase` que no existen.

## 3. Acciones Tomadas hoy
*   [x] **Mock Data Mode:** Se implementó un sistema para usar datos falsos si falla la DB.
*   [x] **Refactorización Global:** Se movieron las variables a alcance global para evitar errores de renderizado.
*   [x] **Modo Estático:** Se creó una versión de "Métricas" sin gráficos y solo texto.
*   [x] **Diagnóstico de Red:** Se creó una herramienta para validar conexión (confirmó problemas).
*   [x] **Debug Nuclear (Final):** Se intentó forzar estilos `inline` (sin depender de clases CSS) para probar visibilidad. (Pendiente de verificar resultado final).

## 4. Plan de Acción para Mañana 🛠️

Para solucionar esto definitivamente, debemos asumir un **entorno hostil (sin internet fiable para librerías)**.

1.  **Descargar Librerías (Vendoring):**
    *   No usar CDNs. Descargar `tailwindcss.js`, `chart.js`, `supabase.js` y guardarlos LOCALMENTE en la carpeta del proyecto.
    *   Enlazar los scripts localmente: `<script src="./libs/chart.js"></script>`.

2.  **Dashboard "Zero-Dependency" (Híbrido):**
    *   Continuar con la idea de `dashboard_standalone.html` pero integrarla como la versión principal.
    *   Escribir el CSS crítico a mano (en `<style>`) en lugar de depender de Tailwind.

3.  **Captura de Errores al Inicio:**
    *   Colocar un `try/catch` global en la primera línea de `index.html` para que, si algo falla, muestre un `alert()` nativo con el error exacto. Esto nos dirá qué línea está rompiendo el código.

---
*Buen descanso. Mañana atacaremos el problema eliminando la dependencia de internet.*
