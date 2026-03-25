#!/bin/bash

# We are creating 50GB root disk, but only 20GB is partitioned.
# Remaining 30GB storage, we need to extend using below commands.
growpart /dev/nvme0n1 4
lvextend -r -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home

# Commands for terraform installation
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform

# For Practicing purpose
# Creating Databases (MongoDB (27017), Redis (6379), MySQL (3306), RabbitMQ (5672))
cd /home/ec2-user
git clone https://github.com/javeed-mohd/roboshop-infra-dev.git
chown ec2-user:ec2-user -R roboshop-infra-dev
cd roboshop-infra-dev/40-databases
terraform init
terraform apply -auto-approve

# Creating Components (Catalogue (8080), User (8080), Cart (8080), Shipping (8080), Payment (8080), Frontend (80))
cd /home/ec2-user
git clone https://github.com/javeed-mohd/roboshop-infra-dev.git
chown ec2-user:ec2-user -R roboshop-infra-dev
cd roboshop-infra-dev/90-components
terraform init
terraform apply -auto-approve