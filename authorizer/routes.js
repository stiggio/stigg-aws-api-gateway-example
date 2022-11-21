const { STIGG_FEATURE_COLLABORATORS, STIGG_FEATURE_TODOS, STIGG_FEATURE_UPDATE_TODO } = require("./features");

const collaboratorsRoutes = [
    {
        method: 'POST',
        path: '/api/collaborators/',
        entitlements: [{ feature: STIGG_FEATURE_COLLABORATORS, requestedUsage: 1 }],
    },
    {
        method: 'DELETE',
        path: '/api/collaborators/:email',
        entitlements: [{ feature: STIGG_FEATURE_COLLABORATORS }],
    },
    {
        method: 'POST',
        path: '/api/collaborators/add-seats',
        entitlements: [{ feature: STIGG_FEATURE_COLLABORATORS }],
    },
];

const todosRoutes = [
    {
        method: 'GET',
        path: '/api/todos/',
        entitlements: [{ feature: STIGG_FEATURE_TODOS }],
    },
    {
        method: 'POST',
        path: '/api/todos/',
        entitlements: [{ feature: STIGG_FEATURE_TODOS, requestedUsage: 1 }],
    },
    {
        method: 'PUT',
        path: '/api/todos/:id',
        entitlements: [{ feature: STIGG_FEATURE_TODOS }, { feature: STIGG_FEATURE_UPDATE_TODO }],
    },
    {
        method: 'DELETE',
        path: '/api/todos/:id',
        entitlements: [{ feature: STIGG_FEATURE_TODOS }],
    },
];

module.exports = {
    routes: [
        ...collaboratorsRoutes,
        ...todosRoutes,
    ],
};