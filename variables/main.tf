resource "null_resource" "dockervol" {

  provisioner "local-exec" {
    command = "mkdir noderedvol || true && chown -R 1000:1000 noderedvol/"
  }

}

module "image" {
  source = "./image"
  image_in = var.image[terraform.workspace]  
}

resource "random_string" "random" {
  count   = var.container_count
  length  = 4
  special = false
  upper   = false
}

resource "docker_container" "nodered_container" {
  count = var.container_count
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = module.image.image_out
  ports {
    internal = 1880
    external = var.ext_port
  }
  volumes {
    container_path = "/data"
    host_path = "/c/Dev/learnings/terraform-learnings/derek/terraform-docker/variables/noderedvol/"
  }
}



