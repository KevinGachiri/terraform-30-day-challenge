provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  tags = {
    Name = "tf-${var.env}-instance"
  }
}

# data"terraform_remote_state" "dev" {
#   backend = "s3"

#   config = {
#     bucket = "kevin-terraform-state-2025"
#     key = "environments/dev/terraform.tfstate"
#     region = "us-east-1"
#   }
# }