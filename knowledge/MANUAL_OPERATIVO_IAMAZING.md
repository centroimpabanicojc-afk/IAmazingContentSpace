# 📖 MANUAL OPERATIVO: IAmazingContent.Space
> **Versión**: 1.0.0
> **Fecha**: 2026-01-27
> **Estado**: VIGENTE

---

## 1. INTRODUCCIÓN Y PROPÓSITO

### Misión y Visión
*   **Misión:** Democratizar la producción de contenido audiovisual premium mediante la combinación de talento humano curado y tecnología IA de vanguardia.
*   **Visión:** Ser el "Uber" de la post-producción creativa en LATAM.

### Objetivos del Manual
1.  **Estandarizar la Calidad:** Asegurar que cada pieza de contenido cumpla con el estándar "Antigravity".
2.  **Onboarding Acelerado:** Permitir que nuevos talentos (humanos o agentes) sean productivos en < 48 horas.
3.  **Escalabilidad:** Documentar procesos para poder replicarlos sin depender del fundador.

---

## 2. DIAGRAMA DE LA CADENA DE VALOR

**Input (Entrada)**  
`Cliente (Brief)` -> `Sales Manager (Cierre)`

**Process (Transformación)**  
`Project Manager (Asignación)` -> `AI Agent (Drafting/Assets)` -> `Human Artist (Polishing/Assembly)`

**Output (Salida)**  
`Quality Assurance (Validación)` -> `Cliente (Entrega Final)`

**Puntos Críticos de Control:**
1.  **Aprobación del Brief:** Si entra basura, sale basura.
2.  **QA Técnico:** Verificación de resolución, audio y color antes de enviar.

---

## 3. EL ORGANIGRAMA OPERATIVO

### Definición de Roles
*   🧠 **CORTEX [AI Boss]:** Orquestador central. Asigna tareas y reporta estado.
*   👤 **Sales Manager [H]:** Responsable de traer ingresos y cerrar deals.
*   👤 **Project Manager [H]:** Enlace con el cliente.
*   🧠 **AI Content Agent [AI]:** Scripts Python (Free API) para drafting.
*   👤 **Creative Artist [H]:** Editor humano que usa DaVinci/CapCut.

---

## 4. PROCEDIMIENTOS (SOPs)

### SOP-001: Gestión de Pipeline de Ventas (Bootstrap)
**Código**: OP-001  
**Versión**: 2.0 (Zero Cost)  
**Propietario**: Sales Manager  
**Tipo de Ejecutor**: 👤 [H]

#### 1. OBJETIVO
Asegurar flujo de leads sin inversión en ads ni herramientas premium.

#### 2. ALCANCE
Departamento de Ventas.

#### 3. REQUISITOS PREVIOS
- Cuenta de ClickUp Free.
- Perfil de LinkedIn optimizado.

#### 4. PROCEDIMIENTO PASO A PASO

| Paso | Acción | Responsable | Herramienta |
| :--- | :--- | :--- | :--- |
| 1 | **Prospección Orgánica**: Buscar "Marketing Manager" en LinkedIn filter por "Content". | Sales Mgr | LinkedIn Free |
| 2 | **Contacto Inicial**: Solicitud de conexión con nota personalizada. | Sales Mgr | LinkedIn |
| 3 | **Nurturing**: Si aceptan, enviar mensaje de aporte de valor (No venta). | Sales Mgr | LinkedIn DM |
| 4 | **Discovery Call**: Google Meet de 15 min. | Sales Mgr | Google Meet |
| 5 | **Propuesta**: PDF simple exportado desde Google Docs. | Sales Mgr | Google Docs |
| 6 | **Cierre**: Acuerdo por email + Transferencia/Link de pago manual. | Sales Mgr | Email |

---

### SOP-002: Creación de Contenido Híbrido (Stack Gratuito)
**Código**: OP-002  
**Versión**: 2.0 (Free Tools)  
**Propietario**: Project Manager  
**Tipo de Ejecutor**: 🧠 [AI] + 👤 [H]

#### 1. OBJETIVO
Producir contenido profesional usando herramientas de costo cero.

#### 2. ALCANCE
Producción de Video y Gráfica.

#### 3. REQUISITOS PREVIOS
- Acceso a Microsoft Bing (Image Creator).
- DaVinci Resolve instalado.
- API Key de Gemini (Free Tier).

#### 4. PROCEDIMIENTO PASO A PASO

| Paso | Acción | Responsable | Herramienta |
| :--- | :--- | :--- | :--- |
| 1 | **Briefing**: Entender pedido. | Project Mgr | ClickUp |
| 2 | **Guion/Ideas**: Pedir a Gemini/ChatGPT Free 3 opciones. | 🧠 AI Agent | Gemini/Groq |
| 3 | **Imágenes Base**: Generar en Bing Image Creator (DALL-E 3). | 🧠 AI Agent | Bing Create |
| 4 | **Voz en Off**: Usar TTSMaker o ElevenLabs Free Tier. | 🧠 AI Agent | TTSMaker |
| 5 | **Edición**: Montar en DaVinci Resolve. Color grade profesional. | 👤 Artist | DaVinci Resolve |
| 6 | **Miniaturas**: Componer en Photopea (Clon de Photoshop). | 👤 Artist | Photopea |

#### 4.1 IMPLEMENTACIÓN TÉCNICA (Parte AI)
- **Rotación de Keys**: Usar múltiples modelos gratuitos si se alcanza el lìmite de rate.

---

### SOP-004: Onboarding de Nuevos Clientes
**Código**: OP-004  
**Versión**: 1.0  
**Propietario**: Account Manager  
**Tipo de Ejecutor**: 👤 [H]

#### 1. OBJETIVO
Bienvenida calurosa y profesional sin costo.

#### 2. ALCANCE
Inicio de proyecto.

#### 3. REQUISITOS PREVIOS
- Pago confirmado.

#### 4. PROCEDIMIENTO PASO A PASO

| Paso | Acción | Responsable | Herramienta |
| :--- | :--- | :--- | :--- |
| 1 | **Email de Bienvenida**: Gmail con plantilla guardada. | Account Mgr | Gmail |
| 2 | **Setup**: Carpeta en Google Drive (15GB gratis). | Account Mgr | GDrive |
| 3 | **Chat**: Grupo de WhatsApp Business. | Account Mgr | WhatsApp |
| 4 | **Kick-off**: Llamada de coordinación. | Project Mgr | Google Meet |

---

## 5. PROTOCOLOS TRANSVERSALES

### Comunicación Interna
*   **Discord**: Servidor gratuito para el equipo. Canales de voz y texto ilimitados.
*   **ClickUp Free**: Gestión de tareas. Dashboard simplificado.

*   **Reuniones**: Solo las necesarias. Daily Standup (15 min) y Weekly Review (1h).

### Control de Calidad
1.  **Autorevisión**: El artista revisa su propio trabajo antes de entregarlo.
2.  **Peer Review**: Otro artista o el PM revisa el trabajo antes de enviarlo al cliente.
3.  **Checklist**: Usar la checklist de entrega (Resolución, Audio, Color, Textos).

## 6. GLOSARIO Y HERRAMIENTAS
*   **SOP**: Standard Operating Procedure.
*   **Brief**: Documento con los requerimientos del cliente.
*   **Assets**: Archivos multimedia (imágenes, video, audio) usados en la producción.
*   **Render**: Proceso final de exportación del video.

**Stack de Herramientas:**
- Gestión: ClickUp, Slack, Google Workspace.
- Producción IA: Claude, Midjourney, ElevenLabs, Runway.
- Edición: Adobe Creative Cloud, CapCut.
