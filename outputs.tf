output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "nat_eip_ids" {
  description = "List of NAT EIP IDs"
  value       = module.vpc.aws_eip
}

output "cluster_name" {
  description = "EKS Cluster name"
  value       = module.eks.cluster_name

}

output "Cluster_Endpoint" {
  description = "EKS Cluster endpoint"
  value       = module.eks.cluster_endpoint

}
