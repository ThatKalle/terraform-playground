resource "github_repository" "this" {
  name         = "terraform-playground"
  description  = "Terraform testing grounds"
  homepage_url = "https://terraform-playground.kallelilja.com"
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

  auto_init = false

  pages {
    build_type = "workflow"
    cname      = "terraform-playground.kallelilja.com"
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


resource "github_repository" "test" {
  name         = local.staging_repo_name
  description  = "${local.staging_repo_name} description"
  homepage_url = "https://thatkalle.github.io/${local.staging_repo_name}"
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

  auto_init          = true
  gitignore_template = "Terraform"
  license_template   = "unlicense"

  pages {
    build_type = "legacy"
    source {
      branch = "main"
      path   = "/"
    }
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

resource "github_repository_topics" "test_repository_topics" {
  repository = github_repository.test.name
  topics     = ["terraformed"]
}
