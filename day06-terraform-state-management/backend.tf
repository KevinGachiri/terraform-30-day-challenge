terraform {
    backend "s3" {
        bucket = "kevin-tf-state-unique123"
        key = "day06/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "terraform-state-locks"
        encrypt = true
    }
}