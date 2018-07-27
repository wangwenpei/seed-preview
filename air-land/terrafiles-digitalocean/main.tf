# 只用请求构造一个代理服务器

# root 公钥
resource "digitalocean_ssh_key" "root" {
  name = "stormxx"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# 机器
resource "digitalocean_droplet" "ss" {
  image = "${var.image}"
  name = "${var.hostname}"
  region = "${var.zone}"
  size = "${var.memory}"

  ssh_keys = [
    "${digitalocean_ssh_key.root.id}"]
}

# 防火墙及规则
resource "digitalocean_firewall" "ss" {
  name = "firewall"

  droplet_ids = [
    "${digitalocean_droplet.ss.id}"]

  inbound_rule = [
    {
      protocol = "tcp"
      port_range = "22"
      source_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
    {
      protocol = "tcp"
      port_range = "80"
      source_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
    {
      protocol = "tcp"
      port_range = "443"
      source_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
    {
      protocol = "tcp"
      port_range = "12345"
      source_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
    {
      protocol = "tcp"
      port_range = "30010"
      source_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
  ]

  outbound_rule = [
    {
      protocol = "tcp"
      port_range = "1-65535"
      destination_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
    {
      protocol = "udp"
      port_range = "1-65535"
      destination_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
    {
      protocol = "icmp"
      port_range = "1-65535"
      destination_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
  ]
}
