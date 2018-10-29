variable "aws_region"  {
  default = "eu-west-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "permitted_ip" {
  description = "Office ip address used in security groups"
  default = "185.73.154.30/32"
}

variable "subnet_cidr" { 
  default = "10.0.1.0/24"
}

variable "anywhere_cidr" {
  default = "0.0.0.0/0"
}


variable "ebs_az" {
  default = "eu-west-1a"
}

variable "ebs_type" {
  default = "gp2"
}

variable "ebs_size" {
  default = 300
}

variable "ghe_ami" {
  default = "ami-0eb44f5448fee0991"
}

variable "ghe_type" {
  default = "m3.xlarge"
}

variable "permited_ip" {
  default = "185.73.154.30/32"
}