variable "image" {
  type = map
  description = "image for container"
  default = {
    dev = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }

}


variable "ext_port" {
  type    = map
  #default = 1880
  #sensitive = true

  validation {
    condition     = max(var.ext_port["dev"]...) <= 65525 && min(var.ext_port["dev"]...) >= 1980
    error_message = "The value of ext_port should be in range 0-65525."
  }

   validation {
    condition     = max(var.ext_port["prod"]...) < 1980 && min(var.ext_port["prod"]...) > 1880
    error_message = "The value of ext_port should be in range 0-65525."
  }

}

variable "int_port" {
  type = number
  default = 1880
  validation {
    condition = var.int_port == 1880
    error_message = "The internal port must be 1880."
  }
}


# variable "container_count" {
#   type    = number
#   default = 1

#   validation {
#     condition     = var.container_count < 4
#     error_message = "The value of count should be less than 4."
#   }
# }

locals {
  container_count = length(var.ext_port[terraform.workspace])
}