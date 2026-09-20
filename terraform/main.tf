resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "icp-devops-vpc"
    Environment = "dev"
    Project     = "ICP-3F5078D1-2026"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name        = "icp-public-subnet"
    Environment = "dev"
    Project     = "ICP-3F5078D1-2026"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name        = "icp-private-subnet"
    Environment = "dev"
    Project     = "ICP-3F5078D1-2026"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "icp-internet-gateway"
    Environment = "dev"
    Project     = "ICP-3F5078D1-2026"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "icp-public-route-table"
    Environment = "dev"
    Project     = "ICP-3F5078D1-2026"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "icp-private-route-table"
    Environment = "dev"
    Project     = "ICP-3F5078D1-2026"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_ecr_repository" "app" {
  name                 = "icp-devops-app"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name        = "icp-devops-app"
    Environment = "dev"
    Project     = "ICP-3F5078D1-2026"
  }
}
