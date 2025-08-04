locals {
  cluster_name = "kai-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

module "eks" {
  # https://github.com/terraform-aws-modules/terraform-aws-eks/blob/v20.8.5/main.tf
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = local.cluster_name
  cluster_version = var.kubernetes_version

  cluster_endpoint_public_access           = var.cluster_endpoint_public_access
  cluster_endpoint_private_access          = var.cluster_endpoint_private_access
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions

  # cluster_addons = {
  #   aws-ebs-csi-driver = {
  #     service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
  #   }
  # }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = var.eks_managed_node_group_defaults

  eks_managed_node_groups = var.eks_managed_node_groups
}