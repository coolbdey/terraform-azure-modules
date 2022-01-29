///////////////////////////////////////////////////////////////////////
//////////// OBJECT REPLICATION

resource "azurerm_storage_object_replication" "repl" {
  depends_on = [data.azurerm_storage_account.sa, data.azurerm_storage_account.sa_dst]
  count      = length(var.containers) > 0 ? 1 : 0

  source_storage_account_id      = data.azurerm_storage_account.sa.id
  destination_storage_account_id = data.azurerm_storage_account.sa_dst[count.index].id

  dynamic "rules" {
    for_each = var.containers
    iterator = each

    content {
      source_container_name      = each.value.src_container
      destination_container_name = each.value.dst_container
    }
  }
}
