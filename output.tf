# Output the Web Tier EC2 Public IPs
output "web_instance_public_ips" {
  description = "The public IP addresses of the web tier EC2 instances"
  value       = aws_instance.web_instance[*].public_ip
}

# Output the Load Balancer DNS name
output "load_balancer_dns" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.alb.dns_name
}

# Output the RDS MySQL Database Endpoint
output "rds_endpoint" {
  description = "The endpoint of the RDS MySQL instance"
  value       = aws_db_instance.mysql_db.endpoint
}

# Output the RDS MySQL Database Port
output "rds_port" {
  description = "The port of the RDS MySQL instance"
  value       = aws_db_instance.mysql_db.port
}

# Output the security group ID for Web Tier
output "web_security_group_id" {
  description = "The security group ID of the Web Tier"
  value       = aws_security_group.web_sg.id
}

# Output the VPC ID
output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.newvpc.id
}
