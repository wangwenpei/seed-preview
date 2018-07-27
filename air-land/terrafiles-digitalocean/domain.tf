# Create a new domain
resource "digitalocean_domain" "default" {
  name       = "${var.domain}"
  ip_address = "${digitalocean_droplet.proxy.ipv4_address}"
}