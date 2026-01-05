output "vpc_id" {
  description = "vpc_id"
  value       = aws_vpc.eks_vpc.id

}

output "aws_eip" {
  description = "List of NAT EIPs"
  value       = aws_eip.nat_eip[*].id
}

