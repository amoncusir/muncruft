
locals {
  user_data = templatefile("${path.module}/data/user_data.sh", {
    rcon_password    = var.rcon_password
    environment_vars = var.environment_vars
  })
}

resource "hcloud_firewall" "ssh" {

  count = var.enable_ssh ? 1 : 0

  name = "ssh"

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_firewall" "minecraft" {

  name = "minecraft"

  dynamic "rule" {
    for_each = var.minecraft_ports

    content {
      description = "Minecraft tcp port in ${rule.value["port"]}"
      direction   = "in"
      protocol    = rule.value["protocol"]
      port        = rule.value["port"]
      source_ips = [
        "0.0.0.0/0",
        "::/0"
      ]
    }
  }
}

resource "hcloud_server" "muncruft" {
  name  = "muncruft-ubuntu"
  image = "ubuntu-20.04"

  server_type = var.hetzner_server_type
  location    = var.hetzner_location

  user_data = local.user_data

  firewall_ids = [hcloud_firewall.minecraft.id]

  delete_protection  = var.delete_protection
  rebuild_protection = var.delete_protection

  depends_on = [
    hcloud_firewall.minecraft
  ]
}

resource "hcloud_floating_ip" "public_ip" {
  type      = "ipv4"
  server_id = hcloud_server.muncruft.id

  depends_on = [
    hcloud_server.muncruft,
    hcloud_firewall.minecraft
  ]
}