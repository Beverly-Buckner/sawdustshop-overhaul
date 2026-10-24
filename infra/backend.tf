terraform {
  backend "s3" {
    bucket       = "sawdustshop-tf-bucket"
    key          = "sawdustshop/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}