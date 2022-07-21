resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx"
    namespace = "devops-interview"
    labels = {
      app = "nginx"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
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
          #image = "nginx:1.21.6"
          image = "mahendrashivaswamy/cicd:1.0.0"
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
