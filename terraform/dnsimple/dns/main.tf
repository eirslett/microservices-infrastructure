variable control_ips {}
variable worker_ips {}
variable frontend_edge_ips { default = "" }
variable control_count {}
variable worker_count {}
variable frontend_edge_count { default = 0 }
variable domain {}
variable short_name {}

resource "dnsimple_record" "dns-control" {
  count = "${var.control_count}"
  domain = "${var.domain}"
  value = "${element(split(\",\", var.control_ips), count.index)}"
  name = "${var.short_name}-control-${format("%02d", count.index+1)}"
  type = "A"
  ttl = 60
}

resource "dnsimple_record" "dns-worker" {
  count = "${var.worker_count}"
  domain = "${var.domain}"
  name = "${var.short_name}-worker-${format("%03d", count.index+1)}"
  value = "${element(split(\",\", var.worker_ips), count.index)}"
  type = "A"
  ttl = 60
}

resource "dnsimple_record" "dns-frontend-edge" {
  count = "${var.frontend_edge_count}"
  domain = "${var.domain}"
  name = "${var.short_name}-frontend-edge-${format("%02d", count.index+1)}"
  type = "A"
  ttl = 60
  value = "${element(split(\",\", var.frontend_edge_ips), count.index)}"
}

resource "dnsimple_record" "dns-worker-haproxy" {
  count = "${var.worker_count}"
  domain = "${var.domain}"
  name = "*.${var.short_name}-lb"
  value = "${element(split(\",\", var.worker_ips), count.index)}"
  type = "A"
  ttl = 60
}
