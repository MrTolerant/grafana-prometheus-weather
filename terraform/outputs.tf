output "ip" {
  description = "piblic ip address"
  value = azurerm_public_ip.main.ip_address
}
output "domain" {
  description = "public domain"
  value = azurerm_public_ip.main.fqdn
}
