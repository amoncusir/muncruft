
data "aws_route53_zone" "digitalpoet" {
  name = "digitalpoet.info."
  private_zone = false
}

resource "aws_route53_record" "muncruft_dns" {
  zone_id = data.aws_route53_zone.digitalpoet.id
  name = "${var.subdomain_name}.${data.aws_route53_zone.digitalpoet.name}"
  type = "A"
  ttl = 172800

  records = [ hcloud_floating_ip.public_ip.ip_address ]

  depends_on = [
    hcloud_server.muncruft,
    hcloud_floating_ip.public_ip
  ]
}
