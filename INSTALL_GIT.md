# ⚡ INSTALACIÓN RÁPIDA DE GIT - Pasos Manuales

## 🔧 Método 1: Descarga Directa (Recomendado)

### Paso 1: Descargar Git
1. Abre tu navegador
2. Ve a: **https://git-scm.com/download/win**
3. Click en **"Click here to download"** (64-bit)
4. Se descargará un archivo como: `Git-2.43.0-64-bit.exe`

### Paso 2: Instalar
1. Ejecuta el instalador descargado
2. **Configuración recomendada:**
   - ✅ Use Git from Git Bash and from the Windows Command Prompt
   - ✅ Use the OpenSSL library
   - ✅ Checkout Windows-style, commit Unix-style line endings
   - ✅ Use MinTTY (Default)
   - ✅ Default (fast-forward or merge)
   - ✅ Git Credential Manager
3. Click "Next" hasta finalizar
4. **MUY IMPORTANTE:** Al terminar, cierra y vuelve a abrir PowerShell

### Paso 3: Verificar Instalación
Abre PowerShell y ejecuta:
```powershell
git --version
```

Deberías ver algo como: `git version 2.43.0.windows.1`

---

## 🔧 Método 2: Portable (Sin instalación)

Si no puedes instalar programas:

1. Descarga: **https://github.com/git-for-windows/git/releases/latest**
2. Busca el archivo: `PortableGit-X.XX.X-64-bit.7z.exe`
3. Ejecuta y extrae a una carpeta (ej: `C:\PortableGit`)
4. Usa Git desde esa carpeta

---

## 🔧 Método 3: Chocolatey (Si lo tienes)

```powershell
choco install git -y
```

---

## 🔧 Método 4: Scoop (Si lo tienes)

```powershell
scoop install git
```

---

## ✅ Después de Instalar

Configura Git con tu información:

```powershell
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

---

## 📝 Próximo Paso

Una vez instalado Git, ejecuta estos comandos en PowerShell:

```powershell
# Ve al directorio del proyecto
cd "C:\Users\Junta de cond CIA\Documents\IAmazingContentDocumentation"

# Inicializa el repositorio
git init

# Cambia a la rama main
git branch -M main

# Verifica qué se va a subir
git status
```

**IMPORTANTE:** Antes de hacer `git add .`, verifica que en la lista NO aparezcan:
- ❌ config.js
- ❌ .env

Si aparecen, hay un problema con el .gitignore.

---

## 🆘 Si tienes problemas

Déjame saber en qué paso te quedaste y te ayudo a continuar.
