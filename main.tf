# terraform {
#   required_version = ">= 1.5.0"

#   required_providers {
#     local = {
#       source  = "hashicorp/local"
#       version = "~> 2.5"
#     }
#   }
# }

# locals {
#   app_name = var.app_name

#   kubernetes_manifest = <<-YAML
# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   name: ${local.app_name}
#   labels:
#     app: ${local.app_name}
# spec:
#   replicas: ${var.replicas}
#   selector:
#     matchLabels:
#       app: ${local.app_name}
#   template:
#     metadata:
#       labels:
#         app: ${local.app_name}
#     spec:
#       containers:
#         - name: ${local.app_name}
#           image: ${var.container_image}
#           ports:
#             - containerPort: 80
# YAML

#   readme = <<-EOF
# # Terraform Class Demo

# This repository demonstrates a Terraform workflow using GitHub Actions.

# No cloud infrastructure is created.

# Terraform generates a sample Kubernetes deployment manifest only.

# ## App name

# ${local.app_name}

# ## Container image

# ${var.container_image}

# ## Replicas

# ${var.replicas}
# EOF
# }

# resource "local_file" "app_manifest" {
#   filename = "${path.module}/generated/${local.app_name}-deployment.yaml"
#   content  = local.kubernetes_manifest
# }

# resource "local_file" "readme" {
#   filename = "${path.module}/generated/README.md"
#   content  = local.readme
# }




terraform {
  required_version = ">= 1.5.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

locals {
  app_name = var.app_name

  kubernetes_manifest = <<-YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${local.app_name}
  labels:
    app: ${local.app_name}
spec:
  replicas: ${var.replicas}
  selector:
    matchLabels:
      app: ${local.app_name}
  template:
    metadata:
      labels:
        app: ${local.app_name}
    spec:
      containers:
        - name: ${local.app_name}
          image: ${var.container_image}
          ports:
            - containerPort: 80
          env:
            - name: APP_API_KEY
              valueFrom:
                secretKeyRef:
                  name: ${local.app_name}-secret
                  key: APP_API_KEY
YAML

  kubernetes_secret_manifest = <<-YAML
apiVersion: v1
kind: Secret
metadata:
  name: ${local.app_name}-secret
type: Opaque
stringData:
  APP_API_KEY: ${var.app_api_key}
YAML

  readme = <<-EOF
# Terraform Class Demo

This repository demonstrates a Terraform workflow using GitHub Actions secrets.

No cloud infrastructure is created.

Terraform generates sample Kubernetes YAML files only.

## App name

${local.app_name}

## Container image

${var.container_image}

## Replicas

${var.replicas}

## Secret demo

A GitHub Actions secret named APP_API_KEY was passed into Terraform using TF_VAR_app_api_key.

For safety, do not print the real secret value in logs.
EOF
}

resource "local_file" "app_manifest" {
  filename = "${path.module}/generated/${local.app_name}-deployment.yaml"
  content  = local.kubernetes_manifest
}

resource "local_sensitive_file" "secret_manifest" {
  filename = "${path.module}/generated/${local.app_name}-secret.yaml"
  content  = local.kubernetes_secret_manifest
}

resource "local_file" "readme" {
  filename = "${path.module}/generated/README.md"
  content  = local.readme
}