variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "route_table_ids" { type = list(string) } # private route tables
variable "region" { type = string }

# Optional: tighten endpoint access via SG
variable "endpoint_sg_id" {
  type    = string
  default = null
}
