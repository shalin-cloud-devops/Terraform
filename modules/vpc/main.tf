resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name                                        = "${var.cluster_name}-vpc"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "pvt_subnet" {
  count             = length(var.pvt_subnet_cidrs)
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.pvt_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name                                        = "${var.cluster_name}-private-${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"

  }
}

resource "aws_subnet" "pub_subnet" {
  count                   = length(var.pub_subnet_cidrs)
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.pub_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "${var.cluster_name}-Public-${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "${var.cluster_name}-IGW"
  }

}

resource "aws_eip" "nat_eip" {
  count  = length(var.pub_subnet_cidrs)
  domain = "vpc"

  tags = {
    Name = "${var.cluster_name}-nat_eip-${count.index + 1}"
  }

}

resource "aws_nat_gateway" "nat_gw" {
  count         = length(var.pub_subnet_cidrs)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.pub_subnet[count.index].id

  tags = {
    Name = "${var.cluster_name}-nat-gw-${count.index + 1}"
  }
}

resource "aws_route_table" "pub_route" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.cluster_name}-public-route"
  }

}

resource "aws_route_table" "pvt_route" {
  count  = length(var.pvt_subnet_cidrs)
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw[count.index].id
  }

  tags = {
    Name = "${var.cluster_name}-pvt-route-${count.index + 1}"
  }
}

resource "aws_route_table_association" "pvt_associate" {
  count          = length(var.pvt_subnet_cidrs)
  subnet_id      = aws_subnet.pvt_subnet[count.index].id
  route_table_id = aws_route_table.pvt_route[count.index].id
}

resource "aws_route_table_association" "pub_association" {
  count          = length(var.pub_subnet_cidrs)
  subnet_id      = aws_subnet.pub_subnet[count.index].id
  route_table_id = aws_route_table.pub_route.id

}
