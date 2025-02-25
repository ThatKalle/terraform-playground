terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

  required_version = "~> 1.10.0"
}

provider "github" {}

locals {
  staging_repo_name = "terraform-playground-test3"
}

import {
  to = github_repository.this
  id = "terraform-playground"
}

import {
  to = github_branch.main
  id = "terraform-playground:main"
}

import {
  to = github_repository_environment.production
  id = "terraform-playground:production"
}


import {
  to = github_repository.test
  id = local.staging_repo_name
}

# import {
#   to = github_branch.test_main
#   id = "${local.staging_repo_name}:main"
# }
