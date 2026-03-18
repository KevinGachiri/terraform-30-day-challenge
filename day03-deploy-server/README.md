# Day 3 – Deploying My First Server with Terraform

Day 3 focused on deploying a real server on AWS using Terraform and making it accessible via a web browser.

---

## Terraform Configuration

### Provider

I configured Terraform to use AWS in the `us-east-1` region:


provider "aws" {
region = "us-east-1"
profile = "terraform-labs"
}


---

### AMI (Dynamic Lookup)

Instead of hardcoding an AMI, I used a data source to fetch the latest Amazon Linux 2 image:


data "aws_ami" "latest" {
most_recent = true

owners = ["amazon"]

filter {
name = "name"
values = ["amzn2-ami-hvm-*-x86_64-gp2"]
}
}


---

### Security Group

I created a security group to allow HTTP traffic:


resource "aws_security_group" "web_sg" {
name = "web-sg"
description = "Allow HTTP traffic"

ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}


---

### EC2 Instance + Web Server

I provisioned an EC2 instance and used `user_data` to install and start a web server:


resource "aws_instance" "web" {
ami = data.aws_ami.latest.id
instance_type = "t2.micro"

vpc_security_group_ids = [aws_security_group.web_sg.id]

user_data = <<-EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Deployed via Terraform</h1>" > /var/www/html/index.html
EOF

tags = {
Name = "Terraform-Web-Server"
}
}


---

## Terraform Workflow


terraform init
terraform plan
terraform apply


---

## Deployment Output

After applying, Terraform created:

- EC2 instance
- Security group
- Public IP

---

## Server Verification

I accessed the server using the public IP:


http://<public-ip>


The page loaded successfully with:


Deployed via Terraform


---

## Key Learnings

- Terraform uses AWS CLI credentials for authentication
- Infrastructure can be fully defined and deployed from code
- Security groups control access to cloud resources
- `user_data` allows automated server configuration

---

## Cleanup

To avoid unnecessary costs:


terraform destroy