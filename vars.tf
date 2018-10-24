

variable "aws_region" {
    default = "us-east-1"
    description = "Determine AWS region endpoint to access."
}

variable "image_id" {
  default =  "ami-0ac019f4fcb7cb7e6" 
}


variable "desired_capacity_on_demand" {
    default = 1
    description = "Number of instance to run"
}

variable "ec2_key_name" {
    default = "test-pet"
    description = "EC2 key name to SSH to the instance, make sure that you have this key if you want to access your instance via SSH"
}

variable "instance_type" {
    default = "t2.medium"
    description = "EC2 instance type to use"
}


variable "pub_subnet1_cidr" {
    default = "10.0.1.0/24"
}

variable "pub_subnet2_cidr" {
    default = "10.0.2.0/24"
}

variable "priv_subnet_cidr" {
    default = "10.0.3.0/24"
}

variable "subnet_azs" {
    description = "Subnet AZ, separated by comma. Default is \"a,b\". Please check your available AZ before specifying this value."
    default = "a,b"
}
