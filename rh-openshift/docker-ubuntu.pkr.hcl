packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}

// Define variables at the top level
variable "docker_image" {
  type    = string
  default = "ubuntu:jammy"
}

source "docker" "ubuntu-focal" {
  image  = "ubuntu:focal"
  commit = true
}


source "docker" "ubuntu" {
  image  = var.docker_image
  commit = true
}

build {
  name = "learn-packer"
  sources = [
    "source.docker.ubuntu",
    "source.docker.ubuntu-focal",
  ]


  provisioner "shell" {
    environment_vars = [
      "FOO=hello world",
    ]
    inline = [
      "echo Adding file to Docker Container",
      "echo \"FOO is $FOO\" > example.txt",
    ]
  }

  provisioner "shell" {
    inline = ["echo Running $(cat /etc/os-release | grep VERSION= | sed 's/\"//g' | sed 's/VERSION=//g') Docker image."]
  }
  
  post-processor "docker-tag" {
  repository = "learn-packer"
  tags       = ["ubuntu-jammy", "packer-rocks"]
  only       = ["docker.ubuntu"]
}

post-processor "docker-tag" {
  repository = "learn-packer"
  tags       = ["ubuntu-focal", "packer-rocks"]
  only       = ["docker.ubuntu-focal"]
}

}
