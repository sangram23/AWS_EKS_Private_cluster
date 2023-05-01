resource "aws_security_group_rule" "eks_sg_ingress_rule" {
  cidr_blocks = [ var.cidr_block ]
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"

  security_group_id = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
  type              = "ingress"
}
resource "aws_security_group_rule" "add_bastion_access" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
}
resource "aws_security_group_rule" "add_bastion_access_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
}