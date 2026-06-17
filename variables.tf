variable "app_name" {
  description = "Name of the test application"
  type        = string
  default     = "test-app"
}

variable "container_image" {
  description = "Container image used in the sample manifest"
  type        = string
  default     = "nginx:latest"
}

variable "replicas" {
  description = "Number of sample replicas"
  type        = number
  default     = 1
}

variable "app_api_key" {
  description = "Demo API key passed from GitHub Actions secrets"
  type        = string
  default     = "demo-super-secret-12345"
  sensitive   = true
}