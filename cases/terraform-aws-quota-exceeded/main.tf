terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# Create multiple VPCs to exceed the default VPC quota
resource "aws_vpc" "main" {
  count = 10
  cidr_block = "10.${count.index}.0.0/16"
  
  tags = {
    Name = "vpc-${count.index}"
  }
}

# Create multiple Internet Gateways to exceed quota
resource "aws_internet_gateway" "main" {
  count = 10
  vpc_id = aws_vpc.main[count.index].id

  tags = {
    Name = "igw-${count.index}"
  }
}

# Create multiple NAT Gateways to exceed quota
resource "aws_nat_gateway" "main" {
  count = 10
  subnet_id = aws_subnet.public[count.index].id
  allocation_id = aws_eip.nat[count.index].id

  tags = {
    Name = "nat-${count.index}"
  }
}

# Create Elastic IPs for NAT Gateways
resource "aws_eip" "nat" {
  count = 10
  vpc = true

  tags = {
    Name = "eip-${count.index}"
  }
}

# Create public subnets
resource "aws_subnet" "public" {
  count = 10
  vpc_id = aws_vpc.main[count.index].id
  cidr_block = "10.${count.index}.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "public-subnet-${count.index}"
  }
}
