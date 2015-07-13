# input variables
variable control_count { default = 1 }
variable control_size { default = "4gb" }
variable datacenter { default = "mi" }
variable domain { default = "example.com" }
variable image_name { default = "CENTOS_LATEST" }
variable region_name { default = "ams01" }
variable short_name { default = "mi" }
variable ssh_key { }
variable worker_count { default = 3 }
variable worker_size { default = "4096" }

# create resources
resource "softlayer_virtualserver" "control" {
  count = "${var.control_count}"
  name = "${var.short_name}-control-${format("%02d", count.index+1)}"
  image = "${var.image_name}"
  region = "${var.region_name}"
  ram = "${var.control_size}"
  cpu = 1
  ssh_keys = ["${var.ssh_key}"]
}

resource "softlayer_virtualserver" "worker" {
  count = "${var.worker_count}"
  name = "${var.short_name}-worker-${format("%03d", count.index+1)}"
  domain = "${var.domain}"
  image = "${var.image_name}"
  region = "${var.region_name}"
  ram = "${var.worker_size}"
  cpu = 1
  ssh_keys = ["${var.ssh_key}"]
}
