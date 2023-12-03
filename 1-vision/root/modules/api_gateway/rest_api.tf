resource "aws_api_gateway_rest_api" "rest_api" {
  name = var.rest_api_name
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "example"
      version = "1.0"
    }
    paths = {
      "/path1" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })
}

resource "aws_iam_role" "api_authorizer" {
  name = "api-authorizer"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.lambda_authorizer.id
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_authorizer" "lambda_authorizer" {
  name                             = "api_gateway_authorizer"
  rest_api_id                      = aws_api_gateway_rest_api.rest_api.id
  authorizer_uri                   = aws_lambda_function.authorizer.invoke_arn
  type                             = "TOKEN"
  authorizer_result_ttl_in_seconds = 500
  authorizer_credentials           = aws_iam_role.api_authorizer.arn

}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "ANY"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api.invoke_arn
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

resource "aws_api_gateway_deployment" "deploy_api" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  stage_name  = "local"
  depends_on = [
    aws_api_gateway_method.method,
    aws_api_gateway_resource.resource,
    aws_api_gateway_authorizer.lambda_authorizer,
    aws_api_gateway_integration.integration
  ]
}

resource "aws_lambda_function" "authorizer" {
  runtime          = "nodejs14.x"
  function_name    = "api_gateway_lambda_authorizer"
  s3_bucket        = aws_s3_bucket.lambda_bucket.bucket
  s3_key           = aws_s3_object.lambda_auth.key
  role             = aws_iam_role.lambda.arn
  handler          = "lambda.handler"
  source_code_hash = data.archive_file.auth.output_base64sha256
}

resource "aws_lambda_function" "api" {
  runtime          = "nodejs14.x"
  function_name    = "api_gateway_lambda_api"
  s3_bucket        = aws_s3_bucket.lambda_bucket.bucket
  s3_key           = aws_s3_object.lambda_api.key
  role             = aws_iam_role.lambda.arn
  handler          = "lambda2.handler"
  source_code_hash = data.archive_file.api.output_base64sha256
}

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.deploy_api.id
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  stage_name    = "example"
}

resource "aws_apigatewayv2_api" "example-v2-api" {
  name          = "example-http-api"
  protocol_type = "HTTP"

}

resource "aws_apigatewayv2_authorizer" "example-v2-authorizer" {
  api_id                            = aws_apigatewayv2_api.example-v2-api.id
  authorizer_type                   = "REQUEST"
  enable_simple_responses           = true
  authorizer_uri                    = aws_lambda_function.authorizer.invoke_arn
  identity_sources                  = ["$request.header.Authorization"]
  name                              = "example-authorizer"
  authorizer_payload_format_version = "2.0"
  authorizer_credentials_arn        = aws_iam_role.api_gateway_authorizer_role.arn
}

resource "aws_apigatewayv2_integration" "example" {
  api_id                    = aws_apigatewayv2_api.example-v2-api.id
  integration_type          = "AWS_PROXY"
  connection_type           = "INTERNET"
  content_handling_strategy = "CONVERT_TO_TEXT"
  description               = "Lambda example"
  integration_method        = "POST"
  integration_uri           = aws_lambda_function.api.invoke_arn
  passthrough_behavior      = "WHEN_NO_MATCH"
}



resource "aws_apigatewayv2_deployment" "example" {
  api_id      = aws_apigatewayv2_api.example-v2-api.id
  description = "Example deployment"
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_apigatewayv2_route" "example" {
  api_id             = aws_apigatewayv2_api.example-v2-api.id
  route_key          = "ANY /example/{proxy+}"
  authorization_type = "CUSTOM"
  authorizer_id      = aws_apigatewayv2_authorizer.example-v2-authorizer.id
  target             = "integrations/${aws_apigatewayv2_integration.example.id}"
}
