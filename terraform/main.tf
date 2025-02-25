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
