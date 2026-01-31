# 🔍 FINDINGS.MD - BITÁCORA DE INVESTIGACIÓN

## Contexto Inicial
*   **Origen:** Adaptación del protocolo E.T.A.P.A (Clínica Dental) a IAmazing (Agencia Content).
*   **Organigrama:** Estructura híbrida de 8 humanos y 3 agentes IA.
*   **Stack Tecnológico Actual:** Next.js 15, PostgreSQL (Prisma), NextAuth v5.
*   **Requerimiento:** Dashboard centralizado para control de todos los departamentos.

## Restricciones Identificadas
*   **Determinismo:** El sistema no debe "adivinar". Debe basarse en datos estructurados.
*   **Fuente de Verdad:** Base de datos relacional (PostgreSQL).
*   **Seguridad:** Accesos basados en roles (RBAC).
*   **Entorno Crítico:** Windows. **Ni Python ni Node.js en PATH**. Usar **PowerShell** para herramientas locales.

## Decisiones Pendientes (Bloqueantes)
1.  **Integraciones:** ¿Qué APIs externas son prioridad día 1?

## Notas Técnicas
*   El esquema de "Pacientes" mapea limpiamente a "Clientes".
*   El esquema de "Doctores" mapea a "Equipo Creativo".
*   El esquema de "Citas" mapea a "Proyectos/Entregas".
