module "eks_cluster" {
  source          = "./eks"
  cluster_name    = var.cluster_name
  region          = var.region
  cluster_version = var.cluster_version
  instance_type   = var.instance_type
  nodes_count     = var.nodes_count
  vpc_id          = var.vpc_id
}

#In this script helm charts and aws roles will be created that will enable cluster to use secret from aws secret manager and deploy ELB in AWS
module "eks_add_ons" {
  source                 = "./eks_add_ons"
  cluster_name           = module.eks_cluster.cluster_name
  region                 = var.region
  cluster_ca_certificate = base64decode(module.eks_cluster.cluster_certificate_authority_data)
  eks_endpoint           = module.eks_cluster.cluster_endpoint
  eks_token              = data.aws_eks_cluster_auth.cluster.token
  oidc_provider_arn      = module.eks_cluster.oidc_provider_arn
  vpc_id                 = var.vpc_id  
}

module "bitbucket" {
  source                 = "./bitbucket"
  cluster_name           = module.eks_cluster.cluster_name
  region                 = var.region
  nfs_mount_path         = var.nfs_mount_path
  bitbucket_pods_count   = var.bitbucket_pods_count
  private_subnets        = var.private_subnets
  elb_type               = var.elb_type
  cluster_ca_certificate = base64decode(module.eks_cluster.cluster_certificate_authority_data)
  eks_endpoint           = module.eks_cluster.cluster_endpoint
  eks_token              = data.aws_eks_cluster_auth.cluster.token  
}


module "confluence" {
  source                 = "./confluence"
  cluster_name           = module.eks_cluster.cluster_name
  region                 = var.region
  nfs_mount_path         = var.nfs_mount_path
  private_subnets        = var.private_subnets
  elb_type               = var.elb_type
  cluster_ca_certificate = base64decode(module.eks_cluster.cluster_certificate_authority_data)
  eks_endpoint           = module.eks_cluster.cluster_endpoint
  eks_token              = data.aws_eks_cluster_auth.cluster.token  
}
