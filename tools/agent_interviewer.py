import os
import json
from crewai import Agent, Task, Crew, Process, LLM
from dotenv import load_dotenv

load_dotenv()

# Usar el objeto LLM nativo de CrewAI configurado para Groq
my_llm = LLM(
    model="groq/llama-3.3-70b-versatile",
    api_key=os.getenv("GROQ_API_KEY"),
    temperature=0.4 # Balance entre empatía y análisis
)

# 1. Definir el Agente Reclutador
interviewer_agent = Agent(
    role='Especialista en Talento y Cultura IAmazing',
    goal='Realizar entrevistas profundas para entender el perfil técnico y psicológico de los nuevos integrantes',
    backstory='Eres un experto en headhunting con un toque humano. Tu misión es descubrir no solo lo que el candidato sabe hacer, sino cómo piensa y cómo prefiere trabajar. Eres amable pero analítico.',
    verbose=True,
    allow_delegation=False,
    llm=my_llm
)

def analyze_interview_transcript(transcript):
    """Analiza la conversación de la entrevista para extraer el ADN del trabajador."""
    
    task_description = f"""
    Analiza la siguiente entrevista de trabajo realizada por la agencia IAmazing:
    ---
    {transcript}
    ---
    
    Extrae la siguiente información técnica y psicológica:
    1. Resumen Ejecutivo: Quién es y qué aporta (Máximo 2 frases).
    2. Perfil Técnico: Herramientas que domina y nivel de experiencia.
    3. ADN de Comunicación: ¿Cómo prefiere recibir feedback? (Directo, suave, detallado, visual).
    4. Rasgos de Personalidad: 3 rasgos clave (ej: Proactivo, detallista, creativo).
    
    Responde en un formato JSON puro para que el sistema pueda procesarlo.
    Estructura esperada:
    {{
      "executive_summary": "...",
      "technical_profile": "...",
      "feedback_preference": "...",
      "personality_traits": ["...", "...", "..."]
    }}
    """
    
    analysis_task = Task(
        description=task_description,
        agent=interviewer_agent,
        expected_output="Un objeto JSON con el perfil psicológico y técnico del empleado."
    )
    
    crew = Crew(
        agents=[interviewer_agent],
        tasks=[analysis_task],
        process=Process.sequential
    )
    
    return crew.kickoff()

if __name__ == "__main__":
    mock_transcript = """
    Cortex: Hola, ¿cuál es tu fuerte en la edición?
    Candidato: Me encanta el storytelling y uso mucho After Effects para motion graphics.
    Cortex: ¿Cómo te gusta que te den feedback?
    Candidato: Prefiero que sean directos. Si algo está mal, dímelo de una vez para corregirlo rápido.
    """
    print(analyze_interview_transcript(mock_transcript))
