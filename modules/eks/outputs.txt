output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "nat_eip_ids" {
  description = "List of NAT EIP IDs"
  value       = module.vpc.aws_eip
}
