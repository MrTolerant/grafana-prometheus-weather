output "ip" {
  description = "piblic ip address"
  value = resource.azurerm_public_ip.main.ip_address
}
output "domain" {
  description = "public domain"
  value = resource.azurerm_public_ip.main.fqdn
}
