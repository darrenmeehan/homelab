resource "proxmox_vm_qemu" "certs_server" {
  desc = "Private PKI"
  count       = 1
  name        = "certs-${count.index + 1}"
  target_node = "pve"
  clone = "ubuntu-2204-template"
  agent    = 1
  os_type  = "cloud-init"
  cores    = 2
  sockets  = 1
  cpu      = "host"
  memory   = 2048
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot     = 0
    size     = "10G"
    type     = "scsi"
    storage  = "local-lvm"
    iothread = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
  # not sure exactly what this is for. presumably something about MAC addresses and ignore network changes during the life of the VM
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=dhcp"
  # sshkeys set using variables. the variable contains the text of the key.
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

resource "proxmox_vm_qemu" "octoprint_server" {
  desc = "3D Printing Management"
  count       = 1
  name        = "octoprint"
  target_node = "pve"
  clone = "ubuntu-2204-template"
  agent    = 1
  os_type  = "cloud-init"
  cores    = 2
  sockets  = 1
  cpu      = "host"
  memory   = 2048
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot     = 0
    size     = "10G"
    type     = "scsi"
    storage  = "local-lvm"
    iothread = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
  # not sure exactly what this is for. presumably something about MAC addresses and ignore network changes during the life of the VM
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=dhcp"
  # sshkeys set using variables. the variable contains the text of the key.
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}


resource "proxmox_vm_qemu" "dev_server" {
  desc = "Rust development machine"
  count       = 1
  name        = "dev-${count.index + 1}"
  target_node = "pve"
  clone = "ubuntu-2204-template"
  agent    = 1
  os_type  = "cloud-init"
  cores    = 4
  sockets  = 2
  cpu      = "host"
  memory   = 8192
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot     = 0
    size     = "10G"
    type     = "scsi"
    storage  = "local-lvm"
    iothread = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
  # not sure exactly what this is for. presumably something about MAC addresses and ignore network changes during the life of the VM
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=dhcp"
  # sshkeys set using variables. the variable contains the text of the key.
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}
