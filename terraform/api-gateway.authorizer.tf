resource "aws_apigatewayv2_authorizer" "authorizer" {
  api_id                            = aws_apigatewayv2_api.api-gateway.id
  name                              = "authorizer"
  authorizer_type                   = "REQUEST"
  authorizer_payload_format_version = "2.0"
  authorizer_result_ttl_in_seconds  = 0
  authorizer_uri                    = aws_lambda_function.authorizer-lambda.invoke_arn
  enable_simple_responses           = true
}