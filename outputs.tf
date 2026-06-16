output "project_environment" {
  value = "${local.project_name}-${var.environment}"
}