
# Create a Virtual Machine
resource "azurerm_virtual_machine" "main" {
  name                  = var.VM_NAME
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_B1ms"

  provisioner "file" {
    source      = "../docker/"
    destination = "/tmp/docker/"
  
    connection {
      agent    = false
      user     = var.VM_ADMIN
      password = var.SSH_PRIVATE
      host     = azurerm_public_ip.main.fqdn
    }
  }

  storage_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.VM_NAME}-OS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = 30
  }

  os_profile {
    computer_name  = var.VM_NAME
    admin_username = var.VM_ADMIN
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = var.DEFAULT_SSHKEY
      path     = "/home/azure-admin/.ssh/authorized_keys"
    }
  }

  tags = {
    environment = "test"
    deployment  = "terraform"
  }
}
