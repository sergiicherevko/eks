module "vpc" {
  source = "../../modules/vpc"

  name                 = "dev"
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "eks" {
  source = "../../modules/eks"

  name               = "dev"
  kubernetes_version = var.kubernetes_version
  vpc_id             = module.vpc.vpc_id
  vpc_cidr           = module.vpc.vpc_cidr
  public_subnet_ids  = module.vpc.public_subnet_ids

  min_size         = 1
  desired_capacity = 3
  max_size         = 5
  instance_types   = ["t3.medium", "t3a.medium"]
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn  = module.eks.node_role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      }
    ])
  }

  depends_on = [module.eks]
}

module "eks" {
  source = "../../modules/eks"

  name               = "dev"
  kubernetes_version = var.kubernetes_version

  vpc_id             = module.vpc.vpc_id
  vpc_cidr           = module.vpc.vpc_cidr
  public_subnet_ids  = module.vpc.public_subnet_ids

  min_size         = 1
  desired_capacity = 3
  max_size         = 5

  instance_types = ["t3.medium", "t3a.medium"]

  admin_role_arns = [
    "arn:aws:iam::ACCOUNT_ID:role/AWSReservedSSO_AdministratorAccess_XXXX",
    "arn:aws:iam::ACCOUNT_ID:role/GitHubActionsTerraformIAMrole"
  ]
}
