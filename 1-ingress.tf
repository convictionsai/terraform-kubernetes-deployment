#
# https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/#kind-ingressroute
#
resource "kubernetes_manifest" "traefik-router" {

    manifest = {

        apiVersion = "traefik.containo.us/v1alpha1"
        kind       = "IngressRoute"

        metadata = {
            namespace = var.settings.namespace
            name      = var.settings.name
        }

        spec = {
            entryPoints = [
                "https"
            ]

            routes = [
                {
                    kind     = "Rule"
                    match    = "Host(`${var.settings.networking.ingress.hostname }`) && PathPrefix(`${var.settings.networking.ingress.path }`)"
                    #                    middlewares = [
                    #                        {
                    #                            name      = "api-strip-prefix"
                    #                            namespace =var.settings.namespace
                    #                        }
                    #                    ]
                    services = [
                        {
                            name      = var.settings.name
                            namespace = var.settings.namespace
                            port      = var.settings.networking.ports[ 0 ].containerPort
                        }
                    ]
                }
            ]

            tls = {
                secretName = "tls-traefik"
                options    = {
                    name      = "traefik-tls-options"
                    namespace = "default"
                }
            }
        }
    }
}
