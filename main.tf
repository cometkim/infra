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

    neon = {
      source = "kislerdm/neon"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region

  # It's using dynamic provider crendential set on Terraform Cloud
  # See https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "neon" {
  api_key = var.neon_api_key
}

data "cloudflare_accounts" "me" {
  name = "cometkim"
}
