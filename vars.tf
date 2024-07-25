variable "tags" {
  type    = map(string)
  default = {}
}

variable "server_name" {
  type    = string
  default = null
}

variable "cloudwatch_log_group_name" {
  type    = string
  default = null
}

variable "kms_key_name" {
  type    = string
  default = null
}

variable "directory_service_id" {
  type    = string
  default = null
}

variable "vpc_id" {
  type    = string
  default = null
}

variable "eip_id" {
  type    = string
  default = null
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "vpc_endpoint_id" {
  type    = string
  default = null
}

variable "availability_zone_id" {
  type    = string
  default = null
}

variable "security_group_id" {
  type    = string
  default = null
}

variable "route_table_id" {
  type    = string
  default = null
}

variable "s3_bucket_id" {
  type    = string
  default = null
}

variable "transfer_access_role" {
  type    = string
  default = null
}

variable "transfer_agreement_role" {
  type    = string
  default = null
}

variable "transfer_connector_role" {
  type    = string
  default = null
}

variable "transfer_server_invocation_role" {
  type    = string
  default = null
}

variable "transfer_server_logging_role" {
  type    = string
  default = null
}

variable "transfer_user_role" {
  type    = string
  default = null
}

variable "access" {
  type = list(object({
    id                  = number
    external_id         = string
    server_id           = number
    s3_bucket_id        = optional(any)
    home_directory_type = optional(string)
    policy              = optional(string)
    home_directory_mappings = optional(list(object({
      entry  = string
      target = string
    })), [])
    posix_profile = optional(list(object({
      gid            = number
      uid            = number
      secondary_gids = optional(list(string))
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "agreement" {
  type = list(object({
    id             = number
    base_directory = string
    profile_id     = number
    server_id      = number
    description    = optional(string)
    tags           = optional(map(string))
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "certificate" {
  type = list(object({
    id                = number
    certificate       = string
    usage             = string
    certificate_chain = optional(string)
    description       = optional(string)
    private_key       = optional(string)
    tags              = optional(map(string))
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "connector" {
  type = list(object({
    id                   = number
    url                  = string
    logging_role         = optional(string)
    security_policy_name = optional(string)
    tags                 = optional(map(string))
    as2_config = optional(list(object({
      mdn_response         = string
      profile_id           = number
      signing_algorithm    = optional(string)
      compression          = string
      encryption_algorithm = string
      profile_id           = optional(number)
    })), [])
    sftp_config = optional(list(object({
      trusted_host_keys = list(string)
      user_secret_id    = string
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "profile" {
  type = list(object({
    id              = number
    as2_id          = string
    profile_type    = string
    certificate_ids = optional(list(string))
    tags            = optional(map(string))
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "server" {
  type = list(object({
    id                               = number
    certificate                      = optional(string)
    directory_id                     = optional(string)
    domain                           = optional(string)
    endpoint_type                    = optional(string)
    force_destroy                    = optional(bool)
    function                         = optional(string)
    host_key                         = optional(string)
    identity_provider_type           = optional(string)
    post_authentication_login_banner = optional(string)
    pre_authentication_login_banner  = optional(string)
    protocols                        = optional(list(string))
    security_policy_name             = optional(string)
    sftp_authentication_methods      = optional(string)
    structured_log_destinations      = optional(list(string))
    tags                             = optional(map(string))
    url                              = optional(string)
    endpoint_details = optional(list(object({
      address_allocation_ids = optional(list(string))
      subnet_ids             = optional(list(string))
      vpc_endpoint_id        = optional(string)
      vpc_id                 = optional(number)
    })), [])
    protocol_details = optional(list(object({
      as2_transports              = optional(list(string))
      passive_ip                  = optional(string)
      set_stat_option             = optional(string)
      tls_session_resumption_mode = optional(string)
    })), [])
    s3_storage_options = optional(list(object({
      directory_listing_optimization = optional(string)
    })), [])
    workflow_details = optional(list(object({
      on_partial_upload = optional(list(object({
        workflow_id    = string
        execution_role = string
      })), [])
      on_upload = optional(list(object({
        workflow_id    = string
        execution_role = string
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "ssh_key" {
  type = list(object({
    id        = number
    body      = string
    server_id = number
    user_id   = number
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "tag" {
  type = list(object({
    id           = number
    key          = string
    resource_arn = number
    value        = string
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "user" {
  type = list(object({
    id                  = number
    server_id           = number
    user_name           = string
    home_directory      = optional(string)
    home_directory_type = optional(string)
    policy              = optional(string)
    tags                = optional(map(string))
    home_directory_mappings = optional(list(object({
      entry  = string
      target = string
    })), [])
    posix_profile = optional(list(object({
      uid            = number
      gid            = number
      secondary_gids = optional(list(number))
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "workflow" {
  type = list(object({
    id          = number
    description = optional(string)
    tags        = optional(map(string))
    steps = list(object({
      type = string
      copy_step_details = optional(list(object({
        name                 = optional(string)
        overwrite_existing   = optional(string)
        source_file_location = optional(string)
        destination_file_location = optional(list(object({
          efs_file_location = optional(list(object({
            file_system_id = string
            path           = string
          })), [])
          s3_file_location = optional(list(object({
            bucket = string
            key    = string
          })), [])
        })), [])
      })), [])
      custom_step_details = optional(list(object({
        name                 = optional(string)
        source_file_location = optional(string)
        target               = optional(string)
        timeout_seconds      = optional(number)
      })), [])
      decrypt_step_details = optional(list(object({
        type                 = optional(string)
        name                 = optional(string)
        overwrite_existing   = optional(string)
        source_file_location = optional(string)
        destination_file_location = optional(list(object({
          efs_file_location = optional(list(object({
            file_system_id = string
            path           = string
          })), [])
          s3_file_location = optional(list(object({
            bucket = string
            key    = string
          })), [])
        })), [])
      })), [])
      delete_step_details = optional(list(object({
        name                 = optional(string)
        source_file_location = optional(string)
      })), [])
      tag_step_details = optional(list(object({
        name                 = optional(string)
        source_file_location = optional(string)
        tags = optional(list(object({
          key   = string
          value = string
        })), [])
      })), [])
    }))
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "log_group" {
  type = list(object({
    id                = number
    kms_key_id        = optional(string)
    name              = optional(string)
    name_prefix       = optional(string)
    retention_in_days = optional(number)
    skip_destroy      = optional(bool)
    tags              = optional(map(string))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "kms_key" {
  type = list(object({
    id                                 = number
    bypass_policy_lockout_safety_check = optional(bool)
    custom_key_store_id                = optional(string)
    customer_master_key_spec           = optional(string)
    deletion_window_in_days            = optional(number)
    description                        = optional(string)
    enable_key_rotation                = optional(bool)
    is_enabled                         = optional(bool)
    key_usage                          = optional(string)
    multi_region                       = optional(bool)
    policy                             = optional(string)
    rotation_period_in_days            = optional(number)
    tags                               = optional(map(string))
    xks_key_id                         = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "directory_service" {
  type = list(object({
    id                                   = number
    name                                 = string
    password                             = string
    alias                                = optional(string)
    description                          = optional(string)
    desired_number_of_domain_controllers = optional(number)
    edition                              = optional(string)
    enable_sso                           = optional(bool)
    short_name                           = optional(string)
    size                                 = optional(number)
    tags                                 = optional(map(string))
    type                                 = optional(string)
    connect_settings = optional(list(object({
      customer_dns_ips  = optional(list(string))
      customer_username = optional(string)
      subnet_ids        = optional(list(string))
      vpc_id            = optional(string)
    })), [])
    vpc_settings = optional(list(object({
      vpc_id     = optional(string)
      subnet_ids = optional(list(string))
    })), [])
  }))
  default     = []
  description = <<EOF
EOF
}

variable "vpc" {
  type = list(object({
    id                                   = number
    cidr_block                           = string
    instance_tenancy                     = optional(string)
    ipv4_ipam_pool_id                    = optional(string)
    ipv4_netmask_length                  = optional(string)
    ipv6_cidr_block                      = optional(string)
    ipv6_cidr_block_network_border_group = optional(string)
    ipv6_ipam_pool_id                    = optional(string)
    ipv6_netmask_length                  = optional(string)
    enable_dns_support                   = optional(bool)
    enable_dns_hostnames                 = optional(bool)
    enable_network_address_usage_metrics = optional(bool)
    assign_generated_ipv6_cidr_block     = optional(bool)
    tags                                 = optional(map(string))
  }))
  default     = {}
  description = <<EOF
EOF
}

variable "vpc_endpoint" {
  type = list(object({
    id                  = number
    service_name        = string
    vpc_id              = optional(number)
    auto_accept         = optional(bool)
    ip_address_type     = optional(string)
    policy              = optional(string)
    private_dns_enabled = optional(bool)
    route_table_ids     = optional(list(number))
    security_group_ids  = optional(list(number))
    subnet_ids          = optional(list(number))
    tags                = optional(map(string))
    vpc_endpoint_type   = optional(string)
    dns_options = optional(list(object({
      dns_record_ip_type                             = optional(string)
      private_dns_only_for_inbound_resolver_endpoint = optional(bool)
    })), [])
    subnet_configuration = optional(list(object({
      ipv4      = optional(string)
      ipv6      = optional(string)
      subnet_id = optional(any)
    })), [])
  }))
  default = []
}

variable "subnet" {
  type = list(object({
    id                                             = number
    vpc_id                                         = optional(number)
    assign_ipv6_address_on_creation                = optional(bool)
    availability_zone                              = optional(string)
    availability_zone_id                           = optional(string)
    cidr_block                                     = optional(string)
    customer_owned_ipv4_pool                       = optional(string)
    enable_dns64                                   = optional(bool)
    enable_lni_at_device_index                     = optional(bool)
    enable_resource_name_dns_a_record_on_launch    = optional(bool)
    enable_resource_name_dns_aaaa_record_on_launch = optional(bool)
    ipv6_cidr_block                                = optional(string)
    ipv6_native                                    = optional(bool)
    map_customer_owned_ip_on_launch                = optional(bool)
    map_public_ip_on_launch                        = optional(bool)
    outpost_arn                                    = optional(string)
    tags                                           = optional(map(string))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "eip" {
  type = list(object({
    id                        = number
    address                   = optional(string)
    associate_with_private_ip = optional(string)
    customer_owned_ipv4_pool  = optional(string)
    domain                    = optional(string)
    instance                  = optional(string)
    network_border_group      = optional(string)
    network_interface         = optional(string)
    public_ipv4_pool          = optional(string)
    tags                      = optional(map(string))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "security_group" {
  type = list(object({
    id                     = number
    egress                 = optional(set(string))
    ingress                = optional(set(string))
    name                   = optional(string)
    name_prefix            = optional(string)
    revoke_rules_on_delete = optional(bool)
    tags                   = optional(map(string))
    vpc_id                 = optional(any)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "route_table" {
  type = list(object({
    id               = number
    vpc_id           = optional(any)
    propagating_vgws = optional(set(string))
    route            = optional(set(string))
    tags             = optional(map(string))
    route = optional(list(object({
      carrier_gateway_id         = optional(string)
      cidr_block                 = optional(string)
      core_network_arn           = optional(string)
      destination_prefix_list_id = optional(string)
      egress_only_gateway_id     = optional(string)
      gateway_id                 = optional(string)
      ipv6_cidr_block            = optional(string)
      local_gateway_id           = optional(string)
      nat_gateway_id             = optional(string)
      network_interface_id       = optional(string)
      transit_gateway_id         = optional(string)
      vpc_endpoint_id            = optional(string)
      vpc_peering_connection_id  = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
EOF
}

variable "s3_bucket" {
  type = list(object({
    id                  = number
    bucket              = optional(string)
    bucket_prefix       = optional(string)
    force_destroy       = optional(bool)
    object_lock_enabled = optional(bool)
    tags                = optional(map(string))
  }))
  default = []
}