import asyncio
import edge_tts
import os

async def generate_voice(text, output_path="assets/audio/output.mp3", agent_type="manager"):
    """
    Genera un archivo de audio con una voz personalizada según el tipo de agente.
    """
    # Mapa de Personalidades por Voz
    VOICES = {
        "manager": "es-MX-JorgeNeural",    # Autoridad, serio
        "sales": "es-ES-AlvaroNeural",     # Entusiasta, comercial
        "research": "es-ES-ElviraNeural",  # Analítica, precisa
        "production": "es-MX-DaliaNeural", # Creativa, fluida
        "interviewer": "es-MX-DaliaNeural" # Empática
    }
    
    voice = VOICES.get(agent_type, "es-MX-JorgeNeural")
    
    # Asegurar que el directorio de destino exista
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    
    communicate = edge_tts.Communicate(text, voice)
    await communicate.save(output_path)
    return output_path

if __name__ == "__main__":
    # Prueba rápida
    txt = "Hola, bienvenido a la agencia IAmazing. Estamos procesando tu contenido con inteligencia artificial avanzada."
    asyncio.run(generate_voice(txt))
    print(f"Audio generado en assets/audio/output.mp3")
