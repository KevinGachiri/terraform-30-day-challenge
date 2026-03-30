# Web Server Cluster Terraform Module

## Overview

This module provisions a highly available web server cluster on AWS using:

* Application Load Balancer (ALB)
* Auto Scaling Group (ASG)
* Launch Template
* Security Groups
* Dynamic AMI lookup (Amazon Linux 2)

It is designed to be reusable across environments (e.g., dev, production) by exposing configurable inputs.

---

## Architecture

* ALB distributes incoming HTTP traffic
* ASG manages EC2 instances across multiple subnets
* Launch Template defines instance configuration
* Security Groups control traffic flow
* Instances serve a basic Apache web page

---

## Inputs

| Name             | Description                        | Type   | Default   | Required |
| ---------------- | ---------------------------------- | ------ | --------- | -------- |
| cluster_name     | Name used for all resources        | string | n/a       | yes      |
| region           | AWS region                         | string | us-east-1 | no       |
| instance_type    | EC2 instance type                  | string | t2.micro  | no       |
| min_size         | Minimum number of instances in ASG | number | 2         | no       |
| max_size         | Maximum number of instances in ASG | number | 5         | no       |
| desired_capacity | Desired number of instances        | number | 2         | no       |
| server_port      | Port used by the web server        | number | 80        | no       |

---

## Outputs

| Name         | Description                               |
| ------------ | ----------------------------------------- |
| alb_dns_name | DNS name of the Application Load Balancer |
| asg_name     | Name of the Auto Scaling Group            |

---

## Usage Example

```hcl
module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  cluster_name     = "webservers-dev"
  instance_type    = "t2.micro"
  min_size         = 2
  max_size         = 4
  desired_capacity = 2
  server_port      = 80
}

output "alb_dns_name" {
  value = module.webserver_cluster.alb_dns_name
}
```

---

## Design Decisions

### 1. Reusability

All environment-specific values are exposed as variables. This allows the same module to be used in dev and production without code duplication.

### 2. Dynamic Infrastructure

* AMI is dynamically fetched using a data source
* Subnets and VPC are discovered instead of hardcoded

### 3. Separation of Concerns

* Module = reusable infrastructure logic
* Root config = environment-specific configuration

### 4. Defaults for Simplicity

Defaults like `t2.micro` and `desired_capacity = 2` allow quick testing while remaining configurable.

---

## Notes

* Ensure `server_port` matches the application port (Apache runs on port 80 by default)
* After deployment, access the application via the ALB DNS output

---

## Author

Built as part of a Terraform 30-Day Challenge — Day 08 (Modules)