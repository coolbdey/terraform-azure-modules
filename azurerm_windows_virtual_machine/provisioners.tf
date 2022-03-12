resource "null_resource" "provisioners" {
  depends_on = [azurerm_windows_virtual_machine.wvm]
  count      = length(var.provisioners)

  connection {
    type             = "winrm"
    bastion_user     = var.provisioners[count.index].connection.bastion_user == null ? var.admin_user : var.provisioner.connection.bastion_user
    bastion_password = var.provisioners[count.index].connection.bastion_password == null ? var.admin_pass : var.provisioner.connection.bastion_password
    bastion_host     = var.provisioners[count.index].connection.bastion_host
    host             = var.provisioners[count.index].connection.host == null ? var.name : var.provisioners[count.index].connection.host
    port             = 5986
    user             = var.admin_user
    password         = var.admin_pass
    timeout          = "30s"
  }

  provisioner "file" {
    source      = var.provisioners[count.index].file.source
    destination = var.provisioners[count.index].file.destination
  }

  provisioner "remote-exec" {
    scripts = var.provisioners[count.index].scripts
  }

  provisioner "remote-exec" {
    script = var.provisioners[count.index].script
  }

  provisioner "remote-exec" {
    inline = var.provisioners[count.index].inline
  }
}