### Module info
---

* `public_ip_prefix_id` This functionality is in Preview and must be opted into via az feature register --namespace Microsoft.Network --name AllowBringYourOwnPublicIpAddress and then az provider register -n Microsoft.Network.
* `disk_encryption_set_id` The Disk Encryption Set must have the Reader Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault