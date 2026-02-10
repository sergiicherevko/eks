variable "name" { type = string }

variable "kubernetes_version" {
  type = string
  # pick “one behind latest” supported by EKS (you’ll set it in env/dev)
}

variable "vpc_id" { type = string }

variable "public_subnet_ids" {
  type = list(string)
}

variable "vpc_cidr" {
  type = string
}
