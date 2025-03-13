terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.11, < 2.0"

}

provider "github" {}
