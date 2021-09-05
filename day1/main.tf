terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      #version = "2.14.0"
    }
  }
}

provider "docker" {

  host = "tcp://localhost:2375"
}

resource "docker_image" "nodered-image" {
  name = "nodered/node-red:latest"
}
resource "random_string" "random" {
  count = 1
  length = 4
  special = false
  upper = false
}

resource "docker_container" "nodered_container" {
  count = 1
  name  = join("-",["nodered", random_string.random[count.index].result])
  image = docker_image.nodered-image.latest
  ports {
    internal = 1880
    //external = 1880
  }
}

output "ip_address" {
   value = [for i in docker_container.nodered_container[*]: join(":", [i.ip_address], i.ports[*]["external"] )]
   description = "IP address and external port of the container"
}

output "container_name" {
  value       = docker_container.nodered_container[*].name
  description = "Name of the container"
}

# output "IP_Address_1" {
#   value       = join(":", [docker_container.nodered_container[0].ip_address, docker_container.nodered_container[0].ports[0].external])
#   description = "IP address of container"

# }

# output "IP_Address_2" {
#   value       = join(":", [docker_container.nodered_container[1].ip_address, docker_container.nodered_container[1].ports[0].external])
#   description = "IP address of container"

# }

# output "container_name_2" {
#   value       = docker_container.nodered_container[1].name
#   description = "Name of the container"
# }

