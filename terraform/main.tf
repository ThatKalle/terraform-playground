terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.0-alpha1"
    }
  }

  required_version = "~> 1.10.0"
}

provider "random" {}

resource "random_uuid" "test" {
}
