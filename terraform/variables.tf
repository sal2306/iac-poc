variable "cidr_block" {
  description = "CIDR block of the VPC."
  default = "10.0.0.0/16"
}

variable "region" {
  description = "The AWS region where resources will be provisioned."
  default     = "us-east-1"
}