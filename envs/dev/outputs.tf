output "vpc_id" {
  value = module.vpc.vpc_id
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "kubeconfig_command" {
  value = "aws eks update-kubeconfig --region ${var.region} --name ${module.eks.cluster_name}"
}

output "db_endpoint" {
  value = module.rds.endpoint
}

output "db_secret_arn" {
  value = module.rds.master_user_secret_arn
}

output "ecr_repository_urls" {
  value = { for k, r in aws_ecr_repository.service : k => r.repository_url }
}
