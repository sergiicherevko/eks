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
