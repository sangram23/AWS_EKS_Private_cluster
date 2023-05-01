resource "aws_launch_template" "lt-ng2" {
  #depends_on = [null_resource.auth_cluster]
  instance_type           = "t3.small"
  key_name                = var.key_name
  name                    = format("at-lt-%s-ng2", var.cluster-name)
  tags                    = {}
  #image_id                = data.aws_ssm_parameter.eksami.value
  #user_data            = base64encode(local.eks-node-private-userdata)
  #vpc_security_group_ids  = [aws_security_group.allnodes-sg.id] #var.allnodegroup_sg_id]
  vpc_security_group_ids=["sg-0d0b52e03e78ee31a"]
  tag_specifications { 
        resource_type = "instance"
    tags = {
        Name = format("%s-ng2", var.cluster-name)
        }
    }
  lifecycle {
    create_before_destroy=true
  }
}






resource "aws_eks_node_group" "eks_node_group01" {
  cluster_name    = var.cluster_name
  node_group_name = format("%s-node-group01", var.cluster-name)
  node_role_arn   = aws_iam_role.eks_node_role01.arn
  labels = {
    "alpha.eksctl.io/cluster-name"   = var.cluster-name
    "alpha.eksctl.io/nodegroup-name" = format("ng2-%s", var.cluster-name)
  }

  subnet_ids = [
    var.subnet_1a,
    var.subnet_1b
  ]

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

    launch_template {
    name    = aws_launch_template.lt-ng2.name
    version = "1"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_AmazonEC2ContainerRegistryReadOnly
  ]

  tags = var.tags
}