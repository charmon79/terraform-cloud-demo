resource "aws_route_table_association" "public_route_aza" {
  subnet_id      = data.aws_subnet.subnet_aza.id
  route_table_id = "rtb-caef29a1"
}

### security groups
resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg-${var.env}"
  description = "Security group for bastion host"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    description = "SSH from Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg-${var.env}"
  }
}

resource "aws_security_group" "private-sg" {
  name        = "private-sg-${var.env}"
  description = "Security group for private hosts"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    description = "All Private Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_subnet.subnet_aza.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-sg-${var.env}"
  }
}