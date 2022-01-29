# https://registry.terraform.io/providers/Trois-Six/sendgrid/latest/docs

resource "sendgrid_template" "template" {
  name       = var.name
  generation = "dynamic"
}

resource "sendgrid_template_version" "template_version" {
  name                   = var.tpl_name
  template_id            = sendgrid_template.template.id
  active                 = 1
  html_content           = "<%body%>"
  generate_plain_content = true
  subject                = "subject"
}
