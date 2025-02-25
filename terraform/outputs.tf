output "example" {
  description = "random uuid"
  value       = random_uuid.test
}

output "repo" {
  description = "repo git_clone_url"
  value       = data.github_repository.example.git_clone_url
}