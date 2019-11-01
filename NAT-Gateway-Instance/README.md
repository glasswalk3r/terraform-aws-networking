# NAT Gateway

Adds a NAT Gateway EC2 instance to the `VPC-PublicPrivateSubnets` project,so
you will need to setup it first before applying the related Terraform
configuration.

The current AWS AMI for VPC NAT instance has no configuration of Netfilter to
implement the NAT, so a user data was added. Maybe should be better to automate
an AMI creation with packer?
