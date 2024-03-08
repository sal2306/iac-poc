variable "asg_name" {
    description = "Name of the autoscaling group for web server instance" 
}

variable "subnet_id" {
    description = "The id of subnet"
}

variable "image_id" {
    description = "Image id to be used by launch configuration."
}

variable "instance_type" {
    description = "Instance type to be used by the launch configuration"
}
