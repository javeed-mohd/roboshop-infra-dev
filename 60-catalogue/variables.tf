# project/project_name can be used as you wish(Not necessarily it should be same but it gives the exact default value provided).
# First only main, variables and provider
variable "project" {
  default   = "roboshop"
}

variable "environment" {
  default   = "dev"
}

variable "zone_id" {
  default   = "Z0883755364LI3FEBC65Q"
}

variable "domain_name" {
  default   = "devopsdaws.online"
}

# For overriding the app version updates we use this
variable "app_version" {
  default   = "v3"
}