provider "kubernetes" {
  config_path    = "~/.kube/devops"
  config_context = "devops-interview"
}

resource "kubernetes_namespace" "devops-interview" {
  metadata {
    name = "devops-interview"
  }
}
