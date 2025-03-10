terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.10"
    }
  }

  cloud {
    organization = "home-network"

    workspaces {
      name = "main"
    }
  }
}

provider "proxmox" {
  pm_debug        = true
  pm_log_enable   = true
  pm_log_file     = "terraform-plugin-proxmox.log"
  pm_api_url      = "https://${var.proxmox_hostname}:8006/api2/json"
  pm_tls_insecure = true
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}
