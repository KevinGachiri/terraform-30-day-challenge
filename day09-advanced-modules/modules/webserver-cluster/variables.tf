variable "cluster_name" {
    description = "The name to use for all cluster resources"
    type = string
}

variable "region" {
    description = "AWS region"
    type = string
    default = "us-east-1"
}

variable "environment" {
    description = "Deployment environment (e.g., dev, staging, prod)"
    type = string
    default = "dev"
}

variable "instance_type" {
    description = "EC2 instance type for the cluster"
    type = string
    default = "t2.micro"
}

variable "min_size"{
    description = "Minimum number of EC2 instances in ASG"
    type = number
    default = 2
}

variable "max_size"{
    description = "Maximum number of EC2 instances in ASG"
    type = number
    default = 5
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}

variable "desired_capacity" {
    description = "Desired number of EC2 instances"
    type = number
    default = 2
}