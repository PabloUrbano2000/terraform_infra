virginia_cidr = "10.10.0.0/16"

subnets = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {
  "env"         = "dev"
  "owner"       = "Pablo"
  "cloud"       = "AWS"
  "IAC"         = "Terraform"
  "IAC_Version" = "1.6.2"
  "project"     = "cerberus"
  "region"      = "virginia"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami"           = "ami-01eccbf80522b562b"
  "instance_type" = "t2.micro"
}

# enable_monitoring = true
enable_monitoring = 0

ingress_ports_list = [22, 80, 443]
