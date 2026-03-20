# 🚀 Terraform: Highly Available Web App on AWS

This project demonstrates how to deploy a **scalable, highly available web application** on AWS using Terraform as part of a hands-on DevOps learning challenge.

---

## 🧱 Architecture


Internet
↓
Application Load Balancer (ALB)
↓
Target Group
↓
Auto Scaling Group (EC2 Instances)


---

## ⚙️ Technologies Used

- Terraform
- AWS EC2
- AWS Application Load Balancer (ALB)
- AWS Auto Scaling Group (ASG)
- Amazon Linux 2
- Apache (httpd)

---

## 🔧 Features

- ✅ No hardcoded values (DRY principle)
- ✅ Dynamic AMI retrieval using data sources
- ✅ Auto Scaling (min: 2, max: 5)
- ✅ Load balancing via ALB
- ✅ Health checks for high availability
- ✅ Infrastructure as Code (IaC)

---

## 🚀 How to Deploy

```bash
terraform init
terraform plan
terraform apply 
```


# 🌐 Access the Application

After deployment:

http://terraform-web-alb-1442852711.us-east-1.elb.amazonaws.com

# 🧠 Key Learnings

Applying the DRY principle in Terraform

Transitioning from a single instance to a scalable architecture

Using data sources instead of hardcoding values

Understanding AWS-specific behaviors (e.g., Launch Template requirements)

# ⚠️ Important Gotcha

When using Launch Templates:

user_data = base64encode(...)

Unlike aws_instance, Launch Templates require base64-encoded user data.

# 🧹 Cleanup

To avoid unnecessary AWS costs:

``` bash
terraform destroy
```