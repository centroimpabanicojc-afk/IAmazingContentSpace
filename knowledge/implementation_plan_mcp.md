# Plan de Implementación: GitHub MCP Server (Sin Docker)

## Objetivo
Configurar y preparar un servidor de Model Context Protocol (MCP) para GitHub que se ejecute de forma nativa en Node.js, evitando las restricciones de Docker local.

## Fase 1: Estructura del Proyecto
- [x] Crear la carpeta `mcp-github-server`.
- [x] Inicializar el proyecto con `npm init -y`.
- [x] Instalar dependencias necesarias:
    - `@modelcontextprotocol/sdk`
    - `@modelcontextprotocol/server-github`

## Fase 2: Configuración del Servidor
- [x] Crear un script de inicio `index.js` (opcional si usamos npx directamente).
- [x] Crear un archivo `.env.example` para guiar al usuario en la colocación de su token.
- [x] Crear un script de ayuda `setup.bat` para Windows que facilite la ejecución.

## Fase 3: Guía de Usuario (Antigravity)
- [x] Generar el fragmento JSON de configuración para `antigravity_config.json`.
- [ ] Detallar los permisos necesarios para el Token de Acceso Personal (PAT) de GitHub:
    - `repo` (Full control of private repositories)
    - `gist`
    - `user`
    - `workflow` (opcional)

## Fase 4: Pruebas y Validación
- [ ] Instrucciones para reiniciar Claude Desktop.
- [ ] Comandos de prueba para verificar que el servidor responde.

---
**Nota**: Este setup es ideal para entornos Windows donde la virtualización (Docker) no está disponible o presenta problemas.
