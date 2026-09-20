terraform {
  backend "s3" {
    bucket  = "icp-3f5078d1-2026-terraform-state"
    key     = "terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}
