import os
import json
from crewai import Agent, Task, Crew, Process, LLM
from crewai.tools import tool
from supabase import create_client, Client

load_dotenv()

# Inicializar Supabase para el Agente
url: str = os.environ.get("SUPABASE_URL")
key: str = os.environ.get("SUPABASE_ANON_KEY")
supabase: Client = create_client(url, key)

@tool("update_project_db")
def update_project_db(project_id: str, updates_json: str):
    """
    Actualiza un proyecto en la base de datos de Supabase.
    Recibe el project_id y un JSON string con los campos a actualizar (ej: {"priority": 5, "status": "production"}).
    """
    try:
        updates = json.loads(updates_json)
        result = supabase.table("projects").update(updates).eq("id", project_id).execute()
        return f"Éxito: Proyecto {project_id} actualizado con {updates_json}"
    except Exception as e:
        return f"Error al actualizar: {str(e)}"

# Usar el objeto LLM nativo de CrewAI configurado para Groq
my_llm = LLM(
    model="groq/llama-3.3-70b-versatile",
    api_key=os.getenv("GROQ_API_KEY"),
    temperature=0
)

# 1. Definir el Agente
manager = Agent(
    role='Cortex Master Manager (Proactive)',
    goal='Optimizar la operación de IAmazing y ACTUAR sobre la base de datos para mantener el flujo de trabajo',
    backstory='Eres el cerebro supremo de la agencia. Cuando ves un proyecto nuevo o mal priorizado, no solo reportas, lo arreglas en la DB. Usas la herramienta update_project_db para escribir cambios.',
    verbose=True,
    allow_delegation=False,
    tools=[update_project_db],
    llm=my_llm
)

def run_manager(projects_json):
    """Genera un plan de acción estratégico basado en los proyectos actuales."""
    
    task_description = f"""
    Analiza la lista de proyectos: {projects_json}
    
    Tus responsabilidades:
    1. Si un proyecto no tiene prioridad o es errónea, usa 'update_project_db' para corregirla (Priority 1: Urgent, 5: Low).
    2. Identifica los 3 más urgentes para el reporte humano.
    3. Si Pedro está sobrecargado (>3 tareas), intenta reasignar una tarea a otro miembro usando la herramienta (opcional si hay alguien libre).
    
    REPORTE PARA EL HUMANO:
    - Identifica los proyectos como "Cliente | Servicio" (No uses IDs en el texto final).
    - Resume qué cambios hiciste en la base de datos de forma proactiva.
    """
    
    planning_task = Task(
        description=task_description,
        agent=manager,
        expected_output="Un reporte ejecutivo en Markdown con prioridades y consejos."
    )
    
    crew = Crew(
        agents=[manager],
        tasks=[planning_task],
        process=Process.sequential
    )
    
    return crew.kickoff()

if __name__ == "__main__":
    # Mock data para prueba inicial
    mock_projects = [
        {"id": "1", "client": "TechFlow", "priority": 5, "status": "production", "service": "Video Long"},
        {"id": "2", "client": "YogaSarah", "priority": 3, "status": "briefing", "service": "Reel"}
    ]
    print(run_manager(json.dumps(mock_projects)))
