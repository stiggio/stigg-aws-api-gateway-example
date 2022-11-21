resource "aws_apigatewayv2_api" "api-gateway" {
  name          = "${local.prefix}-api-gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "api-gateway-stage" {
  api_id      = aws_apigatewayv2_api.api-gateway.id
  name        = "$default"
  auto_deploy = true
}