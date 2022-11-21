data "archive_file" "authorizer-lambda-code" {
  type        = "zip"
  source_dir  = "${path.root}/../authorizer"
  output_path = "${path.root}/../target/authorizer.zip"
}

resource "aws_lambda_function" "authorizer-lambda" {
  filename         = data.archive_file.authorizer-lambda-code.output_path
  source_code_hash = data.archive_file.authorizer-lambda-code.output_base64sha256

  function_name = "${local.prefix}-authorizer"
  role          = aws_iam_role.iam_role.arn
  handler       = "index.handler"
  runtime       = local.nodejs_version
  timeout       = 30
  layers        = [aws_lambda_layer_version.lambda_layer.arn]
  environment {
    variables = {
      STIGG_SERVER_API_KEY = var.stigg_server_api_key
    }
  }
}

resource "aws_cloudwatch_log_group" "log-retention-authorizer-lambda" {
  name              = "/aws/lambda/${aws_lambda_function.authorizer-lambda.function_name}"
  retention_in_days = local.log_retention_days
}

resource "aws_lambda_permission" "authorizer-lambda-permission" {
  statement_id  = "AllowExecutionFromApiGatewayAuthorizer"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.authorizer-lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api-gateway.execution_arn}/authorizers/${aws_apigatewayv2_authorizer.authorizer.id}"
}