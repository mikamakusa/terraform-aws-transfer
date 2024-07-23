run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "transfer_server" {
  command = [init,plan,apply]

  variables {
    s3_bucket = [
      {
        id      = 0
        bucket  = "my-tf-test-bucket"
      }
    ]
    subnet = [
      {
        id         = 0
        vpc_id     = 0
        cidr_block = "10.0.1.0/24"
      }
    ]
    vpc_id = [
      {
        id               = 0
        cidr_block       = "10.0.0.0/16"
        instance_tenancy = "default"
      }
    ]
    eip = [
      {
        id               = 0
        domain           = "vpc"
        public_ipv4_pool = "ipv4pool-ec2-012345"
      }
    ]
    access = [
      {
        id             = 0
        external_id    = "S-1-1-12-1234567890-123456789-1234567890-1234"
        server_id      = 0
        s3_bucket_id   = 0
      }
    ]
    agreement = [
      {
        id                 = 0
        base_directory     = "/DOC-EXAMPLE-BUCKET/home/mydirectory"
        description        = "example"
        local_profile_id   = 0
        partner_profile_id = 1
        server_id          = 0
      }
    ]
    certificate = [
      {
        id                = 0
        certificate       = "example.crt"
        certificate_chain = "ca.crt"
        private_key       = "example.key"
        description       = "example"
        usage             = "SIGNING"
      }
    ]
    connector = [
      {
        id = 0
        sftp_config = [
          {
            trusted_host_keys = ["ssh-rsa AAAAB3NYourKeysHere"]
          }
        ]
        url = "sftp://test.com"
      }
    ]
    profile = [
      {
        id              = 0
        as2_id          = "example1"
        usage           = "LOCAL"
      },
      {
        id              = 1
        as2_id          = "example2"
        usage           = "LOCAL"
      }
    ]
    server = [
      {
        id                          = 0
        endpoint_type               = "PUBLIC"
        protocols                   = ["SFTP"]
      },
      {
        id                      = 1
        endpoint_type           = "VPC"
        endpoint_details = [
          {
            address_allocation_ids = [0]
            subnet_ids  = [0]
            vpc_id      = 0
          }
        ]
        protocols               = ["FTP", "FTPS"]
        identity_provider_type  = "API_GATEWAY"
      }
    ]
    user = [
      {
        id                      = 0
        server_id               = 0
        user_name               = "tftestuser"
        home_directory_type     = "LOGICAL"
        home_directory_mappings = [
          {
            entry  = "/test.pdf"
            target = "/bucket3/test-path/tftestuser.pdf"
          }
        ]
      }
    ]
  }
}