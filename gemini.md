# Constitución del Proyecto: Agencia de IA Autónoma (E.T.A.P.A.)

## Identidad y Propósito
Este proyecto transforma IAmazing en un Sistema Operativo Empresarial 85% autónomo.
**Protocolo:** E.T.A.P.A. (Estrategia, Tests, Arquitectura, Pulido, Automatización).

## Invariantes Arquitectónicas
1. **Determinismo:** El código base debe ser predecible. Los LLMs solo procesan datos.
2. **Costo Cero / Low-End:** Uso de APIs gratuitas (Groq, Gemini Flash, Hugging Face) y procesamiento CPU-light.
3. **Vendoring:** El Dashboard no debe depender de CDNs externos (bloqueados por firewall).
4. **Seguridad:** Claves API en `.env`. Operaciones temporales en `.tmp/`.

## Esquema de Datos (Data Schema) - v1.0
```json
{
  "project_metadata": {
    "version": "1.0",
    "protocol": "ETAPA",
    "last_sync": "UTC_TIMESTAMP"
  },
  "agency_state": {
    "status": "idle | active | maintenance",
    "active_agents": ["admin", "sales", "creative", "research"]
  },
  "data_structures": {
    "lead": {
      "id": "uuid",
      "source": "string",
      "contact": "email/url",
      "status": "new | contacted | interested | rejected"
    },
    "content_artifact": {
      "type": "video | image | text",
      "path": "local_path",
      "meta": "json"
    }
  }
}
```

## Reglas de Comportamiento
- Priorizar fiabilidad sobre velocidad.
- Todo script en `tools/` debe tener un test de handshake asociado.
- El 15% humano actúa como filtro de aprobación de planes de acción.
