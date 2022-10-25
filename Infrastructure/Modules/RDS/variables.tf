variable "environment" {
  description = "The environment"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ids"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "allocated_storage" {
  default     = "20"
  description = "The storage size in GB"
}

variable "engine" {
  default     = "postgres"
  description = "Engine for RDS db"
}

variable "engine_version" {
  default     = "13.7"
  description = "Engine version"
}

variable "instance_class" {
  default     = "db.t3.micro"
  description = "The instance type"
}

variable "multi_az" {
  default     = true
  description = "Muti-AZ allowed?"
}

variable "db_name" {
  default     = "theframe"
  description = "The database name"
}

variable "db_username" {
  default     = "postgres"
  description = "The username of the database"
}

variable "db_password" {
  description = "The password of the database"
}

variable "db_port" {
  default     = "5432"
  description = "DB port"
}
