

# aws: public subnet, igw, nat
resource "aws_subnet" "aws_public_subnet" {
  vpc_id     = aws_vpc.aws_vpc.id
  cidr_block = var.aws_public_cidr_block
  availability_zone = var.aws_zone_1

  map_public_ip_on_launch = true

  tags = {
    Name = var.aws_public_subnet
  }
}

resource "aws_internet_gateway" "aws_vpc_igw" {
  vpc_id = aws_vpc.aws_vpc.id

  tags = {
    Name = "aws-vpc-igw"
  }
}


# security: routes and security groups









# aws: jumpbox
resource "aws_key_pair" "generated_key" {
  key_name   = "${var.aws_key_name}"
  public_key = ${file(var.aws_ssh_pub_key_file)}"

}

resource "aws_instance" "aws-vm" {
  ami           = var.aws_image_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.aws-subnet1.id
  key_name      = "vm-ssh-key"

  associate_public_ip_address = true
  private_ip                  = var.aws_vm_address

  vpc_security_group_ids = [
    aws_security_group.aws-allow-icmp.id,
    aws_security_group.aws-allow-ssh.id,
    aws_security_group.aws-allow-vpn.id,
    aws_security_group.aws-allow-internet.id,
  ]

  user_data = replace(
    replace(
      file("vm_userdata.sh"),
      "<EXT_IP>",
      google_compute_address.gcp-ip.address,
    ),
    "<INT_IP>",
    var.gcp_vm_address,
  )

  tags = {
    Name = "aws-vm-${var.aws_region}"
  }
}