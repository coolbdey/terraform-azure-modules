resource "docker_image" "di" {
  name         = var.name
  keep_locally = var.keep_locally
}

resource "docker_container" "dc" {
  image = docker_image.di.latest
  name  = var.name_container

  ports {
    internal = 80
    external = 8000
  }
}
