#### Vpc Name and Cidr Block Value ###########
awsvpc ="PickMe/Onduty_VPC"
cidr_block = "172.20.0.0/16"
aws_region = "us-west-1"

########### Availability_zones #####################
availability_zone1 = "us-west-1b"
availability_zone2 = "us-west-1b"
availability_zone3 = "us-west-1c"

##### Public Subnets with cidr_block ############
public_subnetName1 = "PickMe/Onduty_Public_workerNode_subnet_1"
public_subnet1_cidr = "172.20.0.0/20"

public_subnetName2 = "PickMe/Onduty_Public_Database_subnet_2"
public_subnet2_cidr = "172.20.16.0/20"

public_subnetName3 = "PickMe/Onduty_Public_cache_subnet_3"
public_subnet3_cidr = "172.20.32.0/20"

############# Private Subnets with Cidr ###############
private_subnetName1 = "PickMe/Onduty_Private_workerNode_subnet_1"
private_subnet1_cidr = "172.20.64.0/20"

private_subnetName2 = "PickMe/Onduty_Private_database_subnet_2"
private_subnet2_cidr = "172.20.96.0/20"

private_subnetName3 = "PickMe/Onduty_Private_cache_subnet_3"
private_subnet3_cidr = "172.20.112.0/20"

private_subnetName4 = "PickMe/Onduty_Private_workerNode_subnet_4"
private_subnet4_cidr = "172.20.128.0/20"

private_subnetName5 = "PickMe/Onduty_Private_database_subnet_5"
private_subnet5_cidr = "172.20.144.0/20"

private_subnetName6 = "PickMe/Onduty_Private_cache_subnet_6"
private_subnet6_cidr = "172.20.160.0/20"



################## Internet_Gateway ##################
IGName = "PickMe/Onduty_IGW"

########### Route Table for the public subnet ################
nat_cidr = "0.0.0.0/0"
public_rtbname = "PickMe/Onduty_RT"

##################  NAT Gateway #############
NG-ElasticIPTag = "PickMe/Onduty-NatGateway"
NG-name = "PickMe/Onduty-NatGateway"
NG_route_cidr = "0.0.0.0/0"
NG_route_name = "PickMe/Onduty-Router"


########### Security Groups ###########################
aws_security_group_eks = "PickMe/Onduty-SG-eks"
aws_security_group_alb = "PickMe/Onduty-SG-alb"
ingress_http = "80"
ingress_https = "443"
ingress_allow_cidr = "0.0.0.0/0"
#ingress_ssh = "22"
#ingress_allow_custom = ""



############## IAM User & Role ##########################
eks_ExecutionRole_name = "eksTaskExecutionRole"
ec2_InstanceRole_Policy_name = "eks-instance-role"
eks_instance_profile_Name = "eks-instance-profile"

################  S3 Bucket and CloudFront  #########################
bucket_name = "pickme-frontend-s3-bucket"
s3_origin_id = "S3_Origin"
acl_type = "public-read"
bucket_log = "log-bucket-vlogr"
prefix = "cflogs"
aliases_name = "app.vlogr.com"
acm_certificate_arn = "arn:aws:acm:us-east-1:099755600066:certificate/889b7de6-926a-4dfd-8d04-015fe1b7c5d9"
ssl_support_method = "sni-only"
minimum_protocol_version = "TLSv1.2_2021"
