variable "bucket_name_auth"{
    type = string
    description = "bucket name for auth lambda"
    default = "lambda-1-vision-auth-apigateway"
}
variable "rest_api_name" {
  type = string
  default = "rest_api_1_vision"
}