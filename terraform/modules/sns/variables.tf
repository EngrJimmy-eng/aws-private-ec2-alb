variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "notification_email" {
  description = "Email address to receive SNS alerts"
  type        = string
}
