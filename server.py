from flask import Flask, send_from_directory, jsonify, request
from flask_cors import CORS
import os
import sys
import json
import asyncio

# Añadir el directorio actual al path para importar tools
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from tools.agent_manager import run_manager
from tools.agent_sales import generate_sales_pitch
from tools.agent_production import generate_production_brief
from tools.agent_researcher import run_research
from tools.voice_engine import generate_voice
from tools.agent_interviewer import analyze_interview_transcript

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
            topic = data.get('topic', 'IA in Marketing 2026')
            result = run_research(topic)
            return jsonify({"status": "success", "result": str(result)})
            
        else:
            return jsonify({"status": "error", "message": "Tipo de agente no reconocido"}), 400
            
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

# 🎤 Endpoint de Voz
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

# ⚡ Webhook para Automatización Proactiva
@app.route('/api/webhook', methods=['POST'])
def supabase_webhook():
    payload = request.json
    event_type = payload.get('type')
    table = payload.get('table')
    record = payload.get('record', {})

    print(f"DEBUG: Webhook recibido [{event_type}] en [{table}]")
    
    if event_type == 'INSERT' and table == 'projects':
        run_manager(json.dumps([record]))
        return jsonify({"status": "success", "message": "Manager analizó el proyecto"}), 200
        
    if event_type == 'UPDATE' and table == 'projects':
        new_status = record.get('status')
        if new_status == 'qc':
            print(f"AUTOMACIÓN: Proyecto {record.get('id')} en QC.")
            return jsonify({"status": "success", "message": "QC detectado"}), 200

    return jsonify({"status": "ignored"}), 200

# 👤 Endpoint para Onboarding (Entrevista IA)
@app.route('/api/onboarding/finish', methods=['POST'])
def finish_onboarding():
    data = request.json
    employee_id = data.get('employee_id')
    transcript = data.get('transcript')
    
    if not employee_id or not transcript:
        return jsonify({"status": "error", "message": "Datos incompletos"}), 400
        
    try:
        analysis_raw = analyze_interview_transcript(transcript)
        analysis_str = str(analysis_raw)
        
        if "```json" in analysis_str:
            analysis_str = analysis_str.split("```json")[1].split("```")[0].strip()
        elif "{" in analysis_str:
            start = analysis_str.find("{")
            end = analysis_str.rfind("}") + 1
            analysis_str = analysis_str[start:end]
        
        analysis = json.loads(analysis_str)
        
        from tools.agent_manager import supabase
        update_data = {
            "interview_summary": analysis.get('executive_summary'),
            "personality_traits": analysis, 
            "status": "pending_approval"
        }
        supabase.table("team_members").update(update_data).eq("id", employee_id).execute()
        
        return jsonify({"status": "success", "analysis": analysis})
        
    except Exception as e:
        print(f"ERROR ONBOARDING: {str(e)}")
        return jsonify({"status": "error", "message": str(e)}), 500

if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port, debug=False)
