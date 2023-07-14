




#resource "aws_security_group" "pickme_onduty-rds-sg" {
#  name        = "var.aws-sg-cluster-name"
#  description = "Cluster communication with rds"
#  vpc_id      = aws_vpc.vpc.id
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#    description = "Allow incoming traffic from anywhere"
#  }
#
#  tags = {
#    Name = "PickMe-onduty-rds-SG"
#  }
#}









resource "aws_security_group" "pickme_onduty-cluster-sg" {
  name        = "var.aws-sg-cluster-name"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming traffic from anywhere"
  }

  tags = {
    Name = "PickMe-onduty-cluster-SG"
  }
}

resource "aws_security_group_rule" "pickme_onduty-cluster-ingress-workstation-https" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.pickme_onduty-cluster-sg.id
  to_port           = 443
  type              = "ingress"

}

