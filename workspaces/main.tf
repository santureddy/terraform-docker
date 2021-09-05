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

resource "null_resource" "dockervol" {

  provisioner "local-exec" {
    command = "mkdir noderedvol || true && chown -R 1000:1000 noderedvol/"
  }

}

resource "docker_image" "nodered-image" {
  name = var.image[terraform.workspace]
}
resource "random_string" "random" {
  count   = local.container_count
  length  = 4
  special = false
  upper   = false
}

resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-", ["nodered",terraform.workspace, random_string.random[count.index].result])
  image = docker_image.nodered-image.latest
  ports {
    internal = 1880
    external = var.ext_port[terraform.workspace][count.index]
  }
  volumes {
    container_path = "/data"
    host_path      = "/c/Dev/learnings/terraform-learnings/derek/terraform-docker/workspaces/noderedvol"

  }
}



