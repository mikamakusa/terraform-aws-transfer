## Requirements

| Name | Version    |
|------|------------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | \>= 5.58.0 |

## Providers

| Name | Version    |
|------|------------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | \>= 5.58.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_transfer_access.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_access) | resource |
| [aws_transfer_agreement.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_agreement) | resource |
| [aws_transfer_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_certificate) | resource |
| [aws_transfer_connector.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_connector) | resource |
| [aws_transfer_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_profile) | resource |
| [aws_transfer_server.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_server) | resource |
| [aws_transfer_ssh_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_ssh_key) | resource |
| [aws_transfer_tag.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_tag) | resource |
| [aws_transfer_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_user) | resource |
| [aws_transfer_workflow.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_workflow) | resource |
| [aws_default_tags.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [aws_transfer_server.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/transfer_server) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access"></a> [access](#input\_access) | n/a | <pre>list(object({<br>    id                  = number<br>    external_id         = string<br>    server_id           = number<br>    home_directory      = optional(string)<br>    home_directory_type = optional(string)<br>    policy              = optional(string)<br>    role                = optional(string)<br>    home_directory_mappings = optional(list(object({<br>      entry  = string<br>      target = string<br>    })), [])<br>    posix_profile = optional(list(object({<br>      gid            = number<br>      uid            = number<br>      secondary_gids = optional(list(string))<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_agreement"></a> [agreement](#input\_agreement) | n/a | <pre>list(object({<br>    id             = number<br>    access_role    = number<br>    base_directory = string<br>    profile_id     = number<br>    server_id      = number<br>    description    = optional(string)<br>    tags           = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_certificate"></a> [certificate](#input\_certificate) | n/a | <pre>list(object({<br>    id                = number<br>    certificate       = string<br>    usage             = string<br>    certificate_chain = optional(string)<br>    description       = optional(string)<br>    private_key       = optional(string)<br>    tags              = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_connector"></a> [connector](#input\_connector) | n/a | <pre>list(object({<br>    id                   = number<br>    access_role          = string<br>    url                  = string<br>    logging_role         = optional(string)<br>    security_policy_name = optional(string)<br>    tags                 = optional(map(string))<br>    as2_config = optional(list(object({<br>      mdn_response         = string<br>      profile_id           = number<br>      signing_algorithm    = optional(string)<br>      compression          = string<br>      encryption_algorithm = string<br>      profile_id           = optional(number)<br>    })), [])<br>    sftp_config = optional(list(object({<br>      trusted_host_keys = list(string)<br>      user_secret_id    = string<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | n/a | <pre>list(object({<br>    id              = number<br>    as2_id          = string<br>    profile_type    = string<br>    certificate_ids = optional(list(string))<br>    tags            = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_server"></a> [server](#input\_server) | n/a | <pre>list(object({<br>    id                               = number<br>    certificate                      = optional(string)<br>    directory_id                     = optional(string)<br>    domain                           = optional(string)<br>    endpoint_type                    = optional(string)<br>    force_destroy                    = optional(bool)<br>    function                         = optional(string)<br>    host_key                         = optional(string)<br>    identity_provider_type           = optional(string)<br>    invocation_role                  = optional(string)<br>    logging_role                     = optional(string)<br>    post_authentication_login_banner = optional(string)<br>    pre_authentication_login_banner  = optional(string)<br>    protocols                        = optional(list(string))<br>    security_policy_name             = optional(string)<br>    sftp_authentication_methods      = optional(string)<br>    structured_log_destinations      = optional(list(string))<br>    tags                             = optional(map(string))<br>    url                              = optional(string)<br>    endpoint_details = optional(list(object({<br>      address_allocation_ids = optional(list(string))<br>      subnet_ids             = optional(list(string))<br>      vpc_endpoint_id        = optional(string)<br>      vpc_id                 = optional(string)<br>    })), [])<br>    protocol_details = optional(list(object({<br>      as2_transports              = optional(list(string))<br>      passive_ip                  = optional(string)<br>      set_stat_option             = optional(string)<br>      tls_session_resumption_mode = optional(string)<br>    })), [])<br>    s3_storage_options = optional(list(object({<br>      directory_listing_optimization = optional(string)<br>    })), [])<br>    workflow_details = optional(list(object({<br>      on_partial_upload = optional(list(object({<br>        workflow_id    = string<br>        execution_role = string<br>      })), [])<br>      on_upload = optional(list(object({<br>        workflow_id    = string<br>        execution_role = string<br>      })), [])<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name) | n/a | `string` | `null` | no |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | n/a | <pre>list(object({<br>    id        = number<br>    body      = string<br>    server_id = number<br>    user_id   = number<br>  }))</pre> | `[]` | no |
| <a name="input_tag"></a> [tag](#input\_tag) | n/a | <pre>list(object({<br>    id           = number<br>    key          = string<br>    resource_arn = number<br>    value        = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_user"></a> [user](#input\_user) | n/a | <pre>list(object({<br>    id                  = number<br>    role                = string<br>    server_id           = number<br>    user_name           = string<br>    home_directory      = optional(string)<br>    home_directory_type = optional(string)<br>    policy              = optional(string)<br>    tags                = optional(map(string))<br>    home_directory_mappings = optional(list(object({<br>      entry  = string<br>      target = string<br>    })), [])<br>    posix_profile = optional(list(object({<br>      uid            = number<br>      gid            = number<br>      secondary_gids = optional(list(number))<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_workflow"></a> [workflow](#input\_workflow) | n/a | <pre>list(object({<br>    id          = number<br>    description = optional(string)<br>    tags        = optional(map(string))<br>    steps = list(object({<br>      type = string<br>      copy_step_details = optional(list(object({<br>        name                 = optional(string)<br>        overwrite_existing   = optional(string)<br>        source_file_location = optional(string)<br>        destination_file_location = optional(list(object({<br>          efs_file_location = optional(list(object({<br>            file_system_id = string<br>            path           = string<br>          })), [])<br>          s3_file_location = optional(list(object({<br>            bucket = string<br>            key    = string<br>          })), [])<br>        })), [])<br>      })), [])<br>      custom_step_details = optional(list(object({<br>        name                 = optional(string)<br>        source_file_location = optional(string)<br>        target               = optional(string)<br>        timeout_seconds      = optional(number)<br>      })), [])<br>      decrypt_step_details = optional(list(object({<br>        type                 = optional(string)<br>        name                 = optional(string)<br>        overwrite_existing   = optional(string)<br>        source_file_location = optional(string)<br>        destination_file_location = optional(list(object({<br>          efs_file_location = optional(list(object({<br>            file_system_id = string<br>            path           = string<br>          })), [])<br>          s3_file_location = optional(list(object({<br>            bucket = string<br>            key    = string<br>          })), [])<br>        })), [])<br>      })), [])<br>      delete_step_details = optional(list(object({<br>        name                 = optional(string)<br>        source_file_location = optional(string)<br>      })), [])<br>      tag_step_details = optional(list(object({<br>        name                 = optional(string)<br>        source_file_location = optional(string)<br>        tags = optional(list(object({<br>          key   = string<br>          value = string<br>        })), [])<br>      })), [])<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_server_endpoint_details"></a> [server\_endpoint\_details](#output\_server\_endpoint\_details) | n/a |
| <a name="output_server_id"></a> [server\_id](#output\_server\_id) | n/a |
| <a name="output_server_url"></a> [server\_url](#output\_server\_url) | n/a |
| <a name="output_user_home_directory"></a> [user\_home\_directory](#output\_user\_home\_directory) | n/a |
| <a name="output_user_id"></a> [user\_id](#output\_user\_id) | n/a |
