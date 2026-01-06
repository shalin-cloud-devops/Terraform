variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "cluster_version" {
  description = "EKS Cluster version"
  type        = string
}

variable "vpc_id" {
  description = "EKS VPC name"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for EKS Cluster"
  type        = list(string)
}

variable "node_groups" {
  description = "EKS Node group"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })
  }))
}
