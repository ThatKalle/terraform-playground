terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
  }

  required_version = ">= 1.11, < 2.0.0"

}

provider "github" {}


provider "null" {}
