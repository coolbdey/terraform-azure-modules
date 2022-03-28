resource "null_resource" "provisioners" {
  depends_on = [azurerm_linux_virtual_machine_scale_set.vm]
  count      = length(var.provisioners)

  connection {
    type             = "ssh"
    bastion_user     = var.provisioners[count.index].connection.bastion_user == null ? var.admin_user : var.provisioners[count.index].connection.bastion_user
    bastion_password = var.provisioners[count.index].connection.bastion_password == null ? var.admin_pass : var.provisioners[count.index].connection.bastion_password
    bastion_host     = var.provisioners[count.index].connection.bastion_host
    host             = var.provisioners[count.index].connection.host == null ? var.name : var.provisioners[count.index].connection.host
    port             = 22
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