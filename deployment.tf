resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx"
    namespace = "devops-interview"
    labels = {
      app = "nginx"
      release = "${var.version_num}"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx"
        release = "${var.version_num}"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
          release = "${var.version_num}"
        }
      }

      spec {
        volume {
          name = "extra-static-files"
          config_map {
            name = "nginx-static-file"
	  }
        }

        container {
          image = "mahendrashivaswamy/cicd:${var.version_num}"
          name  = "nginx"
       
          env_from {
            config_map_ref  {
                name =  "nginx-env-vars"
            }
          }

	  volume_mount {
            name = "extra-static-files"
            mount_path = "/static"
	  }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}
