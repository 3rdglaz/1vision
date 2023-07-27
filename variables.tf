variable "git-secret" {
  type        = string
  description = "git secret for auth betwen amplify and github, it has expiretion date. It is setted on pipeline"
  sensitive   = true
  default     = ""
}
