# unified deployment module

This module is to be sourced from other repositories that need to deploy a service to kubernetes.

## Usage

### Terraform
```hcl
variable "version" {}

locals {
    settings = {
        name      = "app"
        namespace = "convictionsai"
        type      = "backend"
        version   = var.version
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
    }
}

module "deploy" {
    source = "git::ssh://git@github.com:convictionsai/terraform-kubernetes-deployment.git?ref=0.0.1"
    settings = local.settings
}
```

### YAML

```yaml
settings:
  name: app
  namespace: convictionsai
  type: backend
  resources:
    replicas: 1
    requests:
      cpu: 500m
      memory: 500Mi
    limits:
      cpu: 500m
      memory: 500Mi
  networking:
    ingress:
      hostname: api.convictions.ai
      path: /
    ports:
      - name: http
        port: 8080
  env:
    DB_HOST: mysql
    DB_PORT: 3306
    DB_USERNAME: changeme
    DB_PASSWORD: changeme
```
