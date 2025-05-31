variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "ZONE2" {
  default = "us-east-1b"
}

variable "ZONE3" {
  default = "us-east-1c"
}

variable "AMIS" {
  type = map(string) 
  default = {
   us-east-1 = "ami-084568db4383264d4"
 }
}

variable "USER" {
  default = "ubuntu"
}

variable "PUB_KEY" {
  default = "arch-lab-key"
}

variable "MYIP" {
  description = "The IP address or CIDR block to allow"
  type	      = string
}
