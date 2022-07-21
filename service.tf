resource "kubernetes_service" "nginx" {
  depends_on = [kubernetes_deployment.nginx]

  metadata {
    labels = {
      app = "nginx"
    }
    annotations = {
      "external-dns.alpha.kubernetes.io/hostname" = "int-1.test-1.rr.mu"
    }
    name      = "nginx"
    namespace = "devops-interview"
  }

  spec {
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
    selector = {
      app = "nginx"
    }
    type = "ClusterIP"
    #type = "LoadBalancer"
  }
}
