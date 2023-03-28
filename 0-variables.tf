variable "settings" {
    type = object({
        name      = string
        type      = string
        version   = string
        namespace = string
        resources = object({
            replicas = number
            cpu      = string
            memory   = string
        })
        networking = object({
            ingress = object({
                hostname = string
                path     = string
            })
            ports = list(object({
                name          = string
                containerPort = number
                targetPort    = number
                protocol      = string
            }))
        })
        env = optional(map(string))
    })
}
