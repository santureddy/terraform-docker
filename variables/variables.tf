variable "image" {
  type = map
  description = "image for container"
  default = {
    dev = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }

}


variable "ext_port" {
  type    = number
  #default = 1880
  #sensitive = true

  validation {
    condition     = var.ext_port <= 65525 && var.ext_port > 0
    error_message = "The value of ext_port should be in range 0-65525."
  }
}


variable "container_count" {
  type    = number
  default = 1

  validation {
    condition     = var.container_count < 4
    error_message = "The value of count should be less than 4."
  }
}
