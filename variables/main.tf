resource "null_resource" "dockervol" {

  provisioner "local-exec" {
    command = "sleep 60 && mkdir noderedvol || true && sudo chown -R 1000:1000 noderedvol/"
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
  depends_on = [null_resource.dockervol]
  count = var.container_count
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = module.image.image_out
  ports {
    internal = 1880
    external = var.ext_port[terraform.workspace][count.index]
  }
  volumes {
    container_path = "/data"
    # For Windows
    #host_path = "/c/Dev/learnings/terraform-learnings/derek/terraform-docker/variables/noderedvol/"
    # For Linux
    host_path = "${path.cwd}/noderedvol"
  }
}



