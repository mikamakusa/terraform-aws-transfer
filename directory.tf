resource "aws_directory_service_directory" "this" {
  count = length(var.directory_service)
  name                                 = ""
  password                             = ""
  alias                                = ""
  description                          = ""
  desired_number_of_domain_controllers = 0
  edition                              = ""
  enable_sso                           = true
  short_name                           = ""
  size                                 = 0
  tags                                 = {}
  type                                 = ""

  dynamic "connect_settings" {
    for_each = ""
    content {
      customer_dns_ips  = []
      customer_username = ""
      subnet_ids        = []
      vpc_id            = ""
    }
  }

  dynamic "vpc_settings" {
    for_each = ""
    content {
      vpc_id     = ""
      subnet_ids = []
    }
  }
}