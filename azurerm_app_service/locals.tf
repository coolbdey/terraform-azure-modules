locals {
  created_date             = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
  start_time               = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
  created_datetimeUTC      = formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp())
  sa_containers            = []        #["${var.name}-http", "logs/${var.name}-application", "backups/${var.name}", "events/${var.name}"]
  sa_container_access_type = "private" # blob | container | private

  default_documents = sort(["index.html", "index.js", "default.html", "default.aspx", "hostingstart.htm", "iisstart.htm"])
  #  linux_fx_version = "DOTNETCORE|3.1"
  app_kinds = {
    "windows" = {
      dotnet_framework_version = null # "DOTNETCORE|3.1" # Defaultis v4.0
      linux_fx_version         = null
      windows_fx_version       = var.fx_version
    }
    "linux" = {
      dotnet_framework_version = null # ""
      linux_fx_version         = var.fx_version
      windows_fx_version       = null
    }
  }
  dotnet_framework_version = local.app_kinds[var.app_kind].dotnet_framework_version
  linux_fx_version         = local.app_kinds[var.app_kind].linux_fx_version
  windows_fx_version       = local.app_kinds[var.app_kind].windows_fx_version
}
