# 🚀 Day 5 — Highly Available Web App with ALB + Terraform State Deep Dive

This project demonstrates how to deploy a **highly available web application** on AWS using Terraform — and more importantly, how Terraform behaves in real-world scenarios involving **state management and drift detection**.

---

## 🏗️ Architecture


Internet
↓
Application Load Balancer (HTTP)
↓
Target Group
↓
Auto Scaling Group
↓
EC2 Instances


### ✅ Key Features
- High availability with Auto Scaling Group (ASG)
- Load balancing using AWS Application Load Balancer (ALB)
- Dynamic AMI lookup (no hardcoding)
- Infrastructure fully defined in Terraform
- Hands-on exploration of Terraform **state & drift**

---

## 🧠 Core Concept — Terraform Mental Model

Terraform manages three states of reality:


Configuration → What you want
State → What Terraform thinks exists
Infrastructure → What actually exists


Terraform continuously reconciles these to ensure consistency.

---

## 🧪 Experiment 1 — State Manipulation

### What I Did:
- Manually edited `terraform.tfstate`
- Changed instance type:

t2.micro → t2.small


### Result:
```bash
terraform plan
```

➡️ No changes detected

Why?

Terraform refreshes state from AWS before planning, overwriting manual edits.

Forcing Detection:
terraform plan -refresh=false

➡️ Terraform detects mismatch between configuration and state

---


🌍 Experiment 2 — Drift Detection
Attempt 1 — EC2 Tag Change ❌
Modified EC2 instance tag manually
No drift detected
Why?

Instances are managed by an Auto Scaling Group and treated as ephemeral.

Attempt 2 — Security Group Change ✅

Changed port:

80 → 8080


```bash
terraform plan
```

➡️ Drift detected and correction proposed

🔧 Fixing Drift

```bash
terraform apply
```

Terraform restores infrastructure to match configuration.