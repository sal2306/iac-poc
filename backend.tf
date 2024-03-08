terraform {
  backend "s3" {
    bucket         = "zantac-terraform-state-bucket"
    key            = "terraform.tfstate"
    region         = var.region
    dynamodb_table = "terraform-lock"
  }
}
