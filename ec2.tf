# Creating 3-EC2 Instances
resource "aws_instance" "instance" {
  count           = length(aws_subnet.public_subnet.*.id)
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = element(aws_subnet.public_subnet.*.id, count.index)
  security_groups = [aws_security_group.sg.id, ]
  key_name        = "newkey"
  user_data       = file("userdata.sh")

  tags = {
    "Name"        = "Instance-${count.index}"
    "Environment" = "Test"
    "CreatedBy"   = "Terraform"
  }

  timeouts {
    create = "10m"
  }
}

# Creating 3 Elastic IPs
resource "aws_eip" "eip" {
  count            = length(aws_instance.instance.*.id)
  instance         = element(aws_instance.instance.*.id, count.index)
  public_ipv4_pool = "amazon"
  vpc              = true

  tags = {
    "Name" = "EIP-${count.index}"
  }
}

# Creating EIP Association with EC2 instances
resource "aws_eip_association" "eip_association" {
  count         = length(aws_eip.eip)
  instance_id   = element(aws_instance.instance.*.id, count.index)
  allocation_id = element(aws_eip.eip.*.id, count.index)
}

# resource "local_file" "public_ip" {
#   content  = "${zipmap(aws_instance.instance.*.tags.Name, aws_eip.eip.*.public_ip)}"
#   filename = "hosts"
# }