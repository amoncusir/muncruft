
resource "hcloud_firewall" "ssh" {

  count = var.enable_ssh ? 1 : 0

  name = "ssh"

  rule {
    direction = "in"
    protocol = "tcp"
    port = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_firewall" "minecraft" {

  name = "minecraft"

  rule {
    description = "Minecraft tcp port"
    direction = "in"
    protocol = "tcp"
    port = var.minecraft_port
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    description = "Minecraft udp port"
    direction = "in"
    protocol  = "udp"
    port      = var.minecraft_port
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_server" "muncruft" {
  name        = "muncruft-ubuntu"
  image       = "ubuntu-20.04"

  server_type = var.hetzner_server_type
  location    = var.hetzner_location

  user_data = "curl -s ${var.user_data_location} | sh"

  firewalls_id = [ hcloud_firewall.minecraft.id ]

  delete_protection = var.delete_protection
  rebuild_protection = var.delete_protection

  depends_on = [
    hcloud_firewall.minecraft
  ]
}

resource "hcloud_floating_ip" "public_ip" {
  type      = "ipv4"
  server_id = hcloud_server.node1.id

  depends_on = [
    hcloud_server.muncruft,
    hcloud_firewall.minecraft
  ]
}