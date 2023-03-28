resource "kubernetes_service" "service" {
    metadata {
        name      = var.settings.name
        namespace = var.settings.namespace

        labels = {
            app = var.settings.name
        }
    }

    spec {
        selector = {
            app = var.settings.name
        }
        dynamic "port" {
            for_each = var.settings.ports
            content {
                name        = port.value.name
                port        = port.value.port
                target_port = port.value.port
                protocol    = "TCP"
            }
        }
    }
}
