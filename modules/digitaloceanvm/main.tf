
# module input parameters
variable "node" {}
variable "image" {}
variable "size" {}
variable "cluster" {}
variable "region" {}

locals {
	hostname = "${var.cluster}-${var.node}.do-${var.region}.fn61.net"
	joonas2018_ssh_key_fingerprint = "d5:15:97:20:9d:f3:a1:27:97:d1:a6:ef:d5:e9:e2:4b"
}

resource "digitalocean_droplet" "vm" {
	image  = "${var.image}"
	name   = "${local.hostname}"
	region = "${var.region}"
	size   = "${var.size}"
	ssh_keys = ["${local.joonas2018_ssh_key_fingerprint}"]
}

resource "cloudflare_record" "hostname" {
	domain = "fn61.net"
	name   = "${local.hostname}"
	value  = "${digitalocean_droplet.vm.ipv4_address}"
	type   = "A"
	ttl    = 3600
}

output "ipv4" {
	value = "${digitalocean_droplet.vm.ipv4_address}"
}
