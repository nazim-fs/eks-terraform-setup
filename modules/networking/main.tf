module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.14.0"

  name = "rebtel-${var.environment}-vpc"
  cidr = var.vpc_cidr
  azs  = data.aws_availability_zones.available.names
  private_subnets      = var.private_subnet_cidrs
  public_subnets       = var.public_subnet_cidrs
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "Name"                                          = "rebtel-${var.environment}-vpc"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                        = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"               = "1"
  }
}
