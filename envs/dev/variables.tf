variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "project" {
  type    = string
  default = "shop"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "azs" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.10.0.0/20", "10.10.16.0/20"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.10.64.0/19", "10.10.96.0/19"]
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

variable "cluster_version" {
  type    = string
  default = "1.31"
}

variable "node_instance_types" {
  type    = list(string)
  default = ["t3.medium", "t3a.medium"]
}

variable "capacity_type" {
  type    = string
  default = "SPOT"
}

variable "node_min_size" {
  type    = number
  default = 1
}

variable "node_max_size" {
  type    = number
  default = 3
}

variable "node_desired_size" {
  type    = number
  default = 2
}

variable "api_access_cidrs" {
  description = "Who can reach the public EKS API endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "db_instance_class" {
  type    = string
  default = "db.t4g.micro"
}

variable "db_multi_az" {
  type    = bool
  default = false
}

variable "db_deletion_protection" {
  type    = bool
  default = false
}
