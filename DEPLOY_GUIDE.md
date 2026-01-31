# 🚀 Guía de Despliegue a GitHub - IAmazing Dashboard

## Decisiones Tomadas
- **Tipo de Repositorio:** Nuevo repositorio privado
- **Método:** Instalación de Git + Push directo
- **Seguridad:** ✅ Todas las credenciales protegidas

---

## 📋 Pasos de Despliegue

### 1️⃣ Instalar Git para Windows
```powershell
# Descargar usando winget (recomendado)
winget install --id Git.Git -e --source winget

# O descargar manualmente desde:
# https://git-scm.com/download/win
```

### 2️⃣ Configurar Git (Primera vez)
```powershell
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

### 3️⃣ Inicializar Repositorio Local
```powershell
cd "C:\Users\Junta de cond CIA\Documents\IAmazingContentDocumentation"
git init
git branch -M main
```

### 4️⃣ Verificar Archivos a Incluir
```powershell
# Ver qué archivos se rastrearán
git status

# IMPORTANTE: Verificar que NO aparezcan:
# - config.js
# - .env
```

### 5️⃣ Primer Commit
```powershell
git add .
git commit -m "Initial commit: IAmazing Dashboard v4.1 - Security Hardened"
```

### 6️⃣ Crear Repositorio en GitHub

**Opción A: Via Navegador**
1. Ve a https://github.com/new
2. Nombre: `IAmazingContentDocumentation` (o el que prefieras)
3. Descripción: "Dashboard de Control Operativo Inteligente para Agencias"
4. ✅ Selecciona **Private**
5. ❌ NO inicialices con README (ya lo tenemos)
6. Click en "Create repository"

**Opción B: Via GitHub CLI** (si tienes gh instalado)
```powershell
gh repo create IAmazingContentDocumentation --private --source=. --remote=origin
```

### 7️⃣ Conectar y Subir
```powershell
# Usa la URL que GitHub te da (ejemplo):
git remote add origin https://github.com/TU_USUARIO/IAmazingContentDocumentation.git

# Push inicial
git push -u origin main
```

---

## ✅ Verificación Post-Despliegue

Después de subir, verifica en GitHub:

1. **Archivos Protegidos NO aparecen:**
   - ❌ `config.js` NO debe estar
   - ❌ `.env` NO debe estar
   - ❌ `.agent/` NO debe estar

2. **Archivos Públicos SÍ aparecen:**
   - ✅ `README.md`
   - ✅ `dashboard.html`
   - ✅ `config.example.js`
   - ✅ `SETUP.md`

3. **Funcionamiento:**
   - Clona el repo en otra carpeta
   - Copia `config.example.js` como `config.js`
   - Configura tus credenciales
   - Abre `dashboard.html`
   - ✅ Debe funcionar correctamente

---

## 🔒 Seguridad Post-Despliegue

### Colaboradores
Si vas a agregar colaboradores:

1. Ve a Settings → Collaborators
2. Agrega solo usuarios de confianza
3. Dale permisos de "Write" o "Read" según necesidad

### Secrets de GitHub (Opcional)
Para CI/CD futuro, puedes guardar secretos:

1. Settings → Secrets and variables → Actions
2. New repository secret
3. Nombre: `SUPABASE_URL`, `SUPABASE_ANON_KEY`

---

## 📝 Comandos Git Útiles

```powershell
# Ver estado del repo
git status

# Ver historial
git log --oneline

# Crear una nueva rama
git checkout -b feature/nueva-funcionalidad

# Subir cambios
git add .
git commit -m "Descripción del cambio"
git push

# Actualizar desde GitHub
git pull
```

---

## 🆘 Solución de Problemas

### Error: "Git no reconocido"
- Reinicia PowerShell después de instalar Git
- O usa la ruta completa: `C:\Program Files\Git\bin\git.exe`

### Error: "Authentication failed"
- GitHub ya no acepta contraseñas desde 2021
- Usa un **Personal Access Token (PAT)**:
  1. GitHub → Settings → Developer settings → Personal access tokens
  2. Generate new token (classic)
  3. Selecciona scope: `repo`
  4. Usa el token como contraseña

### Error: "Permission denied (publickey)"
- Configura SSH keys:
  ```powershell
  ssh-keygen -t ed25519 -C "tu@email.com"
  cat ~/.ssh/id_ed25519.pub
  # Copia y pega en GitHub → Settings → SSH Keys
  ```

---

## 🎉 Siguiente Pasos

Una vez desplegado:

1. **Comparte el repo** con tu equipo (Settings → Collaborators)
2. **Documenta el proceso** en tu wiki interna
3. **Configura protección** de la rama main (Settings → Branches)
4. **Crea un proyecto** en GitHub Projects para tracking

---

**¡Listo para desplegar!** 🚀
