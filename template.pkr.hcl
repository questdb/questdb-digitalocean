variable "application_name" {
  type        = string
  default     = "QuestDB"
  description = "Name of the application to display on DigitalOcean."
}

variable "token" {
  type        = string
  default     = "${env("DIGITALOCEAN_TOKEN")}"
  description = "DigitalOcean API token used to create droplets."
}

variable "image_id" {
  type        = string
  default     = "ubuntu-20-04-x64"
  description = "DigitalOcean linux image ID."
}

variable "questdb_version" {
  type        = string
  default     = "latest"
  description = "Version number of the desired QuestDB binary."
}

variable "image_name" {
  type        = string
  default     = "questdb-snapshot-{{timestamp}}"
  description = "Name of the snapshot created on DigitalOcean."
}

source "digitalocean" "default" {
  api_token     = "${var.token}"
  image         = "${var.image_id}"
  region        = "nyc3"
  size          = "s-1vcpu-1gb"
  snapshot_name = "${var.image_name}"
  ssh_username  = "root"
}

build {
  sources = ["source.digitalocean.default"]

  provisioner "file" {
    destination = "/etc/"
    source      = "files/etc/"
  }

  provisioner "file" {
    destination = "/home/"
    source      = "files/home/"
  }

  provisioner "file" {
    destination = "/var/"
    source      = "files/var/"
  }

  # Setup instance configuration
  provisioner "shell" {
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive"
    ]
    scripts = [
      "scripts/01-setup.sh",
      "scripts/02-firewall.sh",
      "scripts/03-logrotate.sh",
    ]
  }

  # Install QuestDB
  provisioner "shell" {
    environment_vars = [
      "QUESTDB_VERSION=${var.questdb_version}",
      "DEBIAN_FRONTEND=noninteractive"
    ]
    scripts = [
      "scripts/04-install-questdb.sh",
    ]
  }

  # Cleanup and validate instance
  provisioner "shell" {
    environment_vars = [
      "application_name=${var.application_name}",
      "DEBIAN_FRONTEND=noninteractive"
    ]
    scripts = [
      "scripts/89-cleanup-logs.sh",
      "scripts/90-cleanup.sh",
      "scripts/99-img-check.sh"
    ]
  }
}
