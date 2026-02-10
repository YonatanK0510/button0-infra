variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "button0"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}