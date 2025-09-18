################
# DMZ routes
################



################
# Publiс routes
################
# Create Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.base.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  depends_on = [ aws_internet_gateway.internet_gateway ]

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-Public"

  })
}

#################
# Private routes
#################

##########################
# Route table association
##########################

# Create Route Association 
resource "aws_route_table_association" "public" {
  count          = length(var.network_info.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
  depends_on     = [aws_subnet.public, aws_route_table.public]
}

