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

variable "desired_capacity" { type = number }
variable "min_size" { type = number }
variable "max_size" { type = number }

variable "instance_types" {
  type    = list(string)
  default = ["t3.medium", "t3a.medium"]
}

variable "admin_role_arns" {
  type = list(string)
}
