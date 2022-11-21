terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.66"
    }
  }
}

locals {
  prefix             = "stigg-integration-demo"
  nodejs_version     = "nodejs14.x"
  log_retention_days = 1
}

variable "owner" {
  type        = string
  description = "The owner of the application for auditing purposes"
}

variable "stigg_server_api_key" {
  type        = string
  description = "The Stigg Server API key obtained from https://app.stigg.io/account/settings"
  sensitive   = true
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy this application to"
  default     = "us-east-2"
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      App         = "Stigg integration"
      Description = "Demo for integrating Stigg with API Gateway authorizer"
      Owner       = var.owner
    }
  }
}
