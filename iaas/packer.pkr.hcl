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
  default = "wordpress-ami-${timestamp()}"
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
      "sudo apt-get update",
      "sudo apt-get install -y docker.io"
    ]
  }

  provisioner "ansible" {
    playbook_file = "iaas/wordpress-playbook.yml"
  }
}
