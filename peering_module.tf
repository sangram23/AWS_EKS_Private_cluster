module "peering" {
  source = "./vpc_peering"
  vpc_peer_id=module.public_access_vpc.vpc_public_access_id
  accepter_id=module.network.vpc_id
  depends_on = [ module.network,module.public_access_vpc ,module.public_access_subnet,module.cluster,module.node_group]


}


resource "aws_route" "vpc-peering-route-public" {
route_table_id =  module.public_access_subnet["az_1a"].public_subne_route_table_id
destination_cidr_block =   var.cidr_block ###"${module.vpc-east.public_subnets_cidr_blocks[count.index]}"
vpc_peering_connection_id = module.peering.public_private_peering_id
depends_on = [ module.peering ]
}
resource "aws_route" "vpc-peering-route-eks" {
route_table_id = module.network.eks_route_table_id
destination_cidr_block =   var.vpc_cidr["public_cidr"] ###"${module.vpc-east.public_subnets_cidr_blocks[count.index]}"
vpc_peering_connection_id = module.peering.public_private_peering_id
depends_on = [ module.peering ]
}