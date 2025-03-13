resource "github_branch" "main" {
  repository = github_repository.terraform_playground.name
  branch     = "main"

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_default" "default" {
  repository = github_repository.terraform_playground.name
  branch     = github_branch.main.branch
}

resource "github_branch_protection" "branch_protection" {
  repository_id          = github_repository.terraform_playground.name
  pattern                = "main"
  require_signed_commits = true
}
