resource "aws_apigatewayv2_integration" "backend-lambda-integration" {
  api_id                 = aws_apigatewayv2_api.api-gateway.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.backend-lambda.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "todos-route" {
  api_id             = aws_apigatewayv2_api.api-gateway.id
  route_key          = "ANY /api/todos/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.backend-lambda-integration.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.authorizer.id
  authorization_type = "CUSTOM"
}

resource "aws_apigatewayv2_route" "collaborators-route" {
  api_id             = aws_apigatewayv2_api.api-gateway.id
  route_key          = "ANY /api/collaborators/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.backend-lambda-integration.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.authorizer.id
  authorization_type = "CUSTOM"
}