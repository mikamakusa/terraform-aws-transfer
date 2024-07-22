resource "aws_vpc" "this" {
  count                                = length(var.vpc)
  cidr_block                           = ""
  instance_tenancy                     = ""
  ipv4_ipam_pool_id                    = ""
  ipv4_netmask_length                  = ""
  ipv6_cidr_block                      = ""
  ipv6_cidr_block_network_border_group = ""
  ipv6_ipam_pool_id                    = ""
  ipv6_netmask_length                  = ""
  enable_dns_support                   = true
  enable_dns_hostnames                 = true
  enable_network_address_usage_metrics = true
  assign_generated_ipv6_cidr_block     = true
  tags                                 = {}
}

resource "aws_vpc_endpoint" "this" {
  count               = (length(var.vpc) || var.vpc_id != null) == 0 ? 0 : length(var.vpc_endpoint)
  service_name        = ""
  vpc_id              = ""
  auto_accept         = true
  ip_address_type     = ""
  policy              = ""
  private_dns_enabled = true
  route_table_ids     = []
  security_group_ids  = []
  subnet_ids          = []
  tags                = {}
  vpc_endpoint_type   = ""

  dynamic "dns_options" {
    for_each = ""
    content {
      dns_record_ip_type                             = ""
      private_dns_only_for_inbound_resolver_endpoint = true
    }
  }

  dynamic "subnet_configuration" {
    for_each = ""
    content {
      ipv4      = ""
      ipv6      = ""
      subnet_id = ""
    }
  }
}

resource "aws_subnet" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_eip" "this" {}