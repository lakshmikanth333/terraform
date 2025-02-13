variable "ami_id" {}



variable "sub" {
  default = "work_sub"
}

variable "instance_type" {

  validation {
    condition     = contains(["t2.micro", "t2.small", "t2.large"], var.instance_type)
    error_message = "Please select a valid instace for this environment"
  }
}

variable "server_name" {}

variable "msg" {}

