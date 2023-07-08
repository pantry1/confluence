resource "helm_release" "bitbucket-data-center" {
  depends_on       = [helm_release.eck-operators]
  name             = "bitbucket"
  chart            = "${path.module}/bitbucket"
  version          = "1.12.0"
  namespace        = "bitbucket"
  create_namespace = true

  set {
    name  = "replicaCount"
    value = var.bitbucket_pods_count
  }
  set {
    name  = "database.url"
    value = "jdbc:postgresql://${data.aws_db_instance.database.endpoint}/bitbucket"
    type  = "string"
  }
  set {
    name  = "database.driver"
    value = "org.postgresql.Driver"
    type  = "string"
  }
  set {
    name  = "database.credentials.secretName"
    value = "mysql-auth"
    type  = "string"
  }
  set {
    name  = "volumes.localHome.persistentVolumeClaim.create"
    value = true
  }
  set {
    name  = "volumes.localHome.persistentVolume.storageClassName"
    value = "gp2"
    type  = "string"
  }
  set {
    name  = "volumes.localHome.persistentVolumeClaim.storageClassName"
    value = "gp2"
    type  = "string"
  }
  set {
    name  = "volumes.localHome.persistentVolumeClaim.resources.requests.storage"
    value = "1Gi"
    type  = "string"
  }
  set {
    name  = "volumes.sharedHome.persistentVolume.create"
    value = true
  }
  set {
    name  = "volumes.sharedHome.persistentVolume.nfs.server"
    value = data.aws_instance.nfs_server.private_ip
  }
  set {
    name  = "volumes.sharedHome.persistentVolume.nfs.path"
    value = var.nfs_mount_path
    type  = "string"
  }
  set {
    name  = "volumes.sharedHome.persistentVolumeClaim.create"
    value = true
  }
  set {
    name  = "volumes.sharedHome.persistentVolumeClaim.storageClassName"
    value = ""
  }
  set {
    name  = "ingress.create"
    value = true
  }

  set {
    name  = "bitbucket.sysadminCredentials.secretName"
    value = "bitbucket-auth"
    type  = "string"
  }
  set {
    name  = "bitbucket.service.type"
    value = "ClusterIP"
  }
  set {
    name  = "volumes.sharedHome.nfsPermissionFixer.enabled"
    value = true
  }

  set {
    name  = "bitbucket.elasticSearch.baseUrl"
    value = "elasticsearch-es-http.elastic.svc:9200"
  }

  set {
    name  = "bitbucket.elasticSearch.credentials.secretName"
    value = "elk-auth-secret"
  }
  set {
    name  = "bitbucket.clustering.enabled"
    value = true
  }
  set {
    name  = "bitbucket.service.type"
    value = "NodePort"
  }
  set {
    name  = "ingress.path"
    value = "/"
  }
  set {
    name  = "ingress.className"
    value = "alb"
  }
  set {
    name  = "ingress.nginx"
    value = false
  }
  set {
    name  = "ingress.annotations.kubernetes\\.io/ingress\\.class"
    value = "alb"
    type  = "string"
  }
  set {
    name  = "ingress.annotations.alb\\.ingress\\.kubernetes\\.io/scheme"
    value = var.elb_type
    type  = "string"
  }
  set {
    name  = "ingress.annotations.alb\\.ingress\\.kubernetes\\.io/backend-protocol"
    value = "HTTP"
    type  = "string"
  }
  set {
    name  = "ingress.annotations.alb\\.ingress\\.kubernetes\\.io/listen-ports"
    value = "[{\"HTTP\": 80}]"
    type  = "string"
  }
  set {
    name  = "ingress.annotations.alb\\.ingress\\.kubernetes\\.io/subnets"
    value = var.private_subnets    
  }
  set {
    name  = "secretStoreName"
    value = "SecretStore-${var.cluster_name}"
  }
  set {
    name  = "ingress.annotations.alb\\.ingress\\.kubernetes\\.io/success-codes"
    value = "200\\,302"
  }
}