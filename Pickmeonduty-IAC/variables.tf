###  VPC Name and Cidr Block Variable ##############
variable "awsvpc" {
    type = string
  description = "VPCname"
}
variable "cidr_block" {
    type = string
  description = "Cidr Value"
}
variable "aws_region" {
    type = string
  description = "aws_region"
}


################# Availability_zones #################

variable "availability_zone1" {
    type = string
  description = "availability zone 1"
}
variable "availability_zone2" {
    type = string
  description = "availability zone 1"
}
variable "availability_zone3" {
    type = string
  description = "availability zone 1"
}
######  Public Subnets with cidr_block ###################
variable "public_subnetName1" {
    type = string
  description = "Public subnet Name 1"
}
variable "public_subnet1_cidr" {
    type = string
  description = "cidr_block"
}

variable "public_subnetName2" {
    type = string
  description = "Public subnet Name 2"
}
variable "public_subnet2_cidr" {
    type = string
  description = "cidr_block"
}

variable "public_subnetName3" {
    type = string
  description = "Public subnet Name 3"
}
variable "public_subnet3_cidr" {
    type = string
  description = "cidr_block"
}

###############Private Subnets Name and Cidr Block ###########################
variable "private_subnetName1" {
    type = string
  description = "Private subnet Name 1"
}
variable "private_subnet1_cidr" {
    type = string
  description = "cidr_block"
}

variable "private_subnetName2" {
    type = string
  description = "Private subnet Name 2"
}
variable "private_subnet2_cidr" {
    type = string
  description = "cidr_block"
}

variable "private_subnetName3" {
    type = string
  description = "Private subnet Name 3"
}
variable "private_subnet3_cidr" {
    type = string
  description = "cidr_block"
}


variable "private_subnetName4" {
    type = string
  description = "Private subnet Name 4"
}
variable "private_subnet4_cidr" {
    type = string
  description = "cidr_block"
}

variable "private_subnetName5" {
    type = string
  description = "Private subnet Name 5"
}

variable "private_subnet5_cidr" {
    type = string
  description = "cidr_block"
}


variable "private_subnetName6" {
    type = string
  description = "Private subnet Name 6"
}
variable "private_subnet6_cidr" {
    type = string
  description = "cidr_block"
}

############## Internet Gateway ##################
variable "IGName" {
    type = string
  description = "Internet Gateway Name"
}

########### Route Table for the public subnet ##############
variable "nat_cidr" {
    type = string
  description = "cidr_block"
}

variable "public_rtbname" {
    type = string
  description = "Public Route Table Name"
}

#################  Elastic IP for the NAT Gateway ###################

variable "NG-ElasticIPTag" {
    type = string
  description = "Nat Gateway Elastic IP Name "
}

variable "NG-name" {
    type = string
  description = "Nat Gateway Name "
}

variable "NG_route_cidr" {
    type = string
  description = "Nat Gateway Cidr "
}

variable "NG_route_name" {
    type = string
  description = "Nat Gateway Cidr "
}


############## Security Groups ##################
variable "aws_security_group_eks" {
    type = string
  description = "Cluster Security Group Name "
}

variable "aws_security_group_alb" {
    type = string
  description = "ALB Security Group Name "
}

variable "ingress_http" {
    type = string
  description = "HTTP Port "
}
variable "ingress_https" {
    type = string
  description = "HTTPS Port "
}
variable "ingress_allow_cidr" {
    type = string
  description = "HTTPS Port "
}
#variable "ingress_ssh" {
#    type = string
#  description = "ssh Port "
#}
#variable "ingress_allow_custom" {
#    type = string
#  description = "Custom Ip For SSH Access "
#}


############## IAM User ##########################
variable "eks_ExecutionRole_name" {
    type = string
  description = "EkS Execution Role for Service Launch "
}
variable "ec2_InstanceRole_Policy_name" {
    type = string
  description = "EC2 instance role for cloudwatch and policy access "
}

variable "eks_instance_profile_Name" {
    type = string
  description = "EkS instance Profile name "
}

################### S3 Cloudfront ##############################


############################ S3 && cloudfront ################################
variable "bucket_name" {
      type = string
  description = "dev bucket name"
}


variable "s3_origin_id" {
      type = string
  description = "Dev s3 origin id"
}

variable "acl_type" {
      type = string
  description = "S3 Acl Type name"
}

variable "bucket_log" {
      type = string
  description = "Staging cloudfront Log Bucket"
}

variable "prefix" {
      type = string
  description = "Logs prefix "
}

variable "aliases_name" {
      type = string
  description = "Alias Domain name for CF Dev"
}

variable "acm_certificate_arn" {
      type = string
  description = "ACM Arn for provide ssl certificate to domains"
}

variable "ssl_support_method" {
      type = string
  description = "SSL Support Method"
}

variable "minimum_protocol_version" {
      type = string
  description = "Protocol for ssl "
}
