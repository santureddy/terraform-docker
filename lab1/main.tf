terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
        }
    }
}

provider "docker" {
    host = "tcp://localhost:2375"
}

resource "docker_image" "container_image" {
    name = "grafana/grafana"
}

resource "docker_container" "grafana_container" {
    count = 2
   # name = join("-", [ "test_grafana" , "${count.index}"] )
    name = "grafana_container-${count.index}"
    image = docker_image.container_image.latest
}

output "public_ip" {
    value = [
        for x in docker_container.grafana_container : "${x.name} - ${x.ip_address}"
    ]
}
