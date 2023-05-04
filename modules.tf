module "network" {
  source = "./modules/network"

  cluster_name = var.cluster_name
  tags         = var.tags
  cidr_block   = var.cidr_block
}

module "cluster" {
  source = "./modules/cluster"

  cluster_name = var.cluster_name
  tags         = var.tags
  cidr_block   = var.cidr_block

  subnet_1a = module.network.subnet_1a
  subnet_1b = module.network.subnet_1b
}

module "node_group" {
  source = "./modules/node_group"

  cluster_name = var.cluster_name
  tags         = var.tags

  subnet_1a = module.network.subnet_1a
  subnet_1b = module.network.subnet_1b
  key_name="mytest"
  vpc_id = module.network.vpc_id
  cluster-name=var.cluster_name

  depends_on = [
    module.cluster
  ]
}

module "storage" {
  source = "./modules/storage/"
  vpc_id = module.network.vpc_id
  cluster-name= var.cluster_name
  subnet_ids_a = module.network.subnet_1a
  subnet_ids_b = module.network.subnet_1b
  
}