data "aws_caller_identity" "current" {}

data "aws_db_instance" "database" {
  db_instance_identifier = "bitbucket-rds-${var.cluster_name}"
}

data "aws_instance" "nfs_server" {

  filter {
    name   = "tag:Name"
    values = ["nfs-server"]
  }
  filter {
    name   = "tag:cluster_name"
    values = [var.cluster_name]
  }
  filter {
    name = "instance-state-name"
    values = ["running"]
  }

}

data "aws_secretsmanager_secret" "secret_store" {
  name = "SecretStore-${var.cluster_name}"
}