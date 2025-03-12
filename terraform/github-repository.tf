resource "github_repository" "this" {
  name         = "terraform-playground"
  description  = "Terraform testing grounds"
  homepage_url = "https://thatkalle.github.io/terraform-playground"
  visibility   = "public" #trivy:ignore:AVD-GIT-0001

  has_issues           = false
  has_wiki             = false
  has_projects         = false
  has_downloads        = false
  vulnerability_alerts = true

  allow_merge_commit          = true
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = false
  web_commit_signoff_required = true

  auto_init = false

  pages {
    build_type = "workflow"
    cname      = ""
  }

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      merge_commit_message,
      merge_commit_title,
      squash_merge_commit_message,
      squash_merge_commit_title,
    ]
  }
}

resource "github_repository_topics" "repository_topics" {
  repository = github_repository.this.name
  topics = [
    "devcontainer",
    "terraformed",
    "hugo",
    "testing"
  ]
}

resource "github_actions_repository_permissions" "this" {
  repository = github_repository.this.name
  enabled    = true

  allowed_actions = "selected"

  allowed_actions_config {
    github_owned_allowed = true
    verified_allowed     = false
    patterns_allowed = [
      "hashicorp/setup-terraform@*",
      "terraform-linters/setup-tflint@*",
      "aquasecurity/setup-trivy@*",
      "aquasecurity/trivy-action@*",
      "peaceiris/actions-hugo@*"
    ]
  }
}
