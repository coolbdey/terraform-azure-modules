

### Module resources
---

* https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set
* 
### Module info
---

* `disk_encryption_set_id` The Disk Encryption Set must have the Reader Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault
* `disk_size_gb` If specified this must be equal to or larger than the size of the Image the VM Scale Set is based on. When creating a larger disk than exists in the image you'll need to repartition the disk to use the remaining space.
* `automatic_instance_repair` https://docs.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs
* VM Agent Scale Set
  https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents?view=azure-devops