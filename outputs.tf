output "generated_manifest" {
  description = "Generated Kubernetes deployment manifest path"
  value       = local_file.app_manifest.filename
}

output "generated_secret_manifest" {
  description = "Generated Kubernetes secret manifest path"
  value       = local_sensitive_file.secret_manifest.filename
}

output "generated_readme" {
  description = "Generated README path"
  value       = local_file.readme.filename
}

output "message" {
  value = "Terraform ran successfully. No infrastructure was created."
}