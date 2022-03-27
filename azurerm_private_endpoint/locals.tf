locals {
  location              = data.azurerm_resource_group.rg.location
  psc_name              = var.psc_name == null ? "${var.name}-psc" : var.psc_name
  psc_pcr_id            = var.psc_pcr_id == null && var.psc_pcr_alias == null ? null : var.psc_pcr_id
  psc_pcr_alias         = var.psc_pcr_id == null && var.psc_pcr_alias == null ? "${var.name}-psc.${uuid()}.${local.location}.azure.privatelinkservice" : var.psc_pcr_alias
  psc_subresource_names = var.psc_subresource_names
  psc_request_message   = var.psc_ismanual ? var.psc_request_message : null

}