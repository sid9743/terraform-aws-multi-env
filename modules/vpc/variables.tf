variable "name" {
  description = "Prefix used for all resource names"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability zones to spread subnets across"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "single_nat_gateway" {
  description = "Use one NAT gateway (cheaper, for dev) instead of one per AZ (for prod)"
  type        = bool
  default     = true
}

variable "cluster_name" {
  description = "EKS cluster name, used for the subnet discovery tags"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
