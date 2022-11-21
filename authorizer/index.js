const { checkRouteEntitlements } = require("./checkRouteEntitlements");

exports.handler = async (event, context) => {
    // fetch requested resource from API Gateway authorizer event
    const { method, path } = event?.requestContext?.http;
    const { authorization } = event?.headers;

    // check gating in Stigg for resource
    const isAuthorized = await checkRouteEntitlements(method, path, authorization);

    context.succeed({ isAuthorized });
};