data "archive_file" "auth" {
  type = "zip"

  source_dir  = "${path.module}/authorizer"
  output_path = "${path.module}/authorizer.zip"
}

data "archive_file" "api" {
  type = "zip"

  source_dir  = "${path.module}/api"
  output_path = "${path.module}/api.zip"
}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.bucket_name_auth
}



resource "aws_s3_object" "lambda_auth" {
  bucket = aws_s3_bucket.lambda_bucket.id
  depends_on = [
    aws_s3_bucket.lambda_bucket
  ]
  key    = "nodejs.zip"
  source = data.archive_file.auth.output_path

  etag = filemd5(data.archive_file.auth.output_path)
}

resource "aws_s3_object" "lambda_api" {
  bucket = aws_s3_bucket.lambda_bucket.id
  depends_on = [
    aws_s3_bucket.lambda_bucket
  ]
  key    = "api.zip"
  source = data.archive_file.api.output_path

  etag = filemd5(data.archive_file.api.output_path)
}


data "aws_iam_policy_document" "invocation_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type       = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "invocation_role" {
  name               = "api_gateway_auth_invocation"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.invocation_assume_role.json
}

data "aws_iam_policy_document" "invocation_policy" {
  statement {
    effect    = "Allow"
    actions   = ["lambda:*"]
    resources = [aws_lambda_function.authorizer.arn]
  }
}

resource "aws_iam_role_policy" "invocation_policy" {
  name   = "default"
  role   = aws_iam_role.invocation_role.id
  policy = data.aws_iam_policy_document.invocation_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "api_gateway_authorizer_role" {
  name = "api_gateway_authorizer_role"
  path = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "api_gateway_authorizer_policy" {
  name = "api_gateway_authorizer_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "lambda:*"
        ]
        Effect = "Allow"
        Resource = "${aws_lambda_function.authorizer.arn}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "api_gateway_authorizer_role_policy_attachment" {
  policy_arn = aws_iam_policy.api_gateway_authorizer_policy.arn
  role       = aws_iam_role.api_gateway_authorizer_role.name
}

resource "aws_cloudwatch_log_group" "loggroup" {
  name              = "/aws/lambda/${aws_lambda_function.authorizer.function_name}/lambda"
  retention_in_days = 14
}

data "aws_iam_policy_document" "lambda_exec_role_policy_without_createloggroup" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}

resource "aws_iam_role_policy" "lambda_exec_role_without_createloggroup" {
  role   = aws_iam_role.lambda.id
  policy = data.aws_iam_policy_document.lambda_exec_role_policy_without_createloggroup.json
}

resource "aws_iam_role" "lambda" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
	{
	  "Action": "sts:AssumeRole",
	  "Principal": {
		"Service": "lambda.amazonaws.com"
	  },
	  "Effect": "Allow"
	}
  ]
}
EOF
}




