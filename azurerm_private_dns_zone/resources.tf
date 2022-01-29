# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone
resource "azurerm_private_dns_zone" "dns" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.dns_name
  resource_group_name = data.azurerm_resource_group.rg.name

  soa_record {
    email = var.email_contact
    ttl   = var.ttl
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "vlink" {
  depends_on = [azurerm_private_dns_zone.dns]
  count      = var.vnet_enabled ? 1 : 0

  name                  = replace("${var.dns_name}-vlink", ".", "-")
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = var.vnet_id
  registration_enabled  = var.vnet_registration_enabled
}

resource "azurerm_private_dns_a_record" "a" {
  depends_on = [azurerm_private_dns_zone.dns]
  count      = length(var.dns_a_records)

  name                = var.dns_a_records[count.index].name
  zone_name           = azurerm_private_dns_zone.dns.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = var.dns_a_records[count.index].ttl     # 300
  records             = var.dns_a_records[count.index].records #["10.0.180.17"]
}

resource "azurerm_private_dns_cname_record" "cname" {
  depends_on = [azurerm_private_dns_zone.dns]
  count      = length(var.dns_cname_records)

  name                = var.dns_cname_records[count.index].name
  zone_name           = azurerm_private_dns_zone.dns.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = var.dns_cname_records[count.index].ttl    # 300
  record              = var.dns_cname_records[count.index].record #"contoso.com"
}

resource "azurerm_private_dns_txt_record" "txt" {
  depends_on = [azurerm_private_dns_zone.dns]
  count      = length(var.dns_txt_records)

  name                = var.dns_txt_records[count.index].name
  resource_group_name = data.azurerm_resource_group.rg.name
  zone_name           = azurerm_private_dns_zone.dns.name
  ttl                 = var.dns_txt_records[count.index].ttl # 300

  record {
    value = var.dns_txt_records[count.index].value # "v=spf1 mx ~all"
  }
}
