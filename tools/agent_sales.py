import os
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

# 1. Definir el Agente de Ventas
sales_agent = Agent(
    role='Growth Hacker & Proactive Sales Bot',
    goal='Investigar clientes potenciales en internet y generar propuestas de outreach personalizadas basadas en datos reales',
    backstory='Eres un experto en prospección digital. No solo esperas, sales a buscar. Utilizas internet para entender el nicho del cliente y sus puntos de dolor antes de escribir.',
    verbose=True,
    allow_delegation=False,
    tools=[search_tool],
    llm=my_llm
)

def generate_sales_pitch(client_name, niche, current_status):
    """Genera una propuesta personalizada para un cliente."""
    
    task_description = f"""
    Cliente: {client_name}
    Nicho/Industria: {niche}
    
    PASOS:
    1. Usa internet para investigar tendencias actuales, competidores o el estilo de contenido popular en el nicho: {niche}.
    2. Basado en esa investigación, genera 3 ideas de contenido de alto impacto para {client_name}.
    3. Redacta un mensaje de outreach para WhatsApp que mencione un dato real o tendencia que encontraste.
    
    Responde en formato Markdown, citando brevemente qué encontraste en tu investigación.
    """
    
    sales_task = Task(
        description=task_description,
        agent=sales_agent,
        expected_output="Una propuesta de contenido y un mensaje de outreach para WhatsApp."
    )
    
    crew = Crew(
        agents=[sales_agent],
        tasks=[sales_task],
        process=Process.sequential
    )
    
    return crew.kickoff()

if __name__ == "__main__":
    # Prueba del Agente de Ventas
    print(generate_sales_pitch("TechFlow", "Software B2B", "Ha entregado 5 videos este mes con buena recepción."))
