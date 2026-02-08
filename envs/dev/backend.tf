terraform {
  backend "s3" {
    bucket  = "sergii-eks-terraform-state-dev"
    key     = "eks/dev/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
