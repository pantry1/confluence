provider "helm" {
  experiments {
    manifest = false
  }
  kubernetes {
    host                   = var.eks_endpoint
    cluster_ca_certificate = var.cluster_ca_certificate
    token                  = var.eks_token
  }
}

provider "kubernetes" {
  host                   = var.eks_endpoint
    cluster_ca_certificate = var.cluster_ca_certificate
    token                  = var.eks_token
}

provider "kubectl" {
  host                   = var.eks_endpoint
    cluster_ca_certificate = var.cluster_ca_certificate
    token                  = var.eks_token
}
