module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  environment         = var.environment
  common_tags         = var.common_tags
}

module "nlb" {
  source = "./modules/nlb"

  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.public_subnet_id
  proxy_ip     = var.proxy_ip
  environment  = var.environment
  common_tags  = var.common_tags

  depends_on = [module.vpc]
}

module "web_server" {
  source = "./modules/web_server"

  vpc_id                  = module.vpc.vpc_id
  subnet_id               = module.vpc.private_subnet_id
  instance_type           = var.instance_type
  proxy_ip                = var.proxy_ip
  public_key              = var.public_key
  nlb_security_group_id   = module.nlb.nlb_security_group_id
  target_group_arn        = module.nlb.target_group_arn
  environment             = var.environment
  common_tags             = var.common_tags

  depends_on = [module.nlb]
}

