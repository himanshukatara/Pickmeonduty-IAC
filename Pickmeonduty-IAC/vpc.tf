terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region     = "us-west-1"
}

resource "aws_vpc" "vpc" {
    cidr_block = "${var.cidr_block}"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags       = {
        Name = "${var.awsvpc}"
    }
}


resource "aws_subnet" "public1" {
  depends_on = [
    aws_vpc.vpc,
  ]
  cidr_block = "${var.public_subnet1_cidr}"
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${var.availability_zone1}"
  tags 		= {
    Name = "${var.public_subnetName1}"
    "kubernetes.io/role/elb" = "1"
    Visibility = "Public"
  }
}

# public subnet #2 
resource "aws_subnet" "public2" {
  depends_on = [
    aws_vpc.vpc,
  ]

  cidr_block = "${var.public_subnet2_cidr}"
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${var.availability_zone2}"
  tags 		= {
    Name = "${var.public_subnetName2}"
    "kubernetes.io/role/elb" = "1"
    Visibility = "Public"
  }
}

# public subnet #3
resource "aws_subnet" "public3" {
  depends_on = [
    aws_vpc.vpc
  ]

  cidr_block = "${var.public_subnet3_cidr}"
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${var.availability_zone3}"
  tags          = {
    Name = "${var.public_subnetName3}"
    "kubernetes.io/role/elb" = "1"
    Visibility = "Public"
  }
}

# Private Subnet #1
resource "aws_subnet" "private1" {
  depends_on = [
    aws_vpc.vpc
  ]

  cidr_block = "${var.private_subnet1_cidr}"
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${var.availability_zone1}"
  tags 		= {
    Name = "${var.private_subnetName1}"
    Visibility = "Private"
  }
}

# private subnet #2 
resource "aws_subnet" "private2" {
  depends_on = [
    aws_vpc.vpc
  ]

  cidr_block = "${var.private_subnet2_cidr}"
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${var.availability_zone2}"
  tags 		= {
    Name = "${var.private_subnetName2}"
    Visibility = "Private"
  }
}

# private subnet #3 
resource "aws_subnet" "private3" {
  depends_on = [
    aws_vpc.vpc
  ]

  cidr_block = "${var.private_subnet3_cidr}"
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${var.availability_zone2}"
  tags 		= {
    Name = "${var.private_subnetName3}"
    Visibility = "Private"
  }
}
# private subnet #4 
resource "aws_subnet" "private4" {
  depends_on = [
    aws_vpc.vpc
  ]

  cidr_block = "${var.private_subnet4_cidr}"
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${var.availability_zone3}"
  tags 		= {
    Name = "${var.private_subnetName4}"
    Visibility = "Private"
  }
}
# private subnet #5 
resource "aws_subnet" "private5" {
  depends_on = [
    aws_vpc.vpc
  ]

  cidr_block = "${var.private_subnet5_cidr}"
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${var.availability_zone2}"
  tags 		= {
    Name = "${var.private_subnetName5}"
    Visibility = "Private"
  }
}

# private subnet #6 
resource "aws_subnet" "private6" {
  depends_on = [
    aws_vpc.vpc
  ]

  cidr_block = "${var.private_subnet6_cidr}"
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${var.availability_zone2}"
  tags 		= {
    Name = "${var.private_subnetName6}"
    Visibility = "Private"
  }
}

# Creating an Internet Gateway for the VPC
resource "aws_internet_gateway" "Internet_Gateway" {
  depends_on = [
    aws_vpc.vpc,
    aws_subnet.public1,
    aws_subnet.public2,
    aws_subnet.public3
  ]
  
  # VPC in which it has to be created!
  vpc_id = "${aws_vpc.vpc.id}" 

  tags = {
    Name = "${var.IGName}"
  }
}

# Creating an Route Table for the public subnet!
resource "aws_route_table" "Public-Subnet-RT" {
  depends_on = [
    aws_vpc.vpc,
    aws_internet_gateway.Internet_Gateway
  ]

   # VPC ID
  vpc_id = "${aws_vpc.vpc.id}"

  # NAT Rule
  route {
    cidr_block = "${var.nat_cidr}"
    gateway_id = aws_internet_gateway.Internet_Gateway.id
  }

}

# Creating a resource for the Route Table Association!
resource "aws_route_table_association" "RT-IG-Association" {

  depends_on = [
    aws_vpc.vpc,
    aws_subnet.public1,
    aws_subnet.public2,
    aws_subnet.public3,
    aws_route_table.Public-Subnet-RT
  ]

# Public Subnet ID
  subnet_id      = aws_subnet.public1.id
#  Route Table ID
  route_table_id = aws_route_table.Public-Subnet-RT.id
}

resource "aws_route_table_association" "RT-IG-Association1" {

  depends_on = [
    aws_vpc.vpc,
    aws_subnet.public1,
    aws_subnet.public2,
    aws_subnet.public3,
    aws_route_table.Public-Subnet-RT
  ]

# Public Subnet ID
  subnet_id      = aws_subnet.public2.id
#  Route Table ID
  route_table_id = aws_route_table.Public-Subnet-RT.id
}

resource "aws_route_table_association" "RT-IG-Association3" {

  depends_on = [
    aws_vpc.vpc,
    aws_subnet.public1,
    aws_subnet.public2,
    aws_subnet.public3,
    aws_route_table.Public-Subnet-RT
  ]

# Public Subnet ID
  subnet_id      = aws_subnet.public3.id
#  Route Table ID
  route_table_id = aws_route_table.Public-Subnet-RT.id
}

# Creating an Elastic IP for the NAT Gateway!
resource "aws_eip" "NG-ElasticIP" {
  depends_on = [
    aws_route_table_association.RT-IG-Association
  ]
  vpc = true
  tags = {
    Name = "${var.NG-ElasticIPTag}"
  }

}

# Creating a NAT Gateway!
resource "aws_nat_gateway" "NAT_GATEWAY" {
  depends_on = [
    aws_eip.NG-ElasticIP
  ]

  # Allocating the Elastic IP to the NAT Gateway!
  allocation_id = aws_eip.NG-ElasticIP.id

  # Associating it in the Public Subnet!
  subnet_id = aws_subnet.public1.id
  tags = {
    Name = "${var.NG-name}"
  }
}

# Creating a Route Table for the Nat Gateway!
resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.NAT_GATEWAY
  ]

  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "${var.NG_route_cidr}"
        nat_gateway_id = aws_nat_gateway.NAT_GATEWAY.id
  }

  tags = {
    Name = "${var.NG_route_name}"
  }

}

# Creating an Route Table Association of the NAT Gateway route
# table with  the Private Subnet!
resource "aws_route_table_association" "Nat-Gateway-RT-Association1" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.private1.id

# Route Table ID
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}

resource "aws_route_table_association" "Nat-Gateway-RT-Association2" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.private2.id

# Route Table ID
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}

resource "aws_route_table_association" "Nat-Gateway-RT-Association3" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.private3.id

# Route Table ID
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}

resource "aws_route_table_association" "Nat-Gateway-RT-Association4" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.private4.id

# Route Table ID
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}

resource "aws_route_table_association" "Nat-Gateway-RT-Association5" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.private5.id

# Route Table ID
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}

resource "aws_route_table_association" "Nat-Gateway-RT-Association6" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.private6.id

# Route Table ID
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}
