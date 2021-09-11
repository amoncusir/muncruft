
variable "aws_region" {
  type = string
  default = "eu-west-1"
}

variable "aws_secret_key" {
  type = string
}

variable "aws_access_key" {
  type = string
}

variable "hetzner_token" {
  type = string
}

variable "hetzner_server_type" {
  type = string
  default = "cx21"
}

variable "hetzner_location" {
  type = string
  default = "fsn1"
}

variable "enable_ssh" {
  type = bool
  default = false
}

variable "delete_protection" {
  type = bool
  default = true
}

variable "subdomain_name" {
  type = string
  default = "muncruft"
}

variable "minecraft_ports" {
  type = list(map(string))
  default = [
    {
      port = "25565"
      protocol = "tcp"
    },
    {
      port = "25565"
      protocol = "udp"
    },
    {
      port = "25575"
      protocol = "tcp"
    },
    {
      port = "25575"
      protocol = "udp"
    }
  ]
}

variable "user_data_location" {
  type = string
  default = "https://raw.githubusercontent.com/amoncusir/muncruft/main/user_data.sh"
}
