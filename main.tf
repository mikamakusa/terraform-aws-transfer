resource "aws_transfer_access" "this" {
  count               = (length(var.server) || var.server_name != null) == 0 ? 0 : length(var.access)
  external_id         = lookup(var.access[count.index], "external_id")
  server_id           = try(
    var.server_name != null ? data.aws_transfer_server.this.id : element(
      aws_transfer_server.this.*.id, lookup(var.access[count.index], "server_id")
    )
  )
  home_directory      = lookup(var.access[count.index], "home_directory")
  home_directory_type = lookup(var.access[count.index], "home_directory_type")
  policy              = lookup(var.access[count.index], "policy")
  role                = lookup(var.access[count.index], "role")

  dynamic "home_directory_mappings" {
    for_each = lookup(var.access[count.index], "home_directory_mappings") == null ? [] : ["home_directory_mappings"]
    content {
      entry  = lookup(home_directory_mappings.value, "entry")
      target = lookup(home_directory_mappings.value, "target")
    }
  }

  dynamic "posix_profile" {
    for_each = lookup(var.access[count.index], "posix_profile") == null ? [] : ["posix_profile"]
    content {
      gid            = lookup(posix_profile.value, "gid")
      uid            = lookup(posix_profile.value, "uid")
      secondary_gids = lookup(posix_profile.value, "secondary_gids")
    }
  }
}

resource "aws_transfer_agreement" "this" {
  count              = length(var.profile) == 0 ? 0 : length(var.agreement)
  access_role        = lookup(var.agreement[count.index], "access_role")
  base_directory     = lookup(var.agreement[count.index], "base_directory")
  local_profile_id   = try(element(aws_transfer_profile.this.*.id, lookup(var.agreement[count.index], "profile_id")))
  partner_profile_id = try(element(aws_transfer_profile.this.*.id, lookup(var.agreement[count.index], "profile_id")))
  server_id          = try(
    var.server_name != null ? data.aws_transfer_server.this.id : element(
      aws_transfer_server.this.*.id, lookup(var.agreement[count.index], "server_id")
    )
  )
  description        = lookup(var.agreement[count.index], "description")
  tags               = merge(
    data.aws_default_tags.this.tags,
    var.tags,
    lookup(var.agreement[count.index], "tags")
  )
}

resource "aws_transfer_certificate" "this" {
  count             = length(var.certificate)
  certificate       = file(join("/", [path.cwd, "certificate", lookup(var.certificate[count.index], "certificate")]))
  usage             = lookup(var.certificate[count.index], "usage")
  certificate_chain = file(join("/", [path.cwd, "certificate", lookup(var.certificate[count.index], "certificate_chain")]))
  description       = lookup(var.certificate[count.index], "description")
  private_key       = file(join("/", [path.cwd, "certificate", lookup(var.certificate[count.index], "private_key")]))
  tags              = merge(
    data.aws_default_tags.this.tags,
    var.tags,
    lookup(var.certificate[count.index], "tags")
  )
}

resource "aws_transfer_connector" "this" {
  count                = length(var.connector)
  access_role          = lookup(var.connector[count.index], "access_role")
  url                  = lookup(var.connector[count.index], "url")
  logging_role         = lookup(var.connector[count.index], "logging_role")
  security_policy_name = lookup(var.connector[count.index], "security_policy_name")
  tags                 = merge(
    data.aws_default_tags.this.tags,
    var.tags,
    lookup(var.connector[count.index], "tags")
  )

  dynamic "as2_config" {
    for_each = lookup(var.connector[count.index], "as2_config") == null ? [] : ["as2_config"]
    content {
      mdn_response         = lookup(as2_config.value, "mdn_response")
      local_profile_id     = try(element(aws_transfer_profile.this.*.id, lookup(as2_config.value, "profile_id")))
      signing_algorithm    = lookup(as2_config.value, "signing_algorithm")
      compression          = lookup(as2_config.value, "compression")
      encryption_algorithm = lookup(as2_config.value, "encryption_algorithm")
      partner_profile_id   = try(element(aws_transfer_profile.this.*.id, lookup(as2_config.value, "profile_id")))
    }
  }

  dynamic "sftp_config" {
    for_each = lookup(var.connector[count.index], "sftp_config") == null ? [] : ["sftp_config"]
    content {
      trusted_host_keys = lookup(sftp_config.value, "trusted_host_keys")
      user_secret_id    = lookup(sftp_config.value, "user_secret_id")
    }
  }
}

resource "aws_transfer_profile" "this" {
  count           = length(var.profile)
  as2_id          = lookup(var.profile[count.index], "as2_id")
  profile_type    = lookup(var.profile[count.index], "profile_type")
  certificate_ids = try(element(aws_transfer_certificate.this.*.certificate, lookup(var.profile[count.index], "certificate_ids")))
  tags            = merge(
    data.aws_default_tags.this.tags,
    var.tags,
    lookup(var.profile[count.index], "tags")
  )
}

resource "aws_transfer_server" "this" {
  count                            = length(var.server)
  certificate                      = lookup(var.server[count.index], "certificate") == "FTPS" ? lookup(var.server[count.index], "certificate") : null
  directory_id                     = lookup(var.server[count.index], "directory_id")
  domain                           = lookup(var.server[count.index], "certificate") == "S3" ? lookup(var.server[count.index], "domain") : null
  endpoint_type                    = lookup(var.server[count.index], "endpoint_type")
  force_destroy                    = lookup(var.server[count.index], "force_destroy")
  function                         = lookup(var.server[count.index], "function")
  host_key                         = lookup(var.server[count.index], "host_key")
  identity_provider_type           = lookup(var.server[count.index], "identity_provider_type")
  invocation_role                  = lookup(var.server[count.index], "invocation_role")
  logging_role                     = lookup(var.server[count.index], "logging_role")
  post_authentication_login_banner = sensitive(lookup(var.server[count.index], "post_authentication_login_banner"))
  pre_authentication_login_banner  = sensitive(lookup(var.server[count.index], "pre_authentication_login_banner"))
  protocols                        = lookup(var.server[count.index], "protocols")
  security_policy_name             = lookup(var.server[count.index], "security_policy_name")
  sftp_authentication_methods      = lookup(var.server[count.index], "sftp_authentication_methods")
  structured_log_destinations      = lookup(var.server[count.index], "structured_log_destinations")
  tags                             = merge(
    data.aws_default_tags.this.tags,
    var.tags,
    lookup(var.server[count.index], "tags")
  )
  url                              = lookup(var.server[count.index], "url")

  dynamic "endpoint_details" {
    for_each = lookup(var.server[count.index], "endpoint_details") == null ? [] : ["endpoint_details"]
    content {
      address_allocation_ids = var.eip_id != null ? [data.aws_eip.this.id] : null
      subnet_ids             = try(var.subnet_id != null ? [data.aws_subnet.this.id] : element(
        aws_subnet.this.*.id, lookup(endpoint_details.value, "subnet_id"))
      )
      vpc_endpoint_id        = try(var.vpc_endpoint_id != null ? data.aws_vpc_endpoint.this.id : element(
        aws_vpc_endpoint.this.*.id, lookup(endpoint_details.value, "vpc_endpoint_id"))
      )
      vpc_id                 = try(var.vpc_id != null ? data.aws_vpc.this.id : element(
        aws_vpc.this.*.id, lookup(endpoint_details.value, "vpc_id"))
      )
    }
  }

  dynamic "protocol_details" {
    for_each = lookup(var.server[count.index], "protocol_details") == null ? [] : ["protocol_details"]
    content {
      as2_transports              = lookup(protocol_details.value, "as2_transports")
      passive_ip                  = lookup(protocol_details.value, "passive_ip")
      set_stat_option             = lookup(protocol_details.value, "set_stat_option")
      tls_session_resumption_mode = lookup(protocol_details.value, "tls_session_resumption_mode")
    }
  }

  dynamic "s3_storage_options" {
    for_each = lookup(var.server[count.index], "s3_storage_options") == null ? [] : ["s3_storage_options"]
    content {
      directory_listing_optimization = lookup(s3_storage_options.value, "directory_listing_optimization")
    }
  }

  dynamic "workflow_details" {
    for_each = lookup(var.server[count.index], "workflow_details") == null ? [] : ["workflow_details"]
    content {
      dynamic "on_partial_upload" {
        for_each = lookup(workflow_details.value, "on_partial_upload") == null ? [] : ["on_partial_upload"]
        content {
          workflow_id    = lookup(on_partial_upload.value, "workflow_id")
          execution_role = lookup(on_partial_upload.value, "execution_role")
        }
      }

      dynamic "on_upload" {
        for_each = lookup(workflow_details.value, "on_upload") == null ? [] : ["on_upload"]
        content {
          execution_role = lookup(on_upload.value, "execution_role")
          workflow_id    = lookup(on_upload.value, "workflow_id")
        }
      }
    }
  }
}

resource "aws_transfer_ssh_key" "this" {
  count     = (length(var.user) && (length(var.server) || var.server_name != null)) == 0 ? 0 : length(var.ssh_key)
  body      = lookup(var.ssh_key[count.index], "body")
  server_id = try(
    var.server_name != null ? data.aws_transfer_server.this.id : element(
      aws_transfer_server.this.*.id, lookup(var.ssh_key[count.index], "server_id")
    )
  )
  user_name = try(element(aws_transfer_user.this.*.id, lookup(var.ssh_key[count.index], "user_id")))
}

resource "aws_transfer_tag" "this" {
  count        = (length(var.server) || var.server_name != null) == 0 ? 0 : length(var.tag)
  key          = lookup(var.tag[count.index], "key")
  resource_arn = try(
      var.server_name != null ? data.aws_transfer_server.this.id : element(
      aws_transfer_server.this.*.id, lookup(var.tag[count.index], "server_id")
    )
  )
  value        = lookup(var.tag[count.index], "value")
}

resource "aws_transfer_user" "this" {
  count               = (length(var.server) || var.server_name != null) == 0 ? 0 : length(var.user)
  role                = lookup(var.user[count.index], "role")
  server_id           = try(
      var.server_name != null ? data.aws_transfer_server.this.id : element(
      aws_transfer_server.this.*.id, lookup(var.user[count.index], "server_id")
    )
  )
  user_name           = lookup(var.user[count.index], "user_name")
  home_directory      = lookup(var.user[count.index], "home_directory")
  home_directory_type = lookup(var.user[count.index], "home_directory_type")
  policy              = lookup(var.user[count.index], "policy")
  tags                = merge(
    data.aws_default_tags.this.tags,
    var.tags,
    lookup(var.user[count.index], "tags")
  )

  dynamic "home_directory_mappings" {
    for_each = lookup(var.user[count.index], "home_directory_mappings") == null ? [] : ["home_directory_mappings"]
    content {
      entry  = lookup(home_directory_mappings.value, "entry")
      target = lookup(home_directory_mappings.value, "target")
    }
  }

  dynamic "posix_profile" {
    for_each = lookup(var.user[count.index], "posix_profile") == null ? [] : ["posix_profile"]
    content {
      uid            = lookup(posix_profile.value, "uid")
      gid            = lookup(posix_profile.value, "gid")
      secondary_gids = lookup(posix_profile.value, "secondary_gids")
    }
  }
}

resource "aws_transfer_workflow" "this" {
  count       = length(var.workflow)
  description = lookup(var.workflow[count.index], "description")
  tags        = merge(
    data.aws_default_tags.this.tags,
    var.tags,
    lookup(var.workflow[count.index], "tags")
  )

  dynamic "steps" {
    for_each = lookup(var.workflow[count.index], "steps") == null ? [] : ["steps"]
    content {
      type = lookup(steps.value, "type")

      dynamic "copy_step_details" {
        for_each = lookup(steps.value, "copy_step_details") == null ? [] : ["copy_step_details"]
        content {
          name                 = lookup(copy_step_details.value, "name")
          overwrite_existing   = lookup(copy_step_details.value, "overwrite_existing")
          source_file_location = lookup(copy_step_details.value, "source_file_location")

          dynamic "destination_file_location" {
            for_each = lookup(copy_step_details.value, "destination_file_location") == null ? [] : ["destination_file_location"]
            content {
              dynamic "efs_file_location" {
                for_each = lookup(destination_file_location.value, "efs_file_location") == null ? [] : ["efs_file_location"]
                content {
                  file_system_id = lookup(efs_file_location.value, "file_system_id")
                  path           = lookup(efs_file_location.value, "path")
                }
              }
              dynamic "s3_file_location" {
                for_each = lookup(destination_file_location.value, "s3_file_location") == null ? [] : ["s3_file_location"]
                content {
                  bucket = lookup(s3_file_location.value, "bucket")
                  key    = lookup(s3_file_location.value, "key")
                }
              }
            }
          }
        }
      }

      dynamic "custom_step_details" {
        for_each = lookup(steps.value, "custom_step_details") == null ? [] : ["custom_step_details"]
        content {
          name                 = lookup(custom_step_details.value, "name")
          source_file_location = lookup(custom_step_details.value, "source_file_location")
          target               = lookup(custom_step_details.value, "target")
          timeout_seconds      = lookup(custom_step_details.value, "timeout_seconds")
        }
      }

      dynamic "decrypt_step_details" {
        for_each = lookup(steps.value, "decrypt_step_details") == null ? [] : ["decrypt_step_details"]
        content {
          type                 = lookup(decrypt_step_details.value, "type")
          name                 = lookup(decrypt_step_details.value, "name")
          overwrite_existing   = lookup(decrypt_step_details.value, "overwrite_existing")
          source_file_location = lookup(decrypt_step_details.value, "source_file_location")

          dynamic "destination_file_location" {
            for_each = lookup(decrypt_step_details.value, "destination_file_location") == null ? [] : ["destination_file_location"]
            content {
              dynamic "efs_file_location" {
                for_each = lookup(destination_file_location.value, "efs_file_location") == null ? [] : ["efs_file_location"]
                content {
                  file_system_id = lookup(efs_file_location.value, "file_system_id")
                  path           = lookup(efs_file_location.value, "path")
                }
              }
              dynamic "s3_file_location" {
                for_each = lookup(destination_file_location.value, "s3_file_location") == null ? [] : ["s3_file_location"]
                content {
                  bucket = lookup(s3_file_location.value, "bucket")
                  key    = lookup(s3_file_location.value, "key")
                }
              }
            }
          }
        }
      }

      dynamic "delete_step_details" {
        for_each = lookup(steps.value, "delete_step_details") == null ? [] : ["delete_step_details"]
        content {
          name                 = lookup(delete_step_details.value, "name")
          source_file_location = lookup(delete_step_details.value, "source_file_location")
        }
      }

      dynamic "tag_step_details" {
        for_each = lookup(steps.value, "tag_step_details") == null ? [] : ["tag_step_details"]
        content {
          name                 = lookup(tag_step_details.value, "name")
          source_file_location = lookup(tag_step_details.value, "source_file_location")

          dynamic "tags" {
            for_each = lookup(tag_step_details.value, "tags") == null ? [] : ["tags"]
            content {
              key   = lookup(tags.value, "key")
              value = lookup(tags.value, "value")
            }
          }
        }
      }
    }
  }

  dynamic "on_exception_steps" {
    for_each = lookup(var.workflow[count.index], "on_exception_steps") == null ? [] : ["on_exception_steps"]
    content {
      type = lookup(on_exception_steps.value, "type")

      dynamic "copy_step_details" {
        for_each = lookup(on_exception_steps.value, "copy_step_details") == null ? [] : ["copy_step_details"]
        content {
          name                 = lookup(copy_step_details.value, "name")
          overwrite_existing   = lookup(copy_step_details.value, "overwrite_existing")
          source_file_location = lookup(copy_step_details.value, "source_file_location")

          dynamic "destination_file_location" {
            for_each = lookup(copy_step_details.value, "destination_file_location") == null ? [] : ["destination_file_location"]
            content {
              dynamic "efs_file_location" {
                for_each = lookup(destination_file_location.value, "efs_file_location") == null ? [] : ["efs_file_location"]
                content {
                  file_system_id = lookup(efs_file_location.value, "file_system_id")
                  path           = lookup(efs_file_location.value, "path")
                }
              }
              dynamic "s3_file_location" {
                for_each = lookup(destination_file_location.value, "s3_file_location") == null ? [] : ["s3_file_location"]
                content {
                  bucket = lookup(s3_file_location.value, "bucket")
                  key    = lookup(s3_file_location.value, "key")
                }
              }
            }
          }
        }
      }

      dynamic "custom_step_details" {
        for_each = lookup(on_exception_steps.value, "custom_step_details") == null ? [] : ["custom_step_details"]
        content {
          name                 = lookup(custom_step_details.value, "name")
          source_file_location = lookup(custom_step_details.value, "source_file_location")
          target               = lookup(custom_step_details.value, "target")
          timeout_seconds      = lookup(custom_step_details.value, "timeout_seconds")
        }
      }

      dynamic "decrypt_step_details" {
        for_each = lookup(on_exception_steps.value, "decrypt_step_details") == null ? [] : ["decrypt_step_details"]
        content {
          type                 = lookup(decrypt_step_details.value, "type")
          name                 = lookup(decrypt_step_details.value, "name")
          overwrite_existing   = lookup(decrypt_step_details.value, "overwrite_existing")
          source_file_location = lookup(decrypt_step_details.value, "source_file_location")

          dynamic "destination_file_location" {
            for_each = lookup(decrypt_step_details.value, "destination_file_location") == null ? [] : ["destination_file_location"]
            content {
              dynamic "efs_file_location" {
                for_each = lookup(destination_file_location.value, "efs_file_location") == null ? [] : ["efs_file_location"]
                content {
                  file_system_id = lookup(efs_file_location.value, "file_system_id")
                  path           = lookup(efs_file_location.value, "path")
                }
              }
              dynamic "s3_file_location" {
                for_each = lookup(destination_file_location.value, "s3_file_location") == null ? [] : ["s3_file_location"]
                content {
                  bucket = lookup(s3_file_location.value, "bucket")
                  key    = lookup(s3_file_location.value, "key")
                }
              }
            }
          }
        }
      }

      dynamic "delete_step_details" {
        for_each = lookup(on_exception_steps.value, "delete_step_details") == null ? [] : ["delete_step_details"]
        content {
          name                 = lookup(delete_step_details.value, "name")
          source_file_location = lookup(delete_step_details.value, "source_file_location")
        }
      }

      dynamic "tag_step_details" {
        for_each = lookup(on_exception_steps.value, "tag_step_details") == null ? [] : ["tag_step_details"]
        content {
          name                 = lookup(tag_step_details.value, "name")
          source_file_location = lookup(tag_step_details.value, "source_file_location")

          dynamic "tags" {
            for_each = lookup(tag_step_details.value, "tags") == null ? [] : ["tags"]
            content {
              key   = lookup(tags.value, "key")
              value = lookup(tags.value, "value")
            }
          }
        }
      }
    }
  }
}