# Task Plan - Roadmap de la Agencia Autónoma

## Fase 1: Cimentación (Protocolo 0)
- [x] Crear Memoria del Proyecto (`gemini.md`, `findings.md`, `progress.md`)
- [ ] Definir Plan Aprobado (Este archivo)

## Fase 2: Handshake [T]
- [x] Verificar instalación de Python (Usando Python 3.11 Portable)
- [x] Crear entorno y cargar `.env`
- [x] Instalar `crewai`, `langchain-groq`, `edge-tts`, `flask`
- [x] Script de prueba: `tools/test_handshake.py`

## Fase 3: Arquitectura (Integración) [A]
- [x] Unificación de Agentes: CrewAI + Flask API.
- [x] Agentes Implementados: Manager, Ventas, Producción y **I+D (Researcher)**.
- [x] Herramientas: Integración de **Edge-TTS** para generación de voz.
- [x] Integración: Conectar Cortex UI con el endpoint unificado `/api/agent`.

## Fase 4: Pulido [P]
- [x] Refinamiento de UI/UX: Añadir efectos de escritura (typing effect) y feedback visual en Cortex.
- [x] Mejoras Estéticas: Implementar transiciones suaves entre vistas y pulido de tarjetas Kanban.
- [x] Optimización: Carga silenciosa de datos y manejo de errores premium.

## Fase 5: Automatización y Despliegue [A]
- [x] Configuración inicial: Crear `requirements.txt` y `vercel.json`.
- [x] Despliegue Híbrido: Configuración de Vercel (Frontend) y Railway (Backend).
- [/] Disparadores: Configurar Webhooks de Supabase para automatización proactiva (Cerebro Reactivo).
- [ ] Audio: Integrar respuesta de voz (TTS) en Cortex AI.
- [ ] Entrega: Manual de uso y cierre de proyecto.
