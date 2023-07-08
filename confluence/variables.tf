variable "cluster_name" {
  type    = string  
}

variable "region" {
  type    = string
}

variable "rds_driver" {
  default = "org.postgresql.Driver"
}

variable "nfs_mount_path" {
  type    = string
}

variable "private_subnets" {
  type    = string  
}

variable "elb_type" {
  type    = string
}

variable "eks_endpoint" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

variable "eks_token" {
  type = string
}
