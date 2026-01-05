variable "region" {
  description = "AWS-Region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR for the EKS VPC"
  type        = string
  default     = "10.0.0.0/16"
  #how many IPs this creates
}

variable "availability_zones" {
  description = "EKS AZs"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "pvt_subnet_cidrs" {
  description = "CIDR for pvt subnet"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  #how many IPs this creates
}

variable "pub_subnet_cidrs" {
  description = "CIDT for pub subnet"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  #how many IPs this creates and can we use the CIDR range of pvt subnet here as well?
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
  default     = "Ecom-EKS-Cluster"

}
