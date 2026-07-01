
# module "remote-backend" {
#     source = "./modules/remote-backend"
# }

module "vpc" {
    source = "./modules/vpc"
}

module "ec2_instances" {
    source = "./modules/ec2_instances"
    vpc_id = module.vpc.vpc_id
    public_subnet = module.vpc.public_subnet
    private_subnet_1 = module.vpc.private_subnet_1
    private_subnet_2 = module.vpc.private_subnet_2
}