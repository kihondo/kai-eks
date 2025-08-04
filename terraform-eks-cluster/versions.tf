terraform {

  required_version = ">= 1.12.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47.0" # "~> 6.7.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.1" # "~> 3.7.2"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.5" # "~> 4.1.0"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.4" # "~> 2.3.7"
    }
  }
}

provider "aws" {
  region = var.region
}
