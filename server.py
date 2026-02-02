from flask import Flask, send_from_directory, jsonify, request
from flask_cors import CORS
import os
import sys

# Añadir el directorio actual al path para importar tools
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from tools.agent_manager import run_manager
from tools.agent_sales import generate_sales_pitch
from tools.agent_production import generate_production_brief
from tools.agent_researcher import run_research
from tools.voice_engine import generate_voice
import asyncio

app = Flask(__name__)
CORS(app)

# Servir el frontend
@app.route('/')
def index():
    return send_from_directory('.', 'index.html')

@app.route('/assets/<path:path>')
def send_assets(path):
    return send_from_directory('assets', path)

# Endpoint unificado para Agentes
@app.route('/api/agent', methods=['POST'])
def run_agent():
    # Asegurar que los logs usen UTF-8 en Windows
    os.environ["PYTHONUTF8"] = "1"
    
    data = request.json
    agent_type = data.get('agent_type')
    
    try:
        if agent_type == 'manager':
            projects = data.get('projects', [])
            result = run_manager(projects)
            return jsonify({"status": "success", "result": str(result)})
            
        elif agent_type == 'sales':
            client = data.get('client', 'Cliente Genérico')
            niche = data.get('niche', 'Contenido Digital')
            status = data.get('status', 'Activo')
            result = generate_sales_pitch(client, niche, status)
            return jsonify({"status": "success", "result": str(result)})
            
        elif agent_type == 'production':
            title = data.get('title', 'Nuevo Video')
            idea = data.get('idea', 'Sin descripción')
            result = generate_production_brief(title, idea)
            return jsonify({"status": "success", "result": str(result)})
            
        elif agent_type == 'research':
            topic = data.get('topic', 'IA en Marketing 2026')
            result = run_research(topic)
            return jsonify({"status": "success", "result": str(result)})
            
        else:
            return jsonify({"status": "error", "message": "Tipo de agente no reconocido"}), 400
            
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

# 🎤 Endpoint de Voz (Fase 5: Producción Proactiva)
@app.route('/api/voice', methods=['POST'])
def run_voice():
    data = request.json
    text = data.get('text', '')
    if not text: return jsonify({"status": "error", "message": "Falta el texto"}), 400
    
    try:
        filename = f"assets/audio/voice_{os.urandom(4).hex()}.mp3"
        asyncio.run(generate_voice(text, filename))
        return jsonify({"status": "success", "url": filename})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

# ⚡ NUEVO: Webhook para Automatización Proactiva (Fase 5)
@app.route('/api/webhook', methods=['POST'])
def supabase_webhook():
    """Recibe notificaciones de cambios en la DB para disparar agentes."""
    payload = request.json
    print(f"DEBUG: Webhook recibido: {payload}")
    
    # Lógica de disparo automático:
    # Si se crea un proyecto (INSERT), llamar al Agente Manager para priorizar.
    if payload.get('type') == 'INSERT' and payload.get('table') == 'projects':
        project = payload.get('record', {})
        run_manager([project]) # El manager analiza el nuevo proyecto
        return jsonify({"status": "success", "message": "Agente Manager disparado"}), 200
        
    return jsonify({"status": "ignored", "message": "Evento no procesado"}), 200

if __name__ == '__main__':
    # Usar el puerto 5000
    app.run(port=5000, debug=True)
