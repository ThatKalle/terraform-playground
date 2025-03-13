moved {
  from = github_repository.this
  to   = github_repository.terraform_playground
}

moved {
  from = github_actions_repository_permissions.this
  to   = github_actions_repository_permissions.terraform_playground
}
