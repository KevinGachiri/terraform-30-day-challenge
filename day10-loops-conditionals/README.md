📘 Day 10: Terraform Loops and Conditionals — Dynamic Infrastructure at Scale
🚀 Overview

On Day 10 of the Terraform Challenge, I moved from static infrastructure definitions to dynamic, scalable configurations using:

count
for_each
for expressions
Conditional logic (ternary operator)

This eliminated repetition and made the infrastructure flexible, reusable, and production-ready.

🧠 Key Concepts Implemented
🔁 1. for_each with Sets (Stable Resource Creation)
resource "aws_iam_user" "each_users" {
  for_each = toset(var.user_names)
  name     = "each-${each.value}"
}
Created IAM users dynamically from a list
Used toset() to ensure uniqueness
Avoided index-based issues from count

✅ Result:

each-alice
each-bob
each-charlie
🗂️ 2. for_each with Maps (Structured Data)
resource "aws_iam_user" "mapped_users" {
  for_each = var.users
  name     = each.key

  tags = {
    Department = each.value.department
    Admin      = tostring(each.value.admin)
  }
}
Used a map(object) for richer configuration
Attached metadata (department, admin)

✅ Result:

IAM users created with structured tags
⚙️ 3. Conditional Logic (Environment-Based Configuration)
locals {
  instance_type = var.environment == "production" ? "t2.medium" : "t2.micro"
}
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = local.instance_type
}
Automatically adjusts instance size based on environment

✅ Result:

dev → t2.micro
production → t2.medium
🔍 4. Dynamic AMI Lookup (Data Source)
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
Avoids hardcoding AMIs
Always retrieves latest Amazon Linux image
🔀 5. Conditional Resource Creation
resource "aws_autoscaling_group" "example" {
  count = var.enable_autoscaling ? 1 : 0
}
Enables or disables resources dynamically

✅ Behavior:

true → resource created
false → resource skipped
🔄 6. for Expressions (Data Transformation)
output "upper_names" {
  value = [for name in var.user_names : upper(name)]
}
output "user_arns" {
  value = {
    for name, user in aws_iam_user.mapped_users :
    name => user.arn
  }
}

✅ Outputs:

upper_names = ["ALICE", "BOB", "CHARLIE"]

user_arns = {
  "alice"   = "arn:aws:iam::...:user/alice"
  "bob"     = "arn:aws:iam::...:user/bob"
  "charlie" = "arn:aws:iam::...:user/charlie"
}
⚠️ count vs for_each — Critical Insight
Problem with count:
Uses indexes (count.index)
Removing an item shifts indexes
Causes unexpected resource recreation
Why for_each is better:
Uses unique keys
Only affected resources change
Safer for real-world infrastructure

🧠 Analogy:

count → numbered seats (shifting chaos)
for_each → named seats (stable)
🧪 What Was Deployed
✅ 6 IAM Users (2 looping strategies)
✅ 1 EC2 Instance (environment-aware)
⛔ Autoscaling Group (conditionally disabled)
✅ Dynamic outputs (transformed data)
📸 Results
IAM users successfully created via loops
EC2 instance running (t2.micro in dev)
Outputs correctly generated using for expressions
🧱 Project Structure
day10-loops-conditionals/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── README.md

🧠 Key Takeaways
for_each is safer and more predictable than count
for expressions transform data without creating resources
Conditional logic enables environment-aware infrastructure
Data sources remove hardcoding and improve portability
Terraform can behave like a programming language when used effectively

🚀 Next Steps
Refactor previous modules (Day 8/9) using for_each
Introduce dynamic blocks
Implement full autoscaling setup with launch templates

🔗 Resources
Terraform Docs: https://developer.hashicorp.com/terraform
AWS Provider Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs