resource "github_repository" "terraform_playground" {
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
  repository = github_repository.terraform_playground.name

  topics = [
    "devcontainer",
    "terraformed",
    "hugo",
    "testing"
  ]
}

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
  repository_id = github_repository.terraform_playground.node_id
  pattern       = "main"

  require_signed_commits = true

  required_status_checks {
    strict = true
    contexts = [
      "ci / Terraform CI",
      "ci / HUGO CI"
    ]
  }
}

resource "github_actions_repository_permissions" "terraform_playground" {
  repository = github_repository.terraform_playground.name
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
      "peaceiris/actions-hugo@*",
      "dependabot/fetch-metadata@*"
    ]
  }
}

resource "github_repository_environment" "production" {
  repository  = github_repository.terraform_playground.name
  environment = "production"

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
  repository       = github_repository.terraform_playground.name
  environment_name = github_repository_environment.production.environment
  name             = "main"
}

resource "github_repository_dependabot_security_updates" "dependabot_security_updates" {
  repository = github_repository.terraform_playground.name
  enabled    = true
}

resource "github_repository_file" "dependabot_yml" {
  repository          = github_repository.terraform_playground.name
  branch              = github_branch_default.default.branch
  file                = ".github/dependabot.yml"
  content             = file("${path.module}/input/dependabot.yml")
  overwrite_on_create = true
}
