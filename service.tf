resource "kubernetes_service" "nginx" {
  depends_on = [kubernetes_deployment.nginx]

  metadata {
    labels = {
      app = "nginx"
      release = "${var.version_num}"
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
      release = "${var.version_num}"
    }
    type = "ClusterIP"
    #type = "LoadBalancer"
  }
}
