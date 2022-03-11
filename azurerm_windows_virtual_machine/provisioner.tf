provisioner "file" {
  count = length(var.provisioner_file)

  source      = var.provisioner_file.source
  destination = var.provisioner_file.destination

  connection {
    type     = "winrm"
    user     = var.admin_user
    password = var.admin_pass
    host     = var.name
    port = 5985
    timeout = "30s"
  }
}