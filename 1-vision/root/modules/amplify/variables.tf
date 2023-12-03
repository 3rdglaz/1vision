variable "aws_region" {
  type        = string
  description = ""
  default     = "us-east-1"
}
variable "aws_profile" {
  type        = string
  description = "shoudl be used as a github-secret"
  default     = "AdministratorAcces-460225759389"
}
variable "domain" {
  type        = string
  description = ""
  default     = ""
}
variable "amplify-name" {
  type        = string
  description = "the name of the app"
  default     = "https://github.com/1-vision/1-recipe-frontend"
}
variable "amplify-repositorie" {
  type        = string
  description = "git repo where the SPA/front-end+back-end resides"
  default     = "https://github.com/1-vision/1-recipe-frontend"
}
variable "amplify-git-secret" {
  type        = string
  description = "git secret for auth betwen amplify and github, it has expiretion date. It is setted on pipeline"
  sensitive   = true
  default     = ""
}
