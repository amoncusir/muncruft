
output "server_ip" {
  value = hcloud_floating_ip.public_ip.ip_address
}

output "server_dns" {
  value = aws_route53_record.muncruft_dns.fqdn
}
