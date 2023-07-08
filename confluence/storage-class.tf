resource "kubernetes_storage_class_v1" "example" {
  metadata {
    name = "nfs-sc"
  }
  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"
  parameters = {
    type = "pd-standard"
  }
  mount_options = ["file_mode=0700", "dir_mode=0777", "mfsymlinks", "uid=1000", "gid=1000", "nobrl", "cache=none"]
}

resource "kubernetes_storage_class" "fast_storage_class" {
  metadata {
    name = "fast"
  }
  storage_provisioner = "ebs.csi.aws.com"
  reclaim_policy      = "Retain"
  parameters = {
    type = "gp3"
    allowAutoIOPSPerGBIncrease : "true"
    encrypted : "true"
  }
  allow_volume_expansion = "true"
  volume_binding_mode    = "WaitForFirstConsumer"
}
