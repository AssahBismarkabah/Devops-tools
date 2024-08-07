packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

variable "aws_access_key" {
  type    = string
  default = ""
}

variable "aws_secret_key" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = "us-east-2"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_name" {
  type    = string
  default = "wordpress-ami-1"  # Use a static name or a unique identifier
}

source "amazon-ebs" "ubuntu" {
  access_key        = var.aws_access_key
  secret_key        = var.aws_secret_key
  region            = var.region
  source_ami        = "ami-0c55b159cbfafe1f0"  # Ubuntu 20.04 LTS
  instance_type     = var.instance_type
  ssh_username      = "ubuntu"
  ami_name          = var.ami_name
}

build {
  sources = ["source.amazon-ebs.ubuntu"]



  provisioner "shell" {
    inline = [
      "sudo add-apt-repository universe",
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
      "sudo apt-get install -y python3-distutils-extra python3-setuptools",
      "sudo apt-get install -y build-essential python3-dev python3-wheel",
      "sudo apt-get install -y python3 python3-pip",
      "sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1",
      "sudo apt-get install -y docker.io",
      "pip3 install ansible"
    ]
  }

  provisioner "shell" {
    inline = [
      "ansible-galaxy collection install community.docker"
    ]
  }

  provisioner "ansible" {
    playbook_file = "ansible/wordpress-playbook.yml"
  }

  provisioner "ansible" {
    playbook_file = "ansible/requirements.yml"
  }
}
