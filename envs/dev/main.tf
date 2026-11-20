locals {
  name         = "${var.project}-${var.environment}"
  cluster_name = "${var.project}-${var.environment}-eks"
}

module "vpc" {
  source = "../../modules/vpc"

  name                 = local.name
  cidr_block           = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  single_nat_gateway   = var.single_nat_gateway
  cluster_name         = local.cluster_name
}

module "eks" {
  source = "../../modules/eks"

  cluster_name        = local.cluster_name
  cluster_version     = var.cluster_version
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  public_access_cidrs = var.api_access_cidrs
  node_instance_types = var.node_instance_types
  capacity_type       = var.capacity_type
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
  node_desired_size   = var.node_desired_size
}

module "rds" {
  source = "../../modules/rds"

  name                       = local.name
  vpc_id                     = module.vpc.vpc_id
  subnet_ids                 = module.vpc.private_subnet_ids
  allowed_security_group_ids = [module.eks.cluster_security_group_id]
  instance_class             = var.db_instance_class
  multi_az                   = var.db_multi_az
  deletion_protection        = var.db_deletion_protection
  backup_retention_days      = var.environment == "prod" ? 14 : 3
}

resource "aws_ecr_repository" "service" {
  for_each = toset(["product-service", "order-service", "churn-api"])

  name                 = "${var.environment}/${each.value}"
  image_tag_mutability = "IMMUTABLE"
  force_delete         = var.environment != "prod"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "service" {
  for_each   = aws_ecr_repository.service
  repository = each.value.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep the last 30 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 30
      }
      action = { type = "expire" }
    }]
  })
}
