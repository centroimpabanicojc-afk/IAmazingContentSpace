import os
import time
from dotenv import load_dotenv
from supabase import create_client, Client

# Load environment variables
load_dotenv()

url: str = os.environ.get("SUPABASE_URL")
key: str = os.environ.get("SUPABASE_ANON_KEY")

if not url or not key:
    print("❌ Error: Missing SUPABASE_URL or SUPABASE_ANON_KEY in .env")
    exit(1)

supabase: Client = create_client(url, key)

def verify_migration():
    print("--- 🔍 Verificando Migración SOTA ---")
    
    # 1. Verificar columnas en tabla CLIENTS
    print("\n1. Verificando tabla 'clients'...")
    try:
        # Intentamos seleccionar las nuevas columnas
        # Si fallan, la migración no se corrió bien
        res = supabase.table("clients").select("id, name, whatsapp, default_rate, billing_model").limit(1).execute()
        print("   ✅ Columnas nuevas detectadas en 'clients'.")
        
        clients = res.data
        if not clients:
            print("   ⚠️ No hay clientes para probar. Creando uno temporal...")
            c_res = supabase.table("clients").insert({"name": "Test Client SOTA", "whatsapp": "+123456789"}).execute()
            test_client_id = c_res.data[0]['id']
            print(f"   ✅ Cliente temporal creado: {test_client_id}")
        else:
            test_client_id = clients[0]['id']
            print(f"   ℹ️ Usando cliente existente: {clients[0]['name']}")
            
    except Exception as e:
        print(f"   ❌ Error verificando 'clients': {e}")
        return

    # 2. Probar inserción en DELIVERIES con cálculo automático
    print("\n2. Probando tabla 'deliveries' y cálculo automático...")
    try:
        # Insertamos un proyecto con cobro por minuto
        # 10 minutos a $5.00 = $50.00 Total esperado
        test_delivery = {
            "client_id": test_client_id,
            "name": "Prueba de Migracion SOTA",
            "status": "briefing",
            "billing_type": "per_minute",
            "duration_minutes": 10,
            "rate_applied": 5
        }
        
        ins_res = supabase.table("deliveries").insert(test_delivery).execute()
        new_delivery = ins_res.data[0]
        delivery_id = new_delivery['id']
        
        print(f"   ✅ Entrega insertada ID: {delivery_id}")
        
        # Leemos de nuevo para ver el campo calculado (total_price)
        # A veces el insert retorna lo que envió, mejor hacer un select fresco
        read_res = supabase.table("deliveries").select("*").eq("id", delivery_id).single().execute()
        final_data = read_res.data
        
        total = final_data.get('total_price')
        
        print(f"   📊 Resultado: Duración={final_data['duration_minutes']}, Tasa={final_data['rate_applied']}")
        print(f"   💰 Total Calculado (DB): {total}")
        
        if float(total) == 50.0:
            print("   ✅ ¡ÉXITO! El cálculo automático funcionó correctamente.")
        else:
            print(f"   ❌ FALLO: El total debería ser 50.0, pero es {total}")

        # Limpieza
        print("\n3. Limpiando datos de prueba...")
        supabase.table("deliveries").delete().eq("id", delivery_id).execute()
        if not clients: # Si creamos el cliente solo para el test, lo borramos
            supabase.table("clients").delete().eq("id", test_client_id).execute()
        print("   ✅ Limpieza completada.")
        
    except Exception as e:
        print(f"   ❌ Error crítico en 'deliveries': {e}")
        print("   POSIBLE CAUSA: No se ejecutó el script SQL 'MIGRATION_SCHEMA_SOTA.sql' o falló.")
        return

    print("\n--- ✅ VERIFICACIÓN COMPLETADA EXITOSAMENTE ---")

if __name__ == "__main__":
    verify_migration()
