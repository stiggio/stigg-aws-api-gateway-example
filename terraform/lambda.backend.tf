data "archive_file" "backend-lambda-code" {
  type        = "zip"
  source_dir  = "${path.root}/../backend"
  output_path = "${path.root}/../target/backend.zip"
}

resource "aws_lambda_function" "backend-lambda" {
  filename         = data.archive_file.backend-lambda-code.output_path
  source_code_hash = data.archive_file.backend-lambda-code.output_base64sha256

  function_name = "${local.prefix}-backend"
  role          = aws_iam_role.iam_role.arn
  handler       = "index.handler"
  runtime       = local.nodejs_version
  timeout       = 30
}

resource "aws_cloudwatch_log_group" "log-retention-backend-lambda" {
  name              = "/aws/lambda/${aws_lambda_function.backend-lambda.function_name}"
  retention_in_days = local.log_retention_days
}

resource "aws_lambda_permission" "backend-lambda-permission" {
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.backend-lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api-gateway.execution_arn}/*/*/api/**"
}