locals {
    environment = base64decode(yamldecode(var.settings))
}
