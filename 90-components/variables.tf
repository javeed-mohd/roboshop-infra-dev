variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "components" {
    default = {
        # Backend components (Catalogue, User, Cart, Shippping & Payment) are attaching to Backend ALB
        catalogue = {
            rule_priority = 10
        }
        user = {
            rule_priority = 20
        }
        cart = {
            rule_priority = 30
        }
        shipping = {
            rule_priority = 40
        }
        payment = {
            rule_priority = 50
        }
        # Frontend component (Frontend) is only component attaching to Frontend ALB
        frontend = {
            rule_priority = 10
        }
    }
}