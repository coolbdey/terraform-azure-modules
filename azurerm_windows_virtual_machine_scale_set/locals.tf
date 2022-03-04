locals {
  source_image = {
    "W2019" = {
      offer     = "WindowsServer"
      publisher = "MicrosoftWindowsServer"
      sku       = "2019-Datacenter"
      version   = "latest"
    }
    "W2016" = {
      offer     = "WindowsServer"
      publisher = "MicrosoftWindowsServer"
      sku       = "2016-Datacenter"
      version   = "latest"
    }
    "W2012R2" = {
      offer     = "WindowsServer"
      publisher = "MicrosoftWindowsServer"
      sku       = "2012-R2-Datacenter"
      version   = "latest"
    }
    "W2012" = {
      offer     = "WindowsServer"
      publisher = "MicrosoftWindowsServer"
      sku       = "2012-Datacenter"
      version   = "latest"
    }
    "W2008R2" = {
      offer     = "WindowsServer"
      publisher = "MicrosoftWindowsServer"
      sku       = "2008-R2-SP1"
      version   = "latest"
    }
  }
}