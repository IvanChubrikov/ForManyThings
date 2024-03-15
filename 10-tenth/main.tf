resource "proxmox_vm_qemu" "prxmx_server" {
  name        = "proxmox-vm"
  target_node = var.proxmox_host

  clone = var.template_name
  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 1024

  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }
   
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}
