import os
import json
import urllib.request

# Cargar token desde .env simple (sin librerías externas para máxima compatibilidad)
def load_env():
    env = {}
    try:
        with open('../.env', 'r') as f:
            for line in f:
                if '=' in line and not line.startswith('#'):
                    key, value = line.strip().split('=', 1)
                    env[key] = value
    except FileNotFoundError:
        print("Error: .env file not found")
        exit(1)
    return env

config = load_env()
token = config.get('SUPABASE_ACCESS_TOKEN')

if not token:
    print("Error: SUPABASE_ACCESS_TOKEN not found in .env")
    exit(1)

url = "https://api.supabase.com/v1/projects"
req = urllib.request.Request(url)
req.add_header('Authorization', f'Bearer {token}')

print(f"Connecting to Supabase Management API...")

try:
    with urllib.request.urlopen(req) as response:
        if response.status == 200:
            data = json.loads(response.read().decode())
            print(f"SUCCESS: Found {len(data)} projects.")
            print("-" * 40)
            for project in data:
                print(f"ID: {project.get('id')}")
                print(f"Name: {project.get('name')}")
                print(f"Status: {project.get('status')}")
                print(f"Region: {project.get('region')}")
                print(f"Created: {project.get('created_at')}")
                print("-" * 40)
        else:
            print(f"Error: HTTP {response.status}")
except urllib.error.HTTPError as e:
    print(f"HTTP Error: {e.code} - {e.reason}")
    print(e.read().decode())
except Exception as e:
    print(f"Error: {e}")
