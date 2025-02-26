resource "github_repository" "this" {
  name         = "terraform-playground"
  description  = "Terraform testing grounds"
  homepage_url = "https://thatkalle.github.io/terraform-playground"
  #tfsec:ignore:github-repositories-private
  visibility = "public"

  has_issues           = false
  has_wiki             = false
  has_projects         = false
  has_downloads        = false
  vulnerability_alerts = true

  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  allow_auto_merge   = false

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
  }
}

resource "github_repository_topics" "repository_topics" {
  repository = github_repository.this.name
  topics     = ["devcontainer", "terraformed"]
}
