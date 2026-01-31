# 📜 GEMINI.MD - CONSTITUCIÓN DEL PROYECTO
> **Proyecto:** Dashboard de Control Inteligente IAmazing (E.T.A.P.A)
> **Estado:** Inicialización
> **Versión:** 1.0

## 1. DIRECTRIZ PRINCIPAL (PRIME DIRECTIVE)
Construir un Dashboard de Control Inteligente centralizado que gestione y visualice el flujo de trabajo de los 11 departamentos (8 humanos + 3 IA) de IAmazing Content, permitiendo un control determinista sobre proyectos, equipo y métricas.

## 2. INVARIANTES ARQUITECTÓNICAS (RULES)
1.  **Determinismo:** El código no adivina lógica de negocio. Si un dato no existe, falla elegantemente o pide input.
2.  **Fuente de la Verdad:** **Supabase (PostgreSQL + Auth + Realtime)** es la única fuente de verdad. El dashboard es una vista reactiva.
3.  **Datos-Primero:** No se escribe código sin definir el esquema de datos aquí primero.
4.  **Autonomía Segura:** Cambios estructurales requieren Nivel Rojo (Aprobación). Correcciones requieren Nivel Verde (Auto-reparación).
5.  **Separación de Poderes:**
    *   `architecture/`: Lógica (SOPs).
    *   `tools/`: Ejecución (Scripts).
    *   `ui/`: Presentación (Dashboard).

## 3. ESQUEMAS DE DATOS (DATA SCHEMAS)

### 3.1. Entidad: Cliente (Clients)
Representa a los generadores de demanda (Creadores, PYMEs, Agencias).
```json
{
  "id": "UUID (PK) [Supabase Gen]",
  "name": "String (Required)",
  "type": "Enum('creator', 'pyme', 'agency', 'blackmarket')",
  "tier": "Enum('creator_15', 'pyme_100', 'agency_500', 'blackmarket_flex')",
  "whatsapp": "String (Unique, Required)",
  "email": "String",
  "status": "Enum('active', 'inactive', 'lead')",
  "metadata": "JSONB (Preferences, Notes)",
  "created_at": "Timestamp (Supabase Default)"
}
```

### 3.2. Entidad: Equipo (Team Members)
Representa a los agentes humanos y artificiales del organigrama. Mapeado a `auth.users` de Supabase si tienen acceso.
```json
{
  "id": "UUID (PK)",
  "supabase_user_id": "UUID (FK -> auth.users)",
  "first_name": "String",
  "role": "Enum('pm', 'coord_prod', 'sales_head', 'editor_sr', 'editor_std', 'designer', 'sales_intern', 'ai_bot')",
  "specialty": "String",
  "max_capacity": "Integer (Max concurrent projects)",
  "active": "Boolean"
}
```

### 3.3. Entidad: Proyecto (Projects)
La unidad atómica de trabajo.
```json
{
  "id": "UUID (PK)",
  "client_id": "UUID (FK -> Clients)",
  "assigned_to": "UUID (FK -> Team)",
  "service_type": "Enum('video', 'reel', 'thumbnail', 'pack')",
  "status": "Enum('briefing', 'production', 'qc', 'review', 'completed')",
  "priority": "Integer (1-5)",
  "deadline": "Timestamp",
  "delivered_at": "Timestamp",
  "metrics": "JSONB (NPS, ProductionTime)"
}
```

### 3.4. Entidad: Métricas (Production Metrics)
Agregados diarios para inteligencia de negocio.
```json
{
  "date": "Date (PK)",
  "total_projects": "Integer",
  "completed_projects": "Integer",
  "revenue": "Float",
  "avg_cycle_time": "Float"
}
```

## 4. INTEGRACIONES (HANDSHAKE LIST)
*   **Base de Datos & Auth:** Supabase (Project Ref, Anon Key, Service Role Key). **[PENDIENTE]**
*   **AI Engine:** OpenAI/Gemini API Key. **[PENDIENTE]**
*   **Whatsapp:** Meta Business API Credentials. **[PENDIENTE]**
*   **Hosting:** Vercel Token. **[PENDIENTE]**

## 5. REGLAS DE COMPORTAMIENTO
*   **Fiabilidad > Velocidad:** Preferimos un error claro a una alucinación rápida.
*   **Logs Estructurados:** Cada acción del sistema debe dejar un rastro auditable en la tabla `activity_log`.
*   **Mobile First:** El dashboard debe ser usable desde móvil para la gestión remota.
