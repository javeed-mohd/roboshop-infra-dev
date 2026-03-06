module "vpc" {
    source              = "../../terraform-aws-vpc" # In projects, we use "git::https://github.com/javeed-mohd/terraform-aws-vpc.git?ref=main", to directly get it from git if someone updated...
    project             = var.project # project/project_name can be used as you wish(Not necessarily it should be same but it gives the exact default value provided).
    environment         = var.environment
    is_peering_required = true 
}