import os
import json
from crewai import Agent, Task, Crew, Process, LLM
from dotenv import load_dotenv

load_dotenv()

# Usar el objeto LLM nativo de CrewAI configurado para Groq
# Esto evita que CrewAI busque la API Key de OpenAI
my_llm = LLM(
    model="groq/llama-3.3-70b-versatile",
    api_key=os.getenv("GROQ_API_KEY"),
    temperature=0
)

# 1. Definir el Agente
manager = Agent(
    role='Cortex Manager Agent',
    goal='Optimizar la operación de IAmazing y dar visibilidad clara sobre el estado de los proyectos',
    backstory='Eres el cerebro operativo de IAmazing. No usas IDs técnicos, prefieres hablar de "Cliente - Servicio". Eres directo, usas emojis para facilitar la lectura y siempre buscas soluciones prácticas.',
    verbose=True,
    allow_delegation=False,
    llm=my_llm
)

def run_manager(projects_json):
    """Genera un plan de acción estratégico basado en los proyectos actuales."""
    
    task_description = f"""
    Analiza la siguiente lista de proyectos de la agencia IAmazing:
    {projects_json}
    
    1. Identifica los 3 proyectos más urgentes. **IMPORTANTE**: Identifícalos como "Cliente | Servicio" (No uses IDs).
    2. Da un consejo táctico muy breve para cada uno.
    3. Analiza la carga del equipo (usa sus nombres de pila).
    
    Responde en formato Markdown ejecutivo, usando negritas para nombres y listas para que sea fácil de leer en un chat.
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
