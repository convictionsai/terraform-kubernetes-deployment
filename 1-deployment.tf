resource "kubernetes_deployment" "deployment" {
    wait_for_rollout = false

    metadata {
        name      = var.settings.name
        namespace = var.settings.namespace

        labels = {
            app = var.settings.type
        }
    }

    spec {
        replicas = var.settings.resources.replicas

        strategy {
            type = "RollingUpdate"
            rolling_update {
                max_surge       = 1
                max_unavailable = 1
            }
        }

        selector {
            match_labels = {
                app  = var.settings.name
                type = var.settings.type
            }
        }

        template {
            metadata {
                name = var.settings.name

                labels = {
                    app  = var.settings.name
                    type = var.settings.type
                }
            }

            spec {
                termination_grace_period_seconds = 0

                #                node_selector = {
                #                    "kubernetes.civo.com/civo-node-pool" = "services"
                #                }

                image_pull_secrets {
                    name = "ghcr"
                }

                container {
                    name  = var.settings.name
                    image = "ghcr.io/convictionsai/${var.settings.name}:${var.settings.version}"

                    resources {
                        requests = {
                            cpu    = var.settings.resources.cpu
                            memory = var.settings.resources.memory
                        }
                        limits = {
                            cpu    = var.settings.resources.cpu
                            memory = var.settings.resources.memory
                        }
                    }

                    env {
                        name  = "PORT"
                        value = var.settings.networking.ports[ 0 ].port
                    }

                    dynamic "port" {
                        for_each = var.settings.networking.ports
                        content {
                            container_port = port.value
                        }
                    }

                    dynamic "env" {
                        for_each = var.settings.env
                        content {
                            name  = env.key
                            value = env.value
                        }
                    }
                }
            }
        }
    }
}
