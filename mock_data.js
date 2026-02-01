// 🎭 MOCK DATA GENERATOR
// Se usa cuando falla la conexión a Supabase

const MOCK_DATA = {
    team: [
        { id: '1', first_name: 'Marco', role: 'pm', password: '123' },
        { id: '2', first_name: 'Pedro', role: 'editor_sr', password: '123' },
        { id: '3', first_name: 'Antigravity', role: 'ai_bot', password: '123' }
    ],
    clients: [
        { id: 'c1', name: 'Mock Company', whatsapp: '000' }
    ],
    projects: [
        {
            id: 'p1',
            service_type: 'video',
            status: 'production',
            priority: 5,
            assigned_to: '2',
            client_id: 'c1',
            clients: { name: 'Mock Company', whatsapp: '000' },
            team_members: { first_name: 'Pedro' },
            checklist: []
        },
        {
            id: 'p2',
            service_type: 'reel',
            status: 'briefing',
            priority: 3,
            client_id: 'c1',
            clients: { name: 'Mock Company' },
            checklist: []
        }
    ],
    payments: [
        { id: 'pay1', amount: 150.00, status: 'paid', editor_id: '2', created_at: new Date().toISOString() }
    ]
};

console.log("⚠️ MOCK DATA LOADED");
