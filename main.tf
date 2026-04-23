# Create and set network within VPC
module "vpc" {
  source = "./modules/VPC"

  cluster_name         = var.cluster_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

# Create and set cluster within EKS using VPC subnets
module "eks" {
  source = "./modules/EKS"

  cluster_name       = var.cluster_name
  subnet_ids         = module.vpc.private_subnet_ids
  node_subnet_ids    = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
  node_instance_type = var.node_instance_type
  desired_size       = var.desired_size
  max_size           = var.max_size
  min_size           = var.min_size
}