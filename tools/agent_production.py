import os
from dotenv import load_dotenv
import json
from crewai import Agent, Task, Crew, Process, LLM

load_dotenv()

# Usar el objeto LLM nativo de CrewAI configurado para Groq
my_llm = LLM(
    model="groq/llama-3.3-70b-versatile",
    api_key=os.getenv("GROQ_API_KEY"),
    temperature=0.2 # Más preciso y menos creativo para producción
)

# 1. Definir el Agente de Producción
prod_agent = Agent(
    role='Director Creativo & Especialista en Retención',
    goal='Transformar ideas en briefs visuales de alto impacto diseñados para maximizar la retención de audiencia',
    backstory='Eres un experto en narrativa visual y psicología del espectador. Analizas cada segundo del video para asegurar que el mensaje sea claro y visualmente estimulante. Conoces a fondo herramientas de IA como Pollinations y Stable Diffusion.',
    verbose=True,
    allow_dotenv=True,
    allow_delegation=False,
    llm=my_llm
)

def generate_production_brief(video_title, core_idea):
    """Genera un brief de producción para un editor."""
    
    task_description = f"""
    Título: {video_title}
    Idea Central: {core_idea}
    
    Genera un brief de edición que incluya:
    1. Estructura de Guión: Gancho (0-3s), Desarrollo (3-50s) y CTA (50-60s).
    2. Instrucciones de Edición: Tipo de cortes, música recomendada y efectos visuales.
    3. Checklist de QC: 5 puntos clave para verificar antes de entregar.
    
    Responde en formato Markdown técnico.
    """
    
    prod_task = Task(
        description=task_description,
        agent=prod_agent,
        expected_output="Un brief técnico completo para el editor de video."
    )
    
    crew = Crew(
        agents=[prod_agent],
        tasks=[prod_task],
        process=Process.sequential
    )
    
    return crew.kickoff()

if __name__ == "__main__":
    # Prueba del Agente de Producción
    print(generate_production_brief("Como escalar una agencia con IA", "Explicar los 3 pasos clave usando agentes autónomos."))
