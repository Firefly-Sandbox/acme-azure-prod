import {
  to = azurerm_public_ip.acme-prod-public-access-c2f
  id = "/subscriptions/d378a515-98e2-4a88-8992-bb194eeeebb2/resourceGroups/acme-azure-prod/providers/Microsoft.Network/publicIPAddresses/acme-prod-public-access"
}


resource "azurerm_public_ip" "acme-prod-public-access-c2f" {
  allocation_method   = "Dynamic"
  location            = "eastus"
  name                = "acme-prod-public-access"
  resource_group_name = "acme-azure-prod"
}

