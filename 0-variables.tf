variable "settings" {
    type = object({
        name      = string
        type      = string
        version   = string
        namespace = string
        resources = object({
            replicas = number
            requests = object({
                cpu    = string
                memory = string
            })
            limits = object({
                cpu    = string
                memory = string
            })
        })
        networking = object({
            ingress = object({
                hostname = string
                path     = string
            })
            ports = list(object({
                name = string
                port = number
            }))
        })
        env = optional(map(string))
    })
}
