from flask import Flask, send_from_directory, jsonify, request
from flask_cors import CORS
import os
import subprocess
import json

app = Flask(__name__)
CORS(app)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

@app.route('/')
def index():
    return send_from_directory(BASE_DIR, 'index.html')

@app.route('/assets/<path:path>')
def send_assets(path):
    return send_from_directory(os.path.join(BASE_DIR, 'assets'), path)

@app.route('/api/manager', methods=['POST'])
def run_manager():
    try:
        data = request.json
        projects = data.get('projects', [])
        
        # Ejecutar el agente manager de python
        # Usamos el path relativo al ejecutable de python que instalamos
        python_exe = os.path.join(BASE_DIR, '.tmp', 'python', 'python.exe')
        agent_script = os.path.join(BASE_DIR, 'tools', 'agent_manager.py')
        
        # Guardar proyectos temporales para que el agente los lea si fuera necesario
        # Por ahora el agente manager que escribimos acepta json por argumento o mock
        # Vamos a modificar el agente para que sea una libreria o reciba input
        
        # Simulación rápida para el dashboard mientras el agente corre
        cmd = [python_exe, agent_script]
        env = os.environ.copy()
        env["PYTHONUTF8"] = "1"
        
        result = subprocess.run(cmd, capture_output=True, text=True, env=env)
        
        if result.returncode == 0:
            return jsonify({"status": "success", "analysis": result.stdout})
        else:
            return jsonify({"status": "error", "message": result.stderr}), 500
            
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

if __name__ == '__main__':
    print("--- SERVIDOR OPERATIVO EN http://localhost:5000 ---")
    app.run(host='0.0.0.0', port=5000)
