aws_region = {
  default = "eu-west-1"
}

vpc_cidr = {
  default = "10.0.0.0/16"
}

permitted_ip = {
  description = "Office ip address used in security groups"
  default = "185.73.154.30/32"
}

subnet_cidr = { 
  default = "10.0.1.0/24"
}

ebs_az = {
  deafult = "eu-west-1a"
}

ebs_type = {
  default = "gp2"
}

ebs_size = {
  default = 100 
}

ghe_ami = {
  default = "ami-0eb44f5448fee0991"
}

ghe_type = {
  deafult = "m3.xlarge"
}

permited_ip = {
  deafult = "185.73.154.30/32"
}