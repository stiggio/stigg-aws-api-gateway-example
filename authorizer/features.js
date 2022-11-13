const STIGG_FEATURE_COLLABORATORS = {
    id: 'feature-collaborators',
    fallback: {
        hasAccess: true,
        usageLimit: 5,
    },
};

const STIGG_FEATURE_TODOS = {
    id: 'feature-todos',
    fallback: {
        hasAccess: true,
        usageLimit: 5,
    },
};

const STIGG_FEATURE_UPDATE_TODO = {
    id: 'feature-update-todo',
    fallback: {
        hasAccess: true,
    },
};

module.exports = {
    STIGG_FEATURE_COLLABORATORS,
    STIGG_FEATURE_TODOS,
    STIGG_FEATURE_UPDATE_TODO,
};