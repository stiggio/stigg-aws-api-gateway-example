const { stiggClient } = require("./stiggClient");
const { routes } = require("./routes");

function findStiggCustomerId(token) {
    // For simplicity, we use user customer id as token and not JWT token.
    // For real integration replace this with extracting it from JWT token or DB lookup.
    return token?.replace(/^Bearer /, '');
}

// check if a path matches to pathDefinition
// .e.g. /api/test/123 will match /api/test/:id
function isPathMatch(path, pathDefinition) {
    const regex = new RegExp(`^${pathDefinition.replace(/:[a-z]+/gi, '([^/]+)')}$`);
    return regex.test(path);
}

function checkEntitlement(customerId, { feature, requestedUsage }) {
    return stiggClient.getMeteredEntitlement({
        customerId,
        featureId: feature.id,
        options: {
            fallback: feature.fallback,
            requestedUsage,
        },
    });
}

async function checkRouteEntitlements(method, path, authorization) {
    if (!method || !path || !authorization) {
        console.warn('Missing request parameters');
        return false;
    }

    const customerId = findStiggCustomerId(authorization);
    const route = routes.find((route) => route.method === method && isPathMatch(path, route.path));

    if (!route) {
        console.warn(`Missing configuration for route '${method} ${path}'`);
        return false;
    }

    let isAuthorized = true;

    for (const entitlementToCheck of route.entitlements) {
        const entitlement = await checkEntitlement(customerId, entitlementToCheck);
        console.debug(`Entitlement response for '${entitlementToCheck.feature.id}'`, entitlement);

        isAuthorized = isAuthorized && entitlement.hasAccess;
    }

    console.info(`Route '${method} ${path}' response for '${customerId}' - ${isAuthorized}`);
    return isAuthorized;
}

module.exports = {
    checkRouteEntitlements,
};