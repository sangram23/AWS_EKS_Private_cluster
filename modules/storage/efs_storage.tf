resource "aws_efs_file_system" "eks_efs"{
  creation_token = "efs_file_system"

  tags = {
    Name = "efs_file_system"
  }
}

resource "aws_efs_mount_target" "efs_mount_a" {
  file_system_id  = aws_efs_file_system.eks_efs.id
  subnet_id       = var.subnet_ids_a
  security_groups = [aws_security_group.eks-efs-sg.id]
}
resource "aws_efs_mount_target" "efs_mount_b" {
  file_system_id  = aws_efs_file_system.eks_efs.id
  subnet_id       = var.subnet_ids_b
  security_groups = [aws_security_group.eks-efs-sg.id]
}

resource "aws_security_group" "eks-efs-sg" {
  description = "Communication between all nodes in the cluster"
  vpc_id      = var.vpc_id
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name"   = format("eks-%s-cluster/efs",var.cluster-name)
    "Label"  = "TF-EKS All Nodes Comms"
  }
}


resource "aws_security_group_rule" "add_bastion_access_22" {
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = ["172.43.0.0/16"]
  security_group_id = aws_security_group.eks-efs-sg.id
}