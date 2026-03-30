# Webserver Cluster Terraform Module

## Overview

This Terraform module provisions a scalable and highly available web server cluster on AWS using an Auto Scaling Group (ASG) and Application Load Balancer (ALB). It is designed for reuse across multiple environments (e.g., dev, staging, production) with version-controlled deployments.

---

## Features

* Application Load Balancer (ALB)
* Auto Scaling Group (ASG)
* Launch Template for EC2 instances
* Configurable scaling parameters
* Environment-based customization
* Versioned module support via Git tags

---

## Inputs

| Name          | Type   | Description                 | Default  |
| ------------- | ------ | --------------------------- | -------- |
| cluster_name  | string | Name of the cluster         | n/a      |
| instance_type | string | EC2 instance type           | t2.micro |
| min_size      | number | Minimum number of instances | 2        |
| max_size      | number | Maximum number of instances | 4        |
| environment   | string | Environment name (dev/prod) | dev      |

---

## Outputs

| Name         | Description                    |
| ------------ | ------------------------------ |
| alb_dns_name | DNS name of the load balancer  |
| asg_name     | Name of the Auto Scaling Group |

---

## Usage

```hcl
module "webserver_cluster" {
  source = "github.com/KevinGachiri/terraform-30-day-challenge//day09-advanced-modules/modules/webserver-cluster?ref=v0.0.2"

  cluster_name  = "webservers-dev"
  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 4
}
```

---

## Versioning Strategy

This module uses Git tags for versioning:

* v0.0.1 → Initial stable release
* v0.0.2 → Added environment variable support

### Why Versioning Matters

Pinning module versions ensures:

* Stable production deployments
* Controlled rollouts of changes
* Prevention of unexpected infrastructure drift

---

## Multi-Environment Deployment Pattern

* **Development** uses the latest version:

  ```
  ref=v0.0.2
  ```

* **Production** is pinned to a stable version:

  ```
  ref=v0.0.1
  ```

This allows safe testing in dev before promoting changes to production.

---

## Known Gotchas

### 1. File Path Resolution

Always use:

```hcl
${path.module}
```

instead of relative paths like `./file.sh`.

---

### 2. Inline vs Separate Resources

Avoid mixing inline blocks and standalone resources (e.g., security group rules) to prevent conflicts.

---

### 3. Module Output Dependencies

Avoid using entire modules in `depends_on`. Instead, reference specific outputs to prevent unnecessary resource recreation.

---

## Requirements

* Terraform >= 1.0
* AWS Provider >= 4.0

---

## Author

Kevin Gachiri -- DevOps Engineer
