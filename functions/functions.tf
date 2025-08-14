# ===== join() =====
variable "servers" {
  default = ["prd", "dev", "stage"]
}

output "joined_servers" {
  value = join(".", var.servers)
}
# Output: "prd.dev.stage"

# ===== length() =====
output "servers_count" {
  value = length(var.servers)
}
# Output: 3

# ===== lookup() =====
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
# Output: "us-east-1b"

# ===== format() =====
variable "num_servers" {
  default = 30
}

output "formatted_message" {
  value = format(
    "There are %d servers running in our %s data center",
    var.num_servers,
    "Etrade"
  )
}
# Output: "There are 30 servers running in our Etrade data center"

# ===== upper() =====
variable "cases" {
  default = "web application"
}

output "upper_case" {
  value = upper(var.cases)
}
# Output: "WEB APPLICATION"

# ===== file() =====
# Make sure test.txt exists in the same folder as this Terraform file
output "file_content" {
  value = file("${path.module}/test.txt")
}
# Output: contents of test.txt

# ===== split() =====
output "cloud_providers" {
  value = split(" ", "aws gcp azure")
}
# Output: ["aws", "gcp", "azure"]

# ===== merge() =====
variable "env_map" {
  default = {
    env-1 = "prd"
    env-3 = "stage"
  }
}

variable "appl_map" {
  default = {
    appl-1 = "web"
    appl-2 = "app"
  }
}

output "merging" {
  value = merge(var.appl_map, var.env_map)
}
# Output:
# {
#   appl-1 = "web"
#   appl-2 = "app"
#   env-1  = "prd"
#   env-3  = "stage"
# }
