# 📄 SOP: GESTIÓN DE VENTAS Y CLIENTES
> **Ref:** architecture/sop_sales_management.md
> **Versión:** 1.0

## 1. OBJETIVO
Estandarizar el registro de clientes y prospectos para asegurar que la "Carga Útil" (Payload) de ventas sea procesable por el sistema de producción.

## 2. FLUJO DE VENTAS

### 1. Prospección (Ventas Intern)
*   **Actor:** Isaac.
*   **Acción:** Identificar prospectos.
*   **Estado en DB:** `status = 'lead'`.

### 2. Calificación (Jefe de Ventas)
*   **Actor:** Bobby.
*   **Acción:** Definir el `tier` y `type` del cliente.
*   **Estado en DB:** `status = 'active'`.

## 3. ASIGNACIÓN DE TIERS
El sistema debe validar que el `tier` corresponda al `type`:
*   **Creator:** `creator_15` ($15/video).
*   **PYME:** `pyme_100` ($100-500/mes).
*   **Agency:** `agency_500` ($501-2,000/mes).
*   **Blackmarket:** `blackmarket_flex` (Negociado).

## 4. REGLAS DETERMINISTAS
1.  **WhatsApp Único:** No se pueden crear dos clientes con el mismo número de WhatsApp.
2.  **Validación de Tier:** Si un cliente es tipo `pyme`, el sistema debe sugerir `pyme_100` por defecto.
3.  **Registro de Origen:** Todo cliente nuevo debe tener una nota en `metadata` indicando quién lo prospectó.
