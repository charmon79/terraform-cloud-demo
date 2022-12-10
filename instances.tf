### bastion server
resource "aws_instance" "bastion" {
  ami           = "ami-02af65b2d1ebdfafc" # Ubuntu Server 20.04 ARM
  instance_type = "t4g.small"
  key_name      = aws_key_pair.aws_sandbox.id

  network_interface {
    network_interface_id = aws_network_interface.bastion-nic.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    encrypted   = true
    kms_key_id  = "alias/aws/ebs"
    volume_type = "gp3"
    volume_size = 50
  }

  volume_tags = {
    InstanceName = "bastion-${var.env}"
  }

  tags = {
    Name = "bastion-${var.env}"
  }

  # workaround for use of default EBS key forcing replacement (see: https://github.com/hashicorp/terraform-provider-aws/issues/13860)
  lifecycle {
    ignore_changes = [root_block_device[0].kms_key_id]
  }
}

resource "aws_eip" "bastion-eip" {
  tags = {
    Name = "bastion-eip-${var.env}"
  }
}

resource "aws_network_interface" "bastion-nic" {
  subnet_id       = data.aws_subnet.subnet_aza.id
  security_groups = [aws_security_group.bastion-sg.id]
  tags = {
    Name = "bastion-nic-${var.env}"
  }
}

### some private server
resource "aws_instance" "app-server" {
  ami           = "ami-02af65b2d1ebdfafc" # Ubuntu Server 20.04 ARM
  instance_type = "t4g.small"
  key_name      = aws_key_pair.aws_sandbox.id

  network_interface {
    network_interface_id = aws_network_interface.app-server-nic.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    encrypted   = true
    kms_key_id  = "alias/aws/ebs"
    volume_type = "gp3"
    volume_size = 50
  }

  volume_tags = {
    InstanceName = "app-server-${var.env}"
  }

  tags = {
    Name = "app-server-${var.env}"
  }

  # workaround for use of default EBS key forcing replacement (see: https://github.com/hashicorp/terraform-provider-aws/issues/13860)
  lifecycle {
    ignore_changes = [root_block_device[0].kms_key_id]
  }
}

resource "aws_network_interface" "app-server-nic" {
  subnet_id       = data.aws_subnet.subnet_aza.id
  security_groups = [aws_security_group.private-sg.id]
  tags = {
    Name = "app-server-nic-${var.env}"
  }
}
