/**
 * ========================================
 * MÓDULOS POR DEPARTAMENTO - Frontend Logic
 * Sistema de Permisos y Navegación Dinámica
 * ========================================
 */

// === CONFIGURACIÓN DE MÓDULOS POR DEPARTAMENTO ===

const DEPARTMENT_MODULES = {
    sales: [
        {
            id: 'sales-pipeline',
            name: 'Pipeline',
            icon: 'trending-up',
            view: 'view-sales-pipeline',
            description: 'Gestiona leads y conversiones'
        },
        {
            id: 'sales-clients',
            name: 'Clientes',
            icon: 'users',
            view: 'view-sales-clients',
            description: 'Clientes activos y prospectos'
        },
        {
            id: 'sales-commissions',
            name: 'Comisiones',
            icon: 'dollar-sign',
            view: 'view-sales-commissions',
            description: 'Tus comisiones ganadas'
        }
    ],
    production: [
        {
            id: 'production-desk',
            name: 'Mi Escritorio',
            icon: 'briefcase',
            view: 'view-production-desk',
            description: 'Proyectos asignados'
        },
        {
            id: 'production-pool',
            name: 'Tareas Disponibles',
            icon: 'inbox',
            view: 'view-production-pool',
            description: 'Toma proyectos del pool'
        },
        {
            id: 'production-calendar',
            name: 'Calendario',
            icon: 'calendar',
            view: 'view-production-calendar',
            description: 'Deadlines y entregas'
        },
        {
            id: 'production-balance',
            name: 'Mi Balance',
            icon: 'wallet',
            view: 'view-production-balance',
            description: 'Pagos y finanzas personales'
        }
    ],
    rd: [
        {
            id: 'rd-experiments',
            name: 'Experimentos',
            icon: 'flask-conical',
            view: 'view-rd-experiments',
            description: 'Proyectos de investigación'
        },
        {
            id: 'rd-knowledge',
            name: 'Base de Conocimiento',
            icon: 'book-open',
            view: 'view-rd-knowledge',
            description: 'Documentación y hallazgos'
        },
        {
            id: 'rd-metrics',
            name: 'Métricas IA',
            icon: 'activity',
            view: 'view-rd-metrics',
            description: 'Performance de bots'
        }
    ],
    admin: [
        {
            id: 'admin-dashboard',
            name: 'Dashboard Global',
            icon: 'layout-dashboard',
            view: 'view-dashboard',
            description: 'Vista general de la agencia'
        },
        {
            id: 'admin-team',
            name: 'Equipo',
            icon: 'users-2',
            view: 'view-team-mgmt',
            description: 'Gestión de miembros'
        },
        {
            id: 'admin-finances',
            name: 'Finanzas',
            icon: 'dollar-sign',
            view: 'view-payments',
            description: 'Pagos y balances globales'
        },
        {
            id: 'admin-analytics',
            name: 'Métricas',
            icon: 'bar-chart-3',
            view: 'view-analytics',
            description: 'Análisis y reportes'
        }
    ]
};

// Módulos comunes para todos los departamentos
const COMMON_MODULES = [
    {
        id: 'common-notifications',
        name: 'Notificaciones',
        icon: 'bell',
        view: 'view-notifications',
        badge: true
    },
    {
        id: 'common-chat',
        name: 'Chat',
        icon: 'message-circle',
        view: 'view-chat',
        badge: true
    }
];

// === ESTADO GLOBAL ===
let currentUserDepartment = null;
let currentUserPermissions = [];
let currentDepartmentData = null;

// === FUNCIONES DE PERMISOS ===

/**
 * Obtener departamento del usuario actual
 */
async function getUserDepartment(userId) {
    try {
        const { data, error } = await sb
            .from('team_members')
            .select('department_id, departments(name, display_name, icon, color)')
            .eq('id', userId)
            .single();

        if (error) throw error;
        return data?.departments || null;
    } catch (e) {
        console.error('Error getting user department:', e);
        return null;
    }
}

/**
 * Obtener permisos del usuario
 */
async function getUserPermissions(userId) {
    try {
        const { data, error } = await sb
            .rpc('get_user_modules', { p_user_id: userId });

        if (error) throw error;
        return data || [];
    } catch (e) {
        console.error('Error getting user permissions:', e);
        return [];
    }
}

/**
 * Verificar si el usuario tiene permiso para un módulo
 */
function canAccessModule(moduleName, action = 'read') {
    // Admin siempre tiene acceso
    if (currentUser?.role === 'pm') return true;

    const permission = currentUserPermissions.find(p => p.module_name === moduleName);
    if (!permission) return false;

    switch (action) {
        case 'read': return permission.can_read;
        case 'create': return permission.can_create;
        case 'update': return permission.can_update;
        case 'delete': return permission.can_delete;
        default: return false;
    }
}

/**
 * Obtener módulos disponibles para el usuario
 */
function getAvailableModules() {
    if (!currentUserDepartment) return COMMON_MODULES;

    const deptModules = DEPARTMENT_MODULES[currentUserDepartment.name] || [];
    return [...deptModules, ...COMMON_MODULES];
}

// === RENDERIZADO DE NAVEGACIÓN ===

/**
 * Renderizar sidebar dinámico según departamento
 */
function renderDynamicSidebar() {
    const sidebar = document.querySelector('aside nav');
    if (!sidebar) return;

    const modules = getAvailableModules();
    const deptModules = modules.filter(m => !m.id.startsWith('common-'));
    const commonModules = modules.filter(m => m.id.startsWith('common-'));

    // Limpiar navegación actual
    sidebar.innerHTML = '';

    // Renderizar módulos del departamento
    deptModules.forEach((module, index) => {
        const navItem = document.createElement('a');
        navItem.href = '#';
        navItem.id = `nav-${module.id}`;
        navItem.className = `sidebar-item flex items-center gap-3 px-4 py-3 text-slate-400 rounded-xl ${index === 0 ? 'active' : ''}`;
        navItem.onclick = (e) => {
            e.preventDefault();
            showModuleView(module.view);
        };

        navItem.innerHTML = `
            <i data-lucide="${module.icon}" class="w-5 h-5"></i>
            <span class="font-semibold text-sm">${module.name}</span>
        `;

        sidebar.appendChild(navItem);
    });

    // Separador
    if (commonModules.length > 0) {
        const separator = document.createElement('div');
        separator.className = 'pt-4 border-t border-white/5 mt-4';
        sidebar.appendChild(separator);

        // Renderizar módulos comunes
        commonModules.forEach(module => {
            const navItem = document.createElement('a');
            navItem.href = '#';
            navItem.id = `nav-${module.id}`;
            navItem.className = 'sidebar-item flex items-center gap-3 px-4 py-3 text-slate-400 rounded-xl';
            navItem.onclick = (e) => {
                e.preventDefault();
                showModuleView(module.view);
            };

            navItem.innerHTML = `
                <i data-lucide="${module.icon}" class="w-5 h-5"></i>
                <span class="font-semibold text-sm">${module.name}</span>
                ${module.badge ? '<span class="ml-auto w-2 h-2 bg-violet-500 rounded-full"></span>' : ''}
            `;

            sidebar.appendChild(navItem);
        });
    }

    // Recrear iconos de Lucide
    if (typeof lucide !== 'undefined') lucide.createIcons();
}

/**
 * Actualizar header del sidebar con info del departamento
 */
function updateSidebarHeader() {
    const headerDiv = document.querySelector('aside .p-6');
    if (!headerDiv || !currentUserDepartment) return;

    headerDiv.innerHTML = `
        <div class="flex items-center gap-3">
            <div class="w-10 h-10 rounded-xl flex items-center justify-center" 
                 style="background: ${currentUserDepartment.color}20; border: 2px solid ${currentUserDepartment.color}40;">
                <i data-lucide="${currentUserDepartment.icon}" class="w-6 h-6" style="color: ${currentUserDepartment.color}"></i>
            </div>
            <div>
                <h2 class="text-sm font-bold text-white">${currentUserDepartment.display_name}</h2>
                <p class="text-xs text-slate-500">${currentUser?.first_name || 'Usuario'}</p>
            </div>
        </div>
    `;

    if (typeof lucide !== 'undefined') lucide.createIcons();
}

/**
 * Mostrar vista de módulo
 */
function showModuleView(viewId) {
    // Ocultar todas las vistas
    document.querySelectorAll('[id^="view-"]').forEach(view => {
        view.classList.add('hidden');
    });

    // Mostrar vista solicitada
    const targetView = document.getElementById(viewId);
    if (targetView) {
        targetView.classList.remove('hidden');
    }

    // Actualizar navegación activa
    document.querySelectorAll('.sidebar-item').forEach(item => {
        item.classList.remove('active');
    });

    const activeNav = document.querySelector(`[onclick*="${viewId}"]`);
    if (activeNav) {
        activeNav.classList.add('active');
    }
}

// === INICIALIZACIÓN ===

/**
 * Inicializar sistema de módulos
 */
async function initModuleSystem() {
    if (!currentUser) {
        console.warn('No user logged in, skipping module system init');
        return;
    }

    try {
        // Obtener departamento del usuario
        currentUserDepartment = await getUserDepartment(currentUser.id);
        currentDepartmentData = currentUserDepartment;

        // Obtener permisos
        currentUserPermissions = await getUserPermissions(currentUser.id);

        console.log('Module System Initialized:', {
            department: currentUserDepartment,
            permissions: currentUserPermissions
        });

        // Renderizar UI dinámica
        updateSidebarHeader();
        renderDynamicSidebar();

        // Mostrar primera vista del departamento
        const firstModule = getAvailableModules()[0];
        if (firstModule) {
            showModuleView(firstModule.view);
        }

    } catch (e) {
        console.error('Error initializing module system:', e);
        renderToast('Error al cargar módulos del departamento', 'error');
    }
}

// === EXPORTAR FUNCIONES GLOBALES ===
window.initModuleSystem = initModuleSystem;
window.canAccessModule = canAccessModule;
window.showModuleView = showModuleView;
window.getUserDepartment = getUserDepartment;
window.getUserPermissions = getUserPermissions;

console.log('✅ Module System Loaded');
