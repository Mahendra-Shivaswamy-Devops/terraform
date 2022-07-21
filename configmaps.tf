resource "kubernetes_config_map" "nginx-env-vars" {
  metadata {
    name = "nginx-env-vars"
    namespace = "devops-interview"
  }

  data = {
    TEAM_NAME             = "Devops"
  }
}

resource "kubernetes_config_map" "nginx-static-file" {
  metadata {
    name = "nginx-static-file"
    namespace = "devops-interview"
  }

  data = {
    "config.html" = "${file("${path.module}/config.html")}"
  }
}
