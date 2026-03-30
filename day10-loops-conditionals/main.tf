resource "aws_iam_user" "each_users" {
    for_each = toset(var.user_names)
    name = "each-${each.value}"
}

variable "users"{
    type = map(object({
        department = string
        admin = bool
    }))

    default = {
        alice = {
            department = "engineering"
            admin = true
        },
        bob = {
            department = "marketing"
            admin = false
        },
        charlie = {
            department = "sales"
            admin = false
        }
    }
}

resource "aws_iam_user" "mapped_users" {
    for_each = var.users
    name = each.key

    tags = {
        Department = each.value.department
        Admin = tostring(each.value.admin)
    }
}

locals {
    instance_type = var.environment == "production" ? "t2.medium" : "t2.micro"
}

data "aws_ami" "amazon_linux" {
    most_recent = true
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["amazon"]
}

resource "aws_instance" "web"{
    ami = data.aws_ami.amazon_linux.id
    instance_type = local.instance_type

    tags = {
        Name = "Web Server"
        Environment = var.environment
    }
}

resource "aws_autoscaling_group" "example" {
    count = var.enable_autoscaling ? 1 : 0

    name = "example-asg"
    min_size = 1
    max_size = 3

    vpc_zone_identifier = var.subnet_ids

    launch_template {
      id = var.launch_template_id
      version = "$Latest"
    }
}

