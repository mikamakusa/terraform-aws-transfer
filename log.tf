resource "aws_cloudwatch_log_group" "this" {
  count             = length(var.log_group)
  kms_key_id        = try(
    element(aws_kms_key.this.*.id, lookup(var.log_group[count.index], "kms_key_id"))
  )
  name              = lookup(var.log_group[count.index], "name")
  name_prefix       = lookup(var.log_group[count.index], "name_prefix")
  retention_in_days = lookup(var.log_group[count.index], "retention_in_days")
  skip_destroy      = lookup(var.log_group[count.index], "skip_destroy")
  tags              = merge(
    data.aws_default_tags.this.tags,
    var.tags,
    lookup(var.log_group[count.index], "tags")
  )
}