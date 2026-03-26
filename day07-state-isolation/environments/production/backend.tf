terraform{
    backend "s3" {
        bucket = "kevin-terraform-state-2025"
        key    = "environments/production/terraform.tfstate"
        region= "us-east-1"
        dynamodb_table = "terraform-state-locks"
        encrypt = true
    }
}