data "aws_caller_identity" "current" {}

data "aws_secretsmanager_secret" "secret_store" {
  name = "SecretStore-${var.cluster_name}"
}