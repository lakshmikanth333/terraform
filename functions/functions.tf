
===== join() =====
variable "servers" {
  default = ["prd", "dev", "stage"]
}

output "joined_servers" {
  value = join(".", var.servers)
}

# Output:
# joined_servers = "prd.dev.stage"

===== length() =====

variable "servers" {
  default = ["prd", "dev", "stage"]
}

output "servers_count" {
  value = length(var.servers)
}

# Output:
# servers_count = 3

===== lookup() =====
variable "zones" {
  default = {
    first  = "us-east-1a"
    second = "us-east-1b"
    third  = "us-east-1c"
  }
}

output "zone_lookup" {
  value = lookup(var.zones, "second", "us-east-1d")
}

# Output:
# zone_lookup = "us-east-1b"

===== format() =====
output "formatted_message" {
  value = format(
    "There are %d servers running in our %s data center",
    30,
    "Etrade"
  )
}

# Output:
# formatted_message = "There are 30 servers running in our Etrade data center"

===== upper() =====
variable "cases" {
  default = "web application"
}

output "upper_case" {
  value = upper(var.cases)
}

# Output:
# upper_case = "WEB APPLICATION"

===== file() =====
output "file_content" {
  value = file("${path.module}/test.txt")
}

# Output:
# file_content = "<contents of test.txt>"

===== split() =====
output "cloud_providers" {
  value = split(" ", "aws gcp azure")
}

# Output:
# cloud_providers = [
#   "aws",
#   "gcp",
#   "azure",
# ]

===== merge() =====
variable "env" {
  default = {
    env-1 = "prd"
    env-3 = "stage"
  }
}

variable "appl" {
  default = {
    appl-1 = "web"
    appl-2 = "app"
  }
}

output "merging" {
  value = merge(var.appl, var.env)
}

# Output:
# merging = {
#   appl-1 = "web"
#   appl-2 = "app"
#   env-1  = "prd"
#   env-3  = "stage"
# }
