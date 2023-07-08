resource "kubectl_manifest" "secret-store" {
  yaml_body = templatefile("${path.module}/files/secretstore.yaml", { REGION = var.region })
}
