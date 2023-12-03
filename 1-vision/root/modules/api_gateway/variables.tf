variable "bucket_name_auth" {
  type        = string
  description = "bucket name for auth lambda"
  default     = "1-vision-lambda-auth-apigateway"
}
variable "rest_api_name" {
  type    = string
  default = "1_vision_rest_api"
}

