# Terraform State Mastery: Remote Backends & State Locking with S3 + DynamoDB

## 🚀 Overview

This project demonstrates how to move Terraform state from local storage to a secure, production-ready remote backend using AWS S3 and DynamoDB.

It focuses on solving real-world challenges such as collaboration, state corruption, and concurrent infrastructure changes.

---

## 🧠 Problem Statement

By default, Terraform stores state locally. This creates several issues:

* No safe collaboration across teams
* High risk of state corruption
* Sensitive data exposure
* No protection against concurrent changes

---

## 🔐 Solution Architecture

* **Amazon S3**

  * Stores Terraform state remotely
  * Enabled versioning for recovery
  * Enforced server-side encryption (SSE-S3)

* **AWS DynamoDB**

  * Provides state locking
  * Prevents concurrent operations

---

## ⚙️ Backend Configuration

```hcl
terraform {
  backend "s3" {
    bucket         = "kevin-tf-state-unique123"
    key            = "day06/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
```

### 🔍 Explanation

* `bucket` → S3 bucket storing the state file
* `key` → Path to the state file inside the bucket
* `region` → AWS region of the backend
* `dynamodb_table` → Enables state locking
* `encrypt` → Ensures state is encrypted at rest

---

## 🛠️ Infrastructure Deployed

* EC2 Instance (Amazon Linux)
* Dynamic AMI retrieval using Terraform data source

---

## 🔄 State Migration

After configuring the backend, Terraform detected the change during `terraform init` and prompted for migration.

The local state was successfully moved to S3 and verified via the AWS Console.

---

## 🔒 State Locking Test

Running concurrent Terraform operations resulted in a lock error:

```bash
Error acquiring the state lock
```

This confirms DynamoDB is actively preventing conflicting changes.

---

## 🔍 State Insights

Using:

```bash
terraform state list
terraform state show aws_instance.example
```

Terraform stores:

* Resource IDs
* Attributes (IP, subnet, instance type)
* Metadata (ARNs, dependencies)
* Outputs

---

## ⚠️ Key Learnings

* Never commit `terraform.tfstate`
* Remote state is essential for teams
* State locking prevents infrastructure corruption
* Versioning enables rollback and recovery
* Backend must be created manually (bootstrap problem)

---

## 🧪 Commands Used

```bash
terraform init
terraform plan
terraform apply
terraform state list
terraform state show aws_instance.example
terraform destroy
```

---

## 📌 Outcome

Successfully implemented a secure and collaborative Terraform workflow using:

* Remote state storage (S3)
* State locking (DynamoDB)
* Encryption and versioning

This setup reflects a production-ready Infrastructure as Code environment.

---

## 🔗 Repository


