import asyncio
import edge_tts
import os

async def generate_voice(text, output_path="assets/audio/output.mp3", voice="es-MX-DaliaNeural"):
    """
    Genera un archivo de audio a partir de texto usando Edge-TTS.
    Voces recomendadas: es-MX-DaliaNeural (Femenina), es-MX-JorgeNeural (Masculina).
    """
    
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
