resource "aws_amplify_app" "front-end" {
  name       = var.amplify-name
  repository = var.amplify-repositorie

  # GitHub personal access token
  access_token = var.amplify-git-secret

  platform = "WEB_COMPUTE"

  # The default build_spec added by the Amplify Console for React.
  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - npm ci
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: .next
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT


  # The default rewrites and redirects added by the Amplify Console.
  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }

}

## BRANCHS ##
resource "aws_amplify_branch" "branches" {
  app_id      = aws_amplify_app.front-end.id
  for_each    = toset(["develop", "main"])
  branch_name = each.value
}

output "url" {
  value = aws_amplify_app.front-end.id
}
