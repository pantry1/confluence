output "vpc_id" {
  value = var.vpc_id
}

output "region" {
  value = var.region
}

output "cluster_name" {
  value = var.cluster_name
}

output "cluster_id" {
  value = module.eks_cluster.cluster_id
}

output "cluster_endpoint" {
  value = module.eks_cluster.cluster_endpoint
}

output "node_security_group_id" {
  value = module.eks_cluster.node_security_group_id
}

output "cluster_certificate_authority_data" {
  value = module.eks_cluster.cluster_certificate_authority_data
}
