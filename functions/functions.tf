# ==== join() example ====
variable "servers" {
  default = ["prd", "dev", "stage"]
}

# Just joining with dots instead of commas
output "joined_servers" {
  value = join(".", var.servers)
}
# expected: prd.dev.stage


# ==== length() ====
output "servers_count" {
  value = length(var.servers)
}
# count should be 3


# ==== lookup() ====
variable "zones" {
  default = {
    first  = "us-east-1a"
    second = "us-east-1b"
    third  = "us-east-1c"
  }
}

output "zone_lookup" {
  value = lookup(var.zones, "second", "us-east-1d") # default fallback is 1d if key missing
}
# should print us-east-1b


# ==== format() ====
variable "num_servers" {
  default = 30
}

output "formatted_message" {
  value = format(
    "We have %d servers in %s DC",
    var.num_servers,
    "Etrade"
  )
}
# sample output: We have 30 servers in Etrade DC


# ==== upper() ====
variable "cases" {
  default = "web application"
}

output "upper_case" {
  value = upper(var.cases)
}
# output: WEB APPLICATION


# ==== file() ====
# Make sure test.txt is in same dir as .tf files or this will fail
output "file_content" {
  value = file("${path.module}/test.txt")
}


# ==== split() ====
output "cloud_providers" {
  value = split(" ", "aws gcp azure")
}
# expected: ["aws", "gcp", "azure"]


# ==== merge() ====
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
# final output:
# appl-1 = web
# appl-2 = app
# env-1  = prd
# env-3  = stage
