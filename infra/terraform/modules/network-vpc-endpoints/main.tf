terraform {
  required_providers {
    aws = { source = "hashicorp/aws" }
  }
}

variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "private_route_table_ids" { type = list(string) }
variable "region" { type = string }

# S3 Gateway Endpoint (required for ECR image layers)
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.private_route_table_ids
}

# Interface Endpoints (ECR + STS)
locals {
  interface_services = {
    ecr_api = "com.amazonaws.${var.region}.ecr.api"
    ecr_dkr = "com.amazonaws.${var.region}.ecr.dkr"
    sts     = "com.amazonaws.${var.region}.sts"
  }
}

resource "aws_vpc_endpoint" "iface" {
  for_each            = local.interface_services
  vpc_id              = var.vpc_id
  service_name        = each.value
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true
}
