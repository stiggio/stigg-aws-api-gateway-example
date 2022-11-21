data "archive_file" "node-server-sdk-layer" {
  type        = "zip"
  source_dir  = "${path.root}/../node-server-sdk-layer"
  output_path = "${path.root}/../target/node-server-sdk-layer.zip"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = data.archive_file.node-server-sdk-layer.output_path
  layer_name = "${local.prefix}-node-server-sdk-layer"

  compatible_runtimes = [local.nodejs_version]
}