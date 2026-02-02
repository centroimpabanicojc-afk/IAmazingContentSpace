import os
import json
from crewai import Agent, Task, Crew, Process, LLM
from dotenv import load_dotenv

load_dotenv()

# Usar el objeto LLM nativo de CrewAI configurado para Groq
my_llm = LLM(
    model="groq/llama-3.3-70b-versatile",
    api_key=os.getenv("GROQ_API_KEY"),
    temperature=0.7 # Un poco más de creatividad para ventas
)

# 1. Definir el Agente de Ventas
sales_agent = Agent(
    role='Growth Hacker & Sales Specialist',
    goal='Generar propuestas de contenido irresistibles y redactar mensajes de outreach efectivos',
    backstory='Eres un experto en marketing viral y ventas directas. Sabes cómo captar la atención de un cliente en los primeros 3 segundos de un mensaje.',
    verbose=True,
    allow_delegation=False,
    llm=my_llm
)

def generate_sales_pitch(client_name, niche, current_status):
    """Genera una propuesta personalizada para un cliente."""
    
    task_description = f"""
    Cliente: {client_name}
    Nicho: {niche}
    Estado Actual: {current_status}
    
    1. Genera 3 ideas de Reels que sean tendencia para este nicho.
    2. Redacta un mensaje persuasivo para WhatsApp (máximo 100 palabras) invitando al cliente a escalar su producción.
    3. Incluye un 'gancho' inicial potente.
    
    Responde en formato Markdown.
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
