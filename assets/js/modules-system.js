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
            view: 'view-dashboard', // Sharing main dashboard for now
            description: 'Gestiona leads y conversiones'
        },
        {
            id: 'sales-clients',
            name: 'Mis Clientes',
            icon: 'users',
            view: 'view-dashboard',
            description: 'Base de datos de clientes'
        },
        {
            id: 'sales-commissions',
            name: 'Comisiones',
            icon: 'dollar-sign',
            view: 'view-dashboard',
            description: 'Control de ganancias'
        },
        {
            id: 'sales-leads',
            name: 'Leads / Prospectos',
            icon: 'user-plus',
            view: 'view-leads',
            description: 'Prospectos de la web'
        }
    ],
    production: [
        {
            id: 'production-desk',
            name: 'Mi Escritorio',
            icon: 'layout',
            view: 'view-my-desk',
            description: 'Proyectos asignados'
        },
        {
            id: 'production-pool',
            name: 'Tareas Disponibles',
            icon: 'briefcase',
            view: 'view-production-pool',
            description: 'Pool de proyectos'
        },
        {
            id: 'production-calendar',
            name: 'Calendario',
            icon: 'calendar',
            view: 'view-production-calendar',
            description: 'Planificación'
        },
        {
            id: 'production-balance',
            name: 'Mi Balance',
            icon: 'wallet',
            view: 'view-production-balance',
            description: 'Mis pagos'
        }
    ],
    rd: [
        {
            id: 'rd-experiments',
            name: 'Experimentos',
            icon: 'test-tube',
            view: 'view-rd-experiments',
            description: 'Investigación activa'
        },
        {
            id: 'rd-knowledge',
            name: 'Conocimiento',
            icon: 'book-open',
            view: 'view-rd-knowledge',
            description: 'Documentación y SOPs'
        },
        {
            id: 'rd-metrics',
            name: 'Métricas IA',
            icon: 'activity',
            view: 'view-rd-metrics',
            description: 'Performance de bots'
        }
    ],
    client: [
        {
            id: 'client-projects',
            name: 'Mis Proyectos',
            icon: 'video',
            view: 'view-client-projects',
            description: 'Estado de mis videos'
        },
        {
            id: 'client-billing',
            name: 'Facturación',
            icon: 'receipt',
            view: 'view-client-billing',
            description: 'Pagos y facturas'
        },
        {
            id: 'client-briefing',
            name: 'Nuevo Pedido',
            icon: 'plus-circle',
            view: 'view-client-briefing',
            description: 'Solicitar servicio'
        }
    ],
    admin: [
        {
            id: 'admin-dashboard',
            name: 'Dashboard Global',
            icon: 'pie-chart',
            view: 'view-dashboard',
            description: 'Resumen operativo'
        },
        {
            id: 'admin-team',
            name: 'Equipo',
            icon: 'users',
            view: 'view-team-mgmt',
            description: 'Gestión de miembros'
        },
        {
            id: 'admin-payments',
            name: 'Pagos',
            icon: 'credit-card',
            view: 'view-payments',
            description: 'Aprobación de pagos'
        },
        {
            id: 'admin-analytics',
            name: 'Analytics',
            icon: 'bar-chart-2',
            view: 'view-analytics',
            description: 'Reportes completos'
        },
        {
            id: 'admin-leads',
            name: 'Leads / Ventas',
            icon: 'contact',
            view: 'view-leads',
            description: 'Gestión de prospectos'
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
    // REFACTORED: Chat moved to Team View as per user request
    {
        id: 'common-cortex',
        name: 'Cortex AI',
        icon: 'brain',
        view: 'view-cortex'
    }
];

const VIEW_LOADERS = {
    'view-my-desk': 'loadDashboard', // Main projects loader handling my-desk
    'view-dashboard': 'loadDashboard',
    'view-sales-clients': 'loadConstants', // Fallback
    'view-payments': 'loadPaymentsDetails',
    'view-analytics': 'renderAnalytics',
    'view-team-mgmt': 'renderTeamMgmt',
    'view-leads': 'loadLeads',
    'view-cortex': 'renderOfficeBoard' // Or generic init
};

// === ESTADO GLOBAL ===
let currentUserDepartment = null;
let currentUserPermissions = [];
let currentDepartmentData = null;

// === FUNCIONES DE PERMISOS ===

/**
 * Obtener departamento del usuario actual
 */
async function getUserDepartment(userId) {
    // 🛡️ OFFLINE FALLBACK: If the user already has a department in their local data (Mock Mode)
    if (currentUser && currentUser.department) {
        console.log('📦 Using local department (Offline Mode):', currentUser.department);
        return { name: currentUser.department, display_name: currentUser.department.toUpperCase() };
    }

    try {
        // First try Team Members
        const { data: teamData, error: teamError } = await sb
            .from('team_members')
            .select('department_id, departments(name, display_name, icon, color), role')
            .eq('id', userId)
            .single();

        if (!teamError && teamData?.departments) return teamData.departments;

        // 🛡️ ROLE FALLBACK: If department is missing in DB, assign by role
        const role = teamData?.role || (currentUser?.id === userId ? currentUser.role : null);
        if (role === 'pm' || role === 'admin' || role === 'sales_head') {
            return { name: 'admin', display_name: 'MANAGEMENT', icon: 'shield-check', color: '#8b5cf6' };
        }
        if (role?.includes('editor') || role === 'designer') {
            return { name: 'production', display_name: 'PRODUCTION', icon: 'play-circle', color: '#10b981' };
        }

        // If not found or error, try Clients
        const { data: clientData, error: clientError } = await sb
            .from('clients')
            .select('id, name')
            .eq('id', userId)
            .single();

        if (clientData) {
            return { name: 'client', display_name: 'CLIENT PORTAL', color: 'violet' };
        }

        return null;
    } catch (e) {
        console.warn('⚠️ Error connecting to Supabase for department, using fallback.');
        const role = currentUser?.role;
        if (role === 'pm') return { name: 'admin', display_name: 'MANAGEMENT', icon: 'shield-check', color: '#8b5cf6' };
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
    console.log("🛠️ Generando Sidebar Dinámico...");
    const sidebars = document.querySelectorAll('#main-nav, #mobile-nav');
    if (sidebars.length === 0) {
        console.warn("⚠️ No se encontró el elemento #main-nav");
        return;
    }

    const modules = getAvailableModules();

    // Safety check: Don't wipe sidebar if no modules found
    if (!modules || modules.length === 0) {
        console.warn("⚠️ No modules found for user, keeping default sidebar.");
        return;
    }

    const deptModules = modules.filter(m => !m.id.startsWith('common-'));
    const commonModules = modules.filter(m => m.id.startsWith('common-'));

    console.log(`📦 Módulos a renderizar: ${deptModules.length} de depto, ${commonModules.length} comunes.`);

    sidebars.forEach(sidebar => {
        // Limpiar navegación actual
        sidebar.innerHTML = '';

        // Renderizar módulos del departamento
        deptModules.forEach((module, index) => {
            const navItem = document.createElement('a');
            navItem.href = '#';
            navItem.id = `nav-${module.id}`;
            // FIX: Using standardized classes for all items to prevent misalignment
            // Changed py-3 to py-2.5 and forced font-semibold text-sm for consistency
            navItem.className = `sidebar-item flex items-center gap-3 px-4 py-2.5 text-slate-400 rounded-xl ${index === 0 ? 'active' : ''}`;
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
                // FIX: Standardized classes here too
                navItem.className = 'sidebar-item flex items-center gap-3 px-4 py-2.5 text-slate-400 rounded-xl';
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

        // ⚠️ FALLBACK UI: Si no hay departamento detectado
        if (!currentUserDepartment && currentUser) {
            const alertItem = document.createElement('div');
            alertItem.className = 'mt-4 mx-4 p-3 bg-red-500/10 border border-red-500/20 rounded-xl';
            alertItem.innerHTML = `
                <div class="flex items-center gap-2 text-red-400 mb-1">
                    <i data-lucide="alert-circle" class="w-4 h-4"></i>
                    <span class="text-[10px] font-bold uppercase">Atención</span>
                </div>
                <p class="text-[10px] text-red-300 leading-tight">Sin departamento asignado. Contacta a un admin.</p>
             `;
            sidebar.appendChild(alertItem);
        }
    });

    // Recrear iconos de Lucide
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    } else if (typeof _lucide !== 'undefined') {
        _lucide.createIcons();
    }
}

/**
 * Actualizar header del sidebar con info del departamento
 */
function updateSidebarHeader() {
    // FIX: Target specific brand container to avoid erasing the Toggle Button
    const brandContainer = document.querySelector('aside .sidebar-brand');
    if (!brandContainer || !currentUserDepartment) return;

    brandContainer.innerHTML = `
        <div class="w-8 h-8 rounded-lg flex items-center justify-center transition-all duration-300" 
             style="background: ${currentUserDepartment.color}20; border: 1px solid ${currentUserDepartment.color}40;">
            <i data-lucide="${currentUserDepartment.icon}" class="w-5 h-5" style="color: ${currentUserDepartment.color}"></i>
        </div>
        <div class="flex flex-col">
            <h2 class="text-xs font-bold text-white tracking-wide">${currentUserDepartment.display_name}</h2>
            <p class="text-[9px] text-slate-500 leading-none mt-0.5 uppercase tracking-wider">${currentUser?.first_name || 'Member'}</p>
        </div>
    `;

    // Ensure parent flex alignment is correct for new content
    brandContainer.className = "flex items-center gap-3 sidebar-brand overflow-hidden";

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

        // Ejecutar loader si existe
        const loaderName = VIEW_LOADERS[viewId];
        if (loaderName && typeof window[loaderName] === 'function') {
            console.log(`🚀 Executing loader: ${loaderName}`);
            window[loaderName]();
        }
    }

    // Actualizar navegación activa
    document.querySelectorAll('.sidebar-item').forEach(item => {
        item.classList.remove('active');
    });

    const activeNav = document.getElementById(`nav-${viewId.replace('view-', '')}`) ||
        document.querySelector(`[onclick*="${viewId}"]`);
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
// FIX: Expose current department state for data filtering in other views
window.getCurrentDepartment = () => currentDepartmentData;

console.log('✅ Module System Loaded');
