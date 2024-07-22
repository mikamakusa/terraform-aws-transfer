output "server_id" {
  value = try(
    aws_transfer_server.this.*.id
  )
}

output "server_url" {
  value = try(
    aws_transfer_server.this.*.url
  )
}

output "server_endpoint_details" {
  value = try(
    aws_transfer_server.this.*.endpoint_details
  )
}

output "user_id" {
  value = try(
    aws_transfer_user.this.*.id
  )
}

output "user_home_directory" {
  value = try(
    aws_transfer_user.this.*.home_directory
  )
}