
variable "prefix" {
  default = "tomcat"
}


resource "azurerm_resource_group" "tomcat_rg" {
  name     = "${var.prefix}-resources"
  location = "East US"
}

resource "azurerm_linux_virtual_machine" "tomcat_vm" {
  name                = "tomcat"
  resource_group_name = azurerm_resource_group.tomcat_rg.name
  location            = azurerm_resource_group.tomcat_rg.location
  size                = "Standard_DC1ds_v3"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.tomcat_net_int.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file(var.PUB_KEY)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

#Add a provisioner
    provisioner "file" {
    source      = "shell_scripts/installation.sh"           # Local path to installation.sh
    destination = "/tmp/installation.sh"             # Remote path where it will be saved
    }

    # Provisioner to upload launch_scripts.sh
    provisioner "file" {
    source      = "shell_scripts/launch_scripts.sh"         # Local path to launch_scripts.sh
    destination = "/tmp/launch_scripts.sh"           # Remote path where it will be saved
    }

    # Execute the scripts with remote-exec provisioner
    provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/installation.sh",               # Make installation.sh executable
        "chmod +x /tmp/launch_scripts.sh",             # Make launch_scripts.sh executable
        "sudo /tmp/installation.sh",                   # Execute installation.sh with sudo
        "sudo /tmp/launch_scripts.sh ${var.REPO_URL}"  # Execute launch_scripts.sh with REPO_URL argument
    ]
    }
    connection {
        type        = "ssh"
        user        = var.USER
        private_key = file(var.PRIV_KEY)
        host        = azurerm_public_ip.tomcat_pub_ip.ip_address
        }

}