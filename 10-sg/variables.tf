# project/project_name can be used as you wish(Not necessarily it should be same but it gives the exact default value provided).
variable "project" {
  default   = "roboshop"
}

variable "environment" {
  default   = "dev"
}

variable "sg_names" {
  type      = list
  default   = [
    # Databases
    "mongodb", "redis", "mysql", "rabbitmq",
    # Backend
    "catalogue", "user", "cart", "shipping", "payment",
    # Backend Application Load Balancer(ALB)
    "backend_alb",
    # Frontend
    "frontend",
    # Frontend Application Load Balancer(ALB)
    "frontend_alb",
    # Bastion --> A bastion host is a special server that acts as a secure gateway to access resources inside a private network (like private VMs or instances).
    "bastion" 
  ]
}