
# variable "env" {
#   type = string
#   default = "dev"
#   description = "Environment to be deployed"  
# }

variable "image" {
    type = map
    description = "Image for containers"
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
    condition     = max(var.ext_port["dev"]...) <= 65525 && min(var.ext_port["dev"]...) > 1879
    error_message = "The value of ext_port should be in range 1881-65525."
  }

   validation {
    condition     = max(var.ext_port["prod"]...) <= 65525 && min(var.ext_port["prod"]...) > 1979
    error_message = "The value of ext_port should be in range 1881-65525."
  }
}


# variable "container_count" {
#   type    = number
#   default = 2

#   validation {
#     condition     = var.container_count < 4
#     error_message = "The value of count should be less than 4."
#   }
# }

locals {
  container_count = length(var.ext_port[terraform.workspace])
}