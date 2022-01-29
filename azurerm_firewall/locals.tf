locals {
  # (Optional) The operation mode for threat intelligence-based filtering. Possible values are: Off, Alert,Deny and ""(empty string). Defaults to Alert.
  threat_intel_mode = var.tier_name == "AZFW_Hub" ? "" : "Alert"
}