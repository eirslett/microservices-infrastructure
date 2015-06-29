provider "digitalocean" {
  token = ""
}

module "do-keypair" {
	source = "./terraform/digitalocean/keypair"
  public_key_filename = "~/.ssh/id_rsa.pub"
}

module "do-hosts" {
  source = "./terraform/digitalocean/hosts"
  ssh_key = "${module.do-keypair.keypair_id}"
  domain = "example.com"
  region_name = "nyc3" # this must be a region with metadata support
  control_count = 1
  worker_count = 3
}
