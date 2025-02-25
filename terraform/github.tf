provider "github" {}

data "github_repository" "example" {
  full_name = "ThatKalle/terraform-playground"
}