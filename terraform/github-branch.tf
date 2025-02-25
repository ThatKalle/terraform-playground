resource "github_branch" "main" {
  repository = github_repository.this.name
  branch     = "main"

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch" "staging" {
  repository = github_repository.this.name
  branch     = "staging"
}

resource "github_branch_default" "default" {
  repository = github_repository.this.name
  branch     = github_branch.main.branch
}

resource "github_branch_protection" "branch_protection" {
  repository_id          = github_repository.this.name
  pattern                = "main"
  require_signed_commits = true
}


resource "github_branch" "test_main" {
  repository = github_repository.test.name
  branch     = "main"

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_default" "test_default" {
  repository = github_repository.test.name
  branch     = github_branch.test_main.branch
}

resource "github_branch_protection" "test_branch_protection" {
  repository_id          = github_repository.test.name
  pattern                = "main"
  require_signed_commits = false
}
