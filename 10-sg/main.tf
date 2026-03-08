module "sg" {
    count       = length(var.sg_names) # Gives the count of security groups.
    source      = "../../terraform-aws-sg-module" # In projects, we use "git::https://github.com/javeed-mohd/terraform-aws-vpc.git?ref=main", to directly get it from git if someone updated...
    project     = var.project # project/project_name can be used as you wish(Not necessarily it should be same but it gives the exact default value provided).
    environment = var.environment
    sg_name     = replace(var.sg_names[count.index], "_", "-") # We can use for_each by using set/map.
    vpc_id      = local.vpc_id
}