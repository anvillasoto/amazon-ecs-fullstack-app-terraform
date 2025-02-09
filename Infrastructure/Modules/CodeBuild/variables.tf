# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "name" {
  type        = string
  description = "CodeBuild Project name"
}

variable "iam_role" {
  type        = string
  description = "IAM role to attach to CodeBuild"
}
variable "region" {
  type        = string
  description = "AWS Region used"
}
variable "account_id" {
  description = "AWS Account ID where the solution is being deployed"
  type        = string
}
variable "ecr_repo_url" {
  description = "AWS ECR repository URL where docker images are being stored"
  type        = string
}

variable "folder_path" {
  description = "Folder path to use to build the docker images/containers"
  type        = string
}

variable "buildspec_path" {
  description = "Path to for the Buildspec file"
  type        = string
}

variable "task_definition_family" {
  description = "The family name of the Task definition"
  type        = string
}

variable "container_name" {
  description = "The name of the Container specified in the Task definition"
  type        = string
}

variable "service_port" {
  description = "The number of the port used by the ECS Service"
  type        = number
}

variable "ecs_role" {
  description = "The name of the ECS Task Excecution role to specify in the Task Definition"
  type        = string
}

variable "server_alb_url" {
  description = "The server ALB DNS. Used to build the code for the frontend layer"
  type        = string
  default     = ""
}

variable "ecs_task_role" {
  description = "The name of the ECS Task role to specify in the Task Definition"
  type        = string
  default     = "null"
}

variable "db_host" {
  default     = "localhost"
  description = "The database hostname (for backend only)"
}

variable "db_name" {
  default     = "theframe"
  description = "The database name (for backend only)"
}

variable "db_username" {
  default     = "postgres"
  description = "The username of the database (for backend only)"
}

variable "db_password" {
  default     = "postgres"
  description = "The password of the database (for backend only)"
}

variable "db_port" {
  default     = "5432"
  description = "DB port (for backend only)"
}
