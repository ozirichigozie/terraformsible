# VPC Requirements
variable "custom_vpc" {
  description = "VPC for testing env"
  type        = string
  default     = "10.0.0.0/16"
}

#EC2 Requirements
variable "instance_tenancy" {
  description = "defines whetther VPC's tenancy is default or dedicated"
  type        = string
  default     = "default"
}

variable "ami_id" {
  description = "ami id"
  type        = string
  default     = "ami-00c39f71452c08778"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

# ensure keypair pem file has the right permissions
variable "ssh_private_key" {
  description = "Keypair pem file used to login to instances"
  type        = string
  default     = "~/newkey.pem"
}
