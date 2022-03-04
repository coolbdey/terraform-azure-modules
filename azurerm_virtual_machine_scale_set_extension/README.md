This resource is not intended to be used with the azurerm_virtual_machine_scale_set resource - instead it's intended for this to be used with the azurerm_linux_virtual_machine_scale_set and azurerm_windows_virtual_machine_scale_set resources.


Note:
The Publisher and Type of Virtual Machine Scale Set Extensions can be found using the Azure CLI, via:

az vmss extension image list --location westus -o table