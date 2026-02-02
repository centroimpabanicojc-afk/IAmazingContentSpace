# Task Plan - Roadmap de la Agencia Autónoma

## Fase 1: Cimentación (Protocolo 0)
- [x] Crear Memoria del Proyecto (`gemini.md`, `findings.md`, `progress.md`)
- [ ] Definir Plan Aprobado (Este archivo)

## Fase 2: Handshake [T]
- [x] Verificar instalación de Python (Usando Python 3.11 Portable)
- [x] Crear entorno y cargar `.env`
- [x] Instalar `crewai`, `langchain-groq`, `edge-tts`, `flask`
- [x] Script de prueba: `tools/test_handshake.py`

## Fase 3: Arquitectura [A]
- [x] **Capa 1 (SOPs):** Crear `architecture/sop_manager.md`.
- [x] **Capa 2 (Navegación):** Reparar Dashboard (`index.html` con assets locales).
- [x] **Capa 3 (Herramientas):** Desarrollar `tools/agent_manager.py` (Manager v1 funcional).
- [x] Desarrollo: Crear Agente de Ventas y Agente de Producción.
- [x] Integración: Conectar Cortex UI con el endpoint unificado `/api/agent`.

## Fase 4: Pulido [P]
- [ ] Refinamiento de UI/UX: Añadir efectos de escritura y feedback visual en Cortex.
- [ ] Mejoras Estéticas: Implementar transiciones suaves entre vistas y pulido de tarjetas Kanban.
- [ ] Optimización: Carga silenciosa de datos y manejo de errores premium.

## Fase 5: Automatización y Despliegue [A]
- [x] Configuración inicial: Crear `requirements.txt` y `vercel.json`.
- [ ] Evaluación: Decidir entre Vercel (Híbrido) o Railway para los agentes (por el timeout de 10s).
- [ ] Disparadores: Configurar Webhooks de Supabase para automatización proactiva.
- [ ] Entrega: Manual de uso y despliegue final.
