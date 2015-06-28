# input variables
variable control_count { default = 1 }
variable control_size { default = "4gb" }
variable domain { default = "example.com" }
variable datacenter { default = "mi" }
variable image_name { default = "centos-7-0-x64" }
variable region_name { default = "nyc3" }
variable short_name { default = "mi" }
variable ssh_key { }
variable worker_count { default = 3 }
variable worker_size { default = "4gb" }

# create resources
resource "digitalocean_droplet" "control" {
  count = "${var.control_count}"
  name = "control-${count.index}.${var.short_name}.${var.domain}"
  image = "${var.image_name}"
  region = "${var.region_name}"
  size = "${var.control_size}"
  ssh_keys = ["${var.ssh_key}"]
  user_data = "{\"role\":\"control\",\"dc\":\"${var.datacenter}\"}"
}

resource "digitalocean_droplet" "worker" {
  count = "${var.worker_count}"
  name = "worker-${count.index}.${var.short_name}.${var.domain}"
  image = "${var.image_name}"
  region = "${var.region_name}"
  size = "${var.worker_size}"
  ssh_keys = ["${var.ssh_key}"]
  user_data = "{\"role\":\"worker\",\"dc\":\"${var.datacenter}\"}"
}
