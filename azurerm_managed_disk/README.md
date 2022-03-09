
### Module info
---

* `storage_account_type` Azure Ultra Disk Storage is only available in a region that support availability zones and can only enabled on the following VM series: ESv3, DSv3, FSv3, LSv2, M and Mv2. For more information see the Azure Ultra Disk Storage
    https://docs.microsoft.com/en-us/azure/virtual-machines/windows/disks-enable-ultra-ssd
* `disk_encryption_set_id` The Disk Encryption Set must have the Reader Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault. Disk Encryption Sets are in Public Preview in a limited set of regions
* `disk_size_gb` Changing this value is disruptive if the disk is attached to a Virtual Machine. The VM will be shut down and de-allocated as required by Azure to action the change. Terraform will attempt to start the machine again after the update if it was in a running state when the apply was started.
* `tier`Changing this value is disruptive if the disk is attached to a Virtual Machine. The VM will be shut down and de-allocated as required by Azure to action the change. Terraform will attempt to start the machine again after the update if it was in a running state when the apply was started.
* `max_shares` Premium SSD maxShares limit: P15 and P20 disks: 2. P30,P40,P50 disks: 5. P60,P70,P80 disks: 10. For ultra disks the max_shares minimum value is 1 and the maximum is 5.