# Terraform Functions Example
# Functions let you manipulate data dynamically and make your code reusable.

variable "servers" {
  default = ["prd", "dev"]
}

# join function: combines list items into a single string with a separator
output "joining" {
  value = join(".", var.servers)  # Output: "prd.dev"
}

output "length" {
    value = length(var.servers)
}