resource "aws_amplify_app" "front-end" {
  name       = var.amplify-name
  repository = var.amplify-repositorie

  # GitHub personal access token
  access_token = var.amplify-git-secret

  enable_auto_branch_creation = true

  # The default patterns added by the Amplify Console.
  auto_branch_creation_patterns = [
    "*",
    "*/**",
  ]
  auto_branch_creation_config {
    enable_auto_build           = true
    enable_basic_auth           = false
    enable_performance_mode     = false
    enable_pull_request_preview = false
  }

  
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

  #não parece fazer sentido
  environment_variables = {
    ENV = "backend"
  }
}

## BRANCHS ##
resource "aws_amplify_branch" "branches" {
  app_id      = aws_amplify_app.front-end.id
  for_each    = toset(["develop", "main", "release"])
  branch_name = each.value
}

output "url" {
  value = aws_amplify_app.front-end.id
}