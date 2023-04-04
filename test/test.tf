provider "kubernetes" {
    config_path = "~/.kube/config"
}

variable "tag" {}

locals {
    settings = {
        name      = "test-app-1"
        namespace = "convictionsai"
        type      = "backend"
        version   = var.tag
        resources = {
            replicas = 1
            requests = {
                cpu    = "500m"
                memory = "500Mi"
            }
            limits = {
                cpu    = "500m"
                memory = "500Mi"
            }
        }
        networking = {
            ingress = {
                hostname = "api.convictions.ai"
                path     = "/"
            }
            ports = [
                {
                    name = "http"
                    port = 8080
                }
            ]
        }
        env = {
            PORT        = 8080
            DB_HOST     = "mysql"
            DB_PORT     = 3306
            DB_USERNAME = "changeme"
            DB_PASSWORD = "changeme"
        }
    }
}

module "test" {
    source = "../"
    settings = local.settings
}
