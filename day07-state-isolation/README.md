# 🚀 Day 07 — Terraform State Isolation: Workspaces vs File Layout

## 📌 Overview

This project demonstrates how to safely manage **multiple environments (dev, staging, production)** in Terraform using two approaches:

* **Workspaces**
* **File Layout Isolation (recommended for production)**

It also showcases:

* Remote state management with **S3**
* State locking with **DynamoDB**
* Cross-environment data sharing using **terraform_remote_state**

---

## 🧠 Key Concept

Terraform operates on three layers:

```
CONFIG (.tf) → STATE (.tfstate) → REAL INFRA (AWS)
```

👉 Proper isolation = separating **state**, not just code.

---

## 🏗️ Project Structure (File Layout Approach)

```
day07-state-isolation/
└── environments/
    ├── dev/
    ├── staging/
    └── production/
```

Each environment contains:

* `main.tf`
* `variables.tf`
* `backend.tf`
* `terraform.tfvars`

---

## 🔐 Backend Configuration (S3 + DynamoDB)

Each environment uses:

* Same S3 bucket
* Different **state key (path)**

Example:

```hcl
key = "environments/dev/terraform.tfstate"
```

👉 This ensures **complete state isolation**

---

## ⚙️ Deployment

Each environment is deployed independently:

```bash
cd environments/dev
terraform init -reconfigure
terraform apply -auto-approve
```

Repeat for:

* staging
* production

---

## ✅ Result

* 3 independent environments
* 3 separate state files in S3
* Zero cross-environment interference

---

## 🔄 Remote State Usage

Production reads outputs from dev:

```hcl
data "terraform_remote_state" "dev" {
  backend = "s3"

  config = {
    bucket = "your-bucket"
    key    = "environments/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
```

---

## ⚖️ Workspaces vs File Layout

| Feature          | Workspaces           | File Layout |
| ---------------- | -------------------- | ----------- |
| Isolation        | Weak                 | Strong      |
| Risk             | High (easy mistakes) | Low         |
| Code Separation  | None                 | Clear       |
| Production Ready | ❌                    | ✅           |

---

## 💥 Key Takeaways

* State isolation is critical for safe infrastructure management
* Workspaces are useful for quick setups but risky at scale
* File layouts provide **clear boundaries and production safety**
* Remote state enables modular infrastructure design

---

## 📸 Proof of Deployment

✔ Dev, Staging, and Production instances deployed
✔ Independent state files verified
✔ No cross-environment impact

---

## 🔗 Blog Post

👉 [Read the full breakdown here](#) *https://terraform-day01.hashnode.dev/terraform-state-isolation-workspaces-vs-file-layouts-when-to-use-each*

---

## 🏁 Final Thought

> “Good infrastructure works. Great infrastructure is safe, predictable, and isolated.”

---

## 👨‍💻 Author

Kevin Gachiri
Cloud Engineer | AWS | Terraform | DevOps
