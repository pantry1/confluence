resource "helm_release" "external-secrets" {
  name             = "external-secrets"
  chart            = "${path.module}/external-secrets"
  version          = "v0.9.0"
  namespace        = "external-secrets"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = true
  }
  set {
    name  = "webhook.port"
    value = 9443
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.secrets_manager_role.iam_role_arn
  }
  set {
    name  = "webhook.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.secrets_manager_role.iam_role_arn
  }
  set {
    name  = "certController.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.secrets_manager_role.iam_role_arn
  }
}

resource "kubectl_manifest" "ingress_class_params" {
  yaml_body = file("${path.module}/files/ingress_class_params.yaml")
}

resource "kubectl_manifest" "target_group_bindings" {
  yaml_body = file("${path.module}/files/target_group_bindings.yaml")
}


resource "helm_release" "loadbalancer_controller" {
  depends_on = [kubectl_manifest.target_group_bindings, kubectl_manifest.ingress_class_params]
  name       = "aws-load-balancer-controller"

  chart      = "${path.module}/aws-load-balancer-controller"
  version    = "1.5.3"
  namespace  = "kube-system"

  set {
    name  = "image.repository"
    value = "public.ecr.aws/eks/aws-load-balancer-controller"
    type  = "string"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "image.tag"
    value = "v2.5.2"
    type  = "string"
  }
  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
    type  = "string"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.load_balancer_controller_irsa_role.iam_role_arn
    type  = "string"
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
    type  = "string"
  }

  set {
    name  = "region"
    value = var.region
    type  = "string"
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
    type  = "string"
  }
  set {
    name  = "enableServiceMutatorWebhook"
    value = false
  }

}