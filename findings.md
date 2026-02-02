# Findings.md - Registro de Hallazgos y Restricciones

## Hallazgos Técnicos
| Fecha | Descripción | Impacto |
| :--- | :--- | :--- |
| 2026-02-02 | **Bloqueo de CDNs:** El firewall corporativo bloquea Tailwind, Supabase JS y Chart.js desde CDNs. | Causó "Pantalla Negra" en el dashboard. |
| 2026-02-02 | **Conectividad API:** `api.groq.com`, `google.com` y `huggingface.co` están abiertos. | Permite el uso de agentes autónomos basados en la nube. |
| 2026-02-02 | **Hardware:** El entorno es "Low-End". | Se debe evitar procesamiento local pesado (Ollama/GPU local). |
| 2026-02-02 | **Python Portable:** Es posible ejecutar Python 3.11 sin instalación formal en el sistema. | Permite usar CrewAI y herramientas de automatización. |
| 2026-02-02 | **Flask Server:** El usuario puede correr servidores locales en el puerto 5000. | Facilita la orquestación entre UI y agentes Python. |

## Restricciones
- No usar CDNs externos en el frontend.
- Usar APIs externas para inferencia de IA.
- Mantener persistencia local o en Supabase (siempre que la API de Supabase sea accesible via backend).
