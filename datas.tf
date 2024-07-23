data "aws_default_tags" "this" {}

data "aws_transfer_server" "this" {
  count     = var.server_name ? 1 : 0
  server_id = var.server_name
}

data "aws_cloudwatch_log_group" "this" {
  count = var.cloudwatch_log_group_name ? 1 : 0
  name  = var.cloudwatch_log_group_name
}

data "aws_kms_key" "this" {
  count  = var.kms_key_name ? 1 : 0
  key_id = var.kms_key_name
}

data "aws_directory_service_directory" "this" {
  count        = var.directory_service_id ? 1 : 0
  directory_id = var.directory_service_id
}

data "aws_vpc" "this" {
  count = var.vpc_id ? 1 : 0
  id    = var.vpc_id
}

data "aws_eip" "this" {
  count = var.eip_id ? 1 : 0
  id    = var.eip_id
}

data "aws_subnet" "this" {
  count = var.subnet_id ? 1 : 0
  id    = var.subnet_id
}

data "aws_vpc_endpoint" "this" {
  count = var.vpc_endpoint_id ? 1 : 0
  id    = var.vpc_endpoint_id
}

data "aws_availability_zone" "this" {
  count = var.availability_zone_id ? 1 : 0
  id    = var.availability_zone_id
}

data "aws_security_group" "this" {
  count = var.security_group_id ? 1 : 0
  id    = var.security_group_id
}

data "aws_route_table" "this" {
  count = var.route_table_id ? 1 : 0
  id    = var.route_table_id
}

data "aws_s3_bucket" "this" {
  count  = var.s3_bucket_id ? 1 : 0
  bucket = var.s3_bucket_id
}