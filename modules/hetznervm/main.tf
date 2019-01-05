
# module input parameters
variable "cluster" {}
variable "node" {}
variable "server_type" {}
variable "image" {}
variable "datacenter" {}

locals {
	hostname = "${var.cluster}-${var.node}.hz-${var.datacenter}.fn61.net"
	ssh_key = "joonas2018"
}

resource "hcloud_server" "vm" {
  name = "${local.hostname}"
  datacenter = "${var.datacenter}"
  image = "${var.image}"
  server_type = "${var.server_type}"
  ssh_keys = ["${local.ssh_key}"]
}

resource "cloudflare_record" "hostname" {
	domain = "fn61.net"
	name   = "${local.hostname}"
	value  = "${hcloud_server.vm.ipv4_address}"
	type   = "A"
	ttl    = 3600
}

output "ipv4" {
	value = "${hcloud_server.vm.ipv4_address}"
}
