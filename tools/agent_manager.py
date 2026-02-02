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
    role='Director de Operaciones Virtual',
    goal='Optimizar la entrega de proyectos y priorizar las tareas críticas de la agencia',
    backstory='Eres un experto PM con 20 años de experiencia que ahora vive en el código. Eres determinista, eficiente y te enfocas en cumplir los plazos.',
    verbose=True,
    allow_delegation=False,
    llm=my_llm
)

def run_manager(projects_json):
    """Genera un plan de acción estratégico basado en los proyectos actuales."""
    
    task_description = f"""
    Analiza la siguiente lista de proyectos de la agencia IAmazing:
    {projects_json}
    
    1. Identifica los 3 proyectos más urgentes basados en prioridad (1-5) y vencimiento.
    2. Da un consejo breve (una frase) para cada proyecto crítico.
    3. Identifica si algún miembro del equipo está sobrecargado.
    
    Responde en formato Markdown limpio.
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
