variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.60.0.0/16"
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.60.0.0/20", "10.60.16.0/20", "10.60.32.0/20"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.60.48.0/20", "10.60.64.0/20", "10.60.80.0/20"]
}
