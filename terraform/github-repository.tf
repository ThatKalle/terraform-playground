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
  name         = "terraform-playground-test-rename"
  description  = "TEST"
  homepage_url = "https://thatkalle.github.io/terraform-playground-test"
  #tfsec:ignore:github-repositories-private
  visibility = "public"

  has_issues           = false
  has_wiki             = false
  has_projects         = false
  has_downloads        = false
  vulnerability_alerts = true

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