output "db_host" {
  value = aws_db_instance.rds.address
}

output "db_access_sg_id" {
  value = aws_security_group.db_access_sg.id
}

output "db_username" {
  value = aws_db_instance.rds.username
}

output "db_password" {
  value     = aws_db_instance.rds.password
  sensitive = true
}

output "db_name" {
  value = aws_db_instance.rds.name
}