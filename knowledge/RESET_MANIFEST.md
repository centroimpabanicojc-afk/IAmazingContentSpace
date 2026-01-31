# 🛠️ MANIFIESTO DE REINICIO (IAmazingContent.Space)

Este documento guía el proceso de limpieza y reinstalación para solucionar los problemas del entorno (Git/Railway).

## 1. Qué RESGUARDAR (No Borrar)
El trabajo intelectual está a salvo en los siguientes archivos:
- 📄 `DOCUMENTO_MAESTRO_IAMAZING.md`: La visión completa.
- 📜 `MANUAL_OPERATIVO_IAMAZING.md`: Los procesos de negocio.
- ⚙️ `src/core/boss/orchestrator.py`: El motor de CORTEX.
- 🎨 `website-fullstack/src/app/dashboard/`: La nueva App interna.
- 📂 `.agent/`: Contiene tus habilidades personalizadas y reglas globales.

## 2. Qué LIMPIAR (Borrar para Reinstalar)
Para un reinicio limpio, borra lo siguiente:
1.  **Dependencias de Node**: Borra la carpeta `/node_modules` dentro de `website-fullstack/`.
2.  **Builds**: Borra la carpeta `/.next` dentro de `website-fullstack/`.
3.  **Locks**: (Opcional) Borra `package-lock.json` si sospechas de conflictos de versiones.
4.  **Caché de Antigravity**: Si el problema es con la IA, puedes borrar la carpeta oculta `.gemini` que está en tu carpeta de usuario (C:\Users\344.6047\.gemini).

## 3. Pasos de Reinstalación
Una vez borrado lo anterior:
1.  **PATH de Git**: Asegúrate de que Git esté instalado y agregado al PATH del sistema. (Reinicia VS Code tras hacerlo).
2.  **Reinstalar Deps**: Entra en `website-fullstack` y ejecuta `npm install`.
3.  **Reiniciar Antigravity**: Simplemente abre la carpeta de nuevo en la IA y debería detectar todo automáticamente gracias al `CODEBASE_MAP.md`.

---
**Estado de CORTEX**: Hibernando. Todos los modelos y lógica están salvados.
**Último Commit Pendiente**: Cambios locales en `website-fullstack` (Hero, Services, Dashboard).
