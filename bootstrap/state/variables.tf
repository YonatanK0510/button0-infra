variable "project_name" {
  description = "Project name for resource naming and tagging"
  type        = string
  validation {
    condition     = length(var.project_name) > 0 && length(var.project_name) <= 32
    error_message = "Project name must be between 1 and 32 characters."
  }
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  type        = string
  description = "Optional override for the Terraform state bucket name. If null, uses <project>-terraform-state-<account_id>."
  default     = null
}

variable "dynamodb_table_name" {
  type        = string
  description = "Optional override for the Terraform lock table name. If null, uses <project>-terraform-locks."
  default     = null
}
