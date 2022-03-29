### Module info
---

* `allocation_method` Dynamic Public IP Addresses aren't allocated until they're assigned to a resource (such as a Virtual Machine or a Load Balancer) by design within Azure - [more information is available below.](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip#ip_address)
* `zones` vailability Zones are only supported with a [Standard SKU](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-ip-addresses-overview-arm#standard) and [in select regions](https://docs.microsoft.com/en-us/azure/availability-zones/az-overview) at this time. Standard SKU Public IP Addresses that do not specify a zone are zone redundant by default.