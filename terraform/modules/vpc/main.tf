resource "aws_vpc" "main" {
  name = "zantac-vpc"
  cidr_block = var.cidr_block
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_subnet
}