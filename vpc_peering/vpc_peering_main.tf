# module "vpc-west" {
# source = "terraform-aws-modules/vpc/aws"
# version = "1.53.0"name = "terraform-vpc-west"
# cidr = "10.0.0.0/16"

# azs = ["us-west-1a", "us-west-1b"]
# public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]

# enable_dns_hostnames = true
# enable_dns_support = true
# }

# module "vpc-east" {
# source = "terraform-aws-modules/vpc/aws"
# version = "1.53.0"

# name = "terraform-vpc-east"

# cidr = "10.1.0.0/16"

# azs = ["us-west-1a", "us-west-1b"]
# public_subnets = ["10.1.0.0/24", "10.1.1.0/24"]

# enable_dns_hostnames = true
# enable_dns_support = true
# }

resource "aws_vpc_peering_connection" "public_private" {
  
peer_vpc_id = var.vpc_peer_id
vpc_id = var.accepter_id
auto_accept = true

accepter {
allow_remote_vpc_dns_resolution = true
}

requester {
allow_remote_vpc_dns_resolution = true
}

tags = {
Name = "vpc-east to vpc-eastt VPC peering"
}
}

# resource "aws_route" "vpc-peering-route-accepter" {
# count = 2
# route_table_id = var.accpter_route_table_id ##"${module.vpc-east.public_route_table_ids[0]}"
# destination_cidr_block = var.accepter_cidr_block ##"${module.vpc-west.public_subnets_cidr_blocks[count.index]}"
# vpc_peering_connection_id =   "${aws_vpc_peering_connection.public_private.id}"
# }

# resource "aws_route" "vpc-peering-route-peer" {
# route_table_id = var.peer_route_table_id
# destination_cidr_block =   var.peer_cidr_block ###"${module.vpc-east.public_subnets_cidr_blocks[count.index]}"
# vpc_peering_connection_id = "${aws_vpc_peering_connection.public_private.id}"
# }