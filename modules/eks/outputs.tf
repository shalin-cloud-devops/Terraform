output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = aws_eks_cluster.eks_control.endpoint

}

output "cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.eks_control.name

}
