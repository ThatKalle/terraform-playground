resource "github_repository_environment" "production" {
  environment       = "production"
  repository        = github_repository.this.name
  can_admins_bypass = true

  reviewers {
    users = [data.github_user.thatkalle.id]
  }

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_repository_deployment_branch_policy" "production" {
  repository       = github_repository.this.name
  environment_name = github_repository_environment.production.environment
  name             = "main"

  depends_on = [
    github_repository_environment.production
  ]
}

# resource "github_repository_environment" "staging" {
#   environment       = "staging"
#   repository        = github_repository.this.name
#   can_admins_bypass = true

#   deployment_branch_policy {
#     protected_branches     = false
#     custom_branch_policies = true
#   }
# }

# resource "github_repository_deployment_branch_policy" "staging" {
#   repository       = github_repository.this.name
#   environment_name = github_repository_environment.staging.environment
#   name             = "staging"

#   depends_on = [
#     github_repository_environment.staging
#   ]
# }
