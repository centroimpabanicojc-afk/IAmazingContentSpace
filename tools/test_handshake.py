import os
import sys
from dotenv import load_dotenv

# Load credentials from root .env
load_dotenv(dotenv_path="../.env")

def test_handshake():
    print("--- HANDSHAKE TEST - AGENCIA AUTONOMA ---")
    
    # Check Python
    print(f"1. Python Version: {sys.version}")
    
    # Check Edge-TTS
    try:
        import edge_tts
        print("2. Edge-TTS: OK")
    except ImportError:
        print("2. Edge-TTS: FAILED")

    # Check CrewAI
    try:
        from crewai import Agent
        print("3. CrewAI: OK")
    except ImportError:
        print("3. CrewAI: FAILED")

    # Check Groq Connectivity via LangChain
    try:
        from langchain_groq import ChatGroq
        llm = ChatGroq(
            temperature=0,
            groq_api_key=os.getenv("GROQ_API_KEY"),
            model_name="llama-3.3-70b-versatile"
        )
        response = llm.invoke("Responde 'CONEXION_EXITOSA'")
        if "CONEXION_EXITOSA" in response.content.upper():
            print("4. Groq Integration: OK")
        else:
            print(f"4. Groq Integration: SUCCESSFUL BUT UNEXPECTED RESPONSE ({response.content})")
    except Exception as e:
        print(f"4. Groq Integration: FAILED ({str(e)})")

    print("--- FIN DE LA PRUEBA ---")

if __name__ == "__main__":
    test_handshake()
