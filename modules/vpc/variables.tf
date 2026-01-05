variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string

}

variable "availability_zones" {
  description = "availability_zones"
  type        = list(string)

}

variable "pvt_subnet_cidrs" {
  description = "CIDR - PVT Subnet"
  type        = list(string)

}

variable "pub_subnet_cidrs" {
  description = "CIDR - PUB Subnet"
  type        = list(string)

}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string

}
