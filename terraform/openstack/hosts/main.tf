variable auth_url { }
variable datacenter { default = "openstack" }
variable tenant_id { }
variable tenant_name { }
variable control_flavor_name { }
variable resource_flavor_name { }
variable net_id { }
variable keypair_name { }
variable image_name { }
variable control_count {}
variable worker_count {}
variable security_groups { default = "default" }
variable short_name { default = "mi" }
variable long_name { default = "microservices-infrastructure" }
variable domain { default = "example.com" }
variable ssh_user { default = "centos" }

provider "openstack" {
  auth_url = "${ var.auth_url }"
  tenant_id	= "${ var.tenant_id }"
  tenant_name	= "${ var.tenant_name }"
}

resource "openstack_compute_instance_v2" "control" {
  name = "control-${count.index}.${var.short_name}.${var.domain}"
  key_pair = "${ var.keypair_name }"
  image_name = "${ var.image_name }"
  flavor_name = "${ var.control_flavor_name }"
  security_groups = [ "${ var.security_groups }" ]
  network = { uuid  = "${ var.net_id }" }
  metadata = {
     dc = "${var.datacenter}"
     role = "control"
     ssh_user = "${ var.ssh_user }"
   }
  count = "${ var.control_count }"
}

resource "openstack_compute_instance_v2" "worker" {
  name = "worker-${count.index}.${var.short_name}.${var.domain}"
  key_pair = "${ var.keypair_name }"
  image_name = "${ var.image_name }"
  flavor_name = "${ var.resource_flavor_name }"
  security_groups = [ "${ var.security_groups }" ]
  network = { uuid = "${ var.net_id }" }
  metadata = {
    dc = "${var.datacenter}"
    role = "worker"
    ssh_user = "${ var.ssh_user }"
   }
  count = "${ var.worker_count }"
}

