output "subnet_1a" {
  value = aws_subnet.subnet_1a.id
}

output "subnet_1b" {
  value = aws_subnet.subnet_1b.id
}
output "vpc_id" {
  value = aws_vpc.vpc.id
  
}
output "eks_route_table_id" {
  value = aws_route_table.route_table.id
}