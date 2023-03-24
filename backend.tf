terraform {
  backend "s3" {
    bucket = "diegocarreia-vorx-terraform"
    key    = "vorx-network.tfstate"
    region = "us-east-1"
  }
}
