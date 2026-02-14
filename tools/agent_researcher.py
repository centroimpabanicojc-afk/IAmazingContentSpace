import os
from dotenv import load_dotenv
import json
from crewai import Agent, Task, Crew, Process, LLM
from langchain_community.tools import DuckDuckGoSearchRun

load_dotenv()

# Inicializar herramienta de búsqueda gratuita
search_tool = DuckDuckGoSearchRun()

# Usar el objeto LLM nativo de CrewAI configurado para Groq
my_llm = LLM(
    model="groq/llama-3.3-70b-versatile",
    api_key=os.getenv("GROQ_API_KEY"),
    temperature=0.7 
)

# 1. Definir el Agente de I+D (Researcher)
research_agent = Agent(
    role='IA Researcher & Trend Hunter',
    goal='Escanear internet en busca del estado del arte en IA y encontrar herramientas gratuitas para la agencia',
    backstory='Eres un entusiasta de la tecnología que vive en internet. Tu misión es que la agencia siempre use lo más nuevo al menor costo. Usas herramientas de búsqueda para validar tus hallazgos.',
    verbose=True,
    allow_delegation=False,
    tools=[search_tool],
    llm=my_llm
)

def run_research(topic):
    """Genera un reporte de investigación sobre un tema específico."""
    
    task_description = f"""
    Tema: {topic}
    
    1. Investiga 3 herramientas de IA gratuitas o de código abierto relacionadas con el tema.
    2. Explica cómo la agencia IAmazing podría implementarlas para ahorrar dinero o tiempo.
    3. Proporciona un enlace de referencia (GitHub o URL oficial) para cada una.
    
    Responde en formato Markdown ejecutivo y accionable.
    """
    
    research_task = Task(
        description=task_description,
        agent=research_agent,
        expected_output="Un reporte técnico sobre nuevas tendencias y herramientas de IA."
    )
    
    crew = Crew(
        agents=[research_agent],
        tasks=[research_task],
        process=Process.sequential
    )
    
    return crew.kickoff()

if __name__ == "__main__":
    # Prueba del Agente de I+D
    print(run_research("Automatización de video con Python 2026"))
