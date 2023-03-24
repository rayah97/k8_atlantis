
resource "helm_release" "atlantis" {
  name       = "atlantis"
  chart      = "atlantis"
  namespace  = "default"
#   repository = "https://github.com/runatlantis/helm-charts/tree/main/charts/atlantis"
#   values = [
#     <<EOF
#     github:
#       user: rayah
#       token: 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
#       baseURL: https://api.github.com/
#     atlantis:
#       hostname: 192.168.49.2
#     EOF
#     ,
#     <<EOF
#     service:
#       type: ClusterIP
#     EOF
#     ,
#   ]
}

resource "kubernetes_service" "atlantis" {
  metadata {
    name = "atlantis"
  }

  spec {
    selector = {
      app = helm_release.atlantis.name
    }

    port {
      name        = "http"
      port        = 80
      target_port = 8080
    }

    type = "ClusterIP"
  }
}
