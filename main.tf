terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "cometkim"

    workspaces {
      name = "infra"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "ap-northeast-2"
}
