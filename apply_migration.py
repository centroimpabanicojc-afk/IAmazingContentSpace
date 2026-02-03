import os
from supabase import create_client, Client
from dotenv import load_dotenv

load_dotenv()

url: str = os.environ.get("SUPABASE_URL")
key: str = os.environ.get("SUPABASE_SERVICE_ROLE_KEY") # Use service role key for migrations

if not key:
    key = os.environ.get("SUPABASE_ANON_KEY")

supabase: Client = create_client(url, key)

sql_file = "MIGRATION_SCHEMA_SOTA.sql"

with open(sql_file, "r", encoding="utf-8") as f:
    sql = f.read()

print(f"Aplicando migración desde {sql_file}...")

# Supabase python client doesn't have a direct 'rpc' for raw SQL unless configured.
# Usually, migrations are done through the CLI or Dashboard.
# However, we can try to use a simple RPC if available or just print instructions.

print("\n--- INSTRUCCIONES ---")
print("Copia y pega el contenido de MIGRATION_SCHEMA_SOTA.sql en el Editor SQL de Supabase:")
print(f"URL: {url.replace('rest/v1/', '') if url else 'Dashboard de Supabase'}")
print("\n--- FIN ---")
