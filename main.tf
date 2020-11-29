
# provider block required with Schematics to set VPC region
provider "ibm" {
  region = var.ibm_region
  #ibmcloud_api_key = var.ibmcloud_api_key
  generation = local.generation
  version    = "~> 1.4"
}

data "ibm_resource_group" "all_rg" {
  name = var.resource_group_name
}

locals {
  generation     = 2
  frontend_count = 1
}


locals {
  frontend_cidr_blocks = [cidrsubnet(var.frontend_cidr, 4, 0), cidrsubnet(var.frontend_cidr, 4, 2), cidrsubnet(var.frontend_cidr, 4, 4)]
}


module "frontend" {
  source                   = "./frontendmodule"
  ibm_region               = var.ibm_region
  unique_id                = var.vpc_name
  ibm_is_vpc_id            = var.vpc_id
  ibm_is_resource_group_id = data.ibm_resource_group.all_rg.id
  frontend_count           = local.frontend_count
  profile                  = var.profile
  ibm_is_image_id          = data.ibm_is_image.os.id
  ibm_is_ssh_key_id        = data.ibm_is_ssh_key.sshkey.id
  subnet_ids               = var.frontend_subnet_ids
  bastion_remote_sg_id     = var.bastion_security_group_id
  bastion_subnet_CIDR      = var.bastion_cidr
  pub_repo_egress_cidr     = local.pub_repo_egress_cidr
}
