terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.68.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_linux_virtual_machine" "acme-prod-compute-61c" {
  additional_capabilities {
    ultra_ssd_enabled = false
  }
  admin_username = "azureuser"
  boot_diagnostics {
  }
  computer_name              = "acme-prod-compute"
  encryption_at_host_enabled = false
  location                   = "eastus"
  name                       = "acme-prod-compute"
  network_interface_ids      = ["/subscriptions/d378a515-98e2-4a88-8992-bb194eeeebb2/resourceGroups/Acme-Azure-Prod/providers/Microsoft.Network/networkInterfaces/acme-prod-compute282_z1"]
  os_disk {
    caching                   = "ReadWrite"
    disk_size_gb              = 30
    name                      = "acme-prod-compute_OsDisk_1_7625aed452544927864b193ac465b195"
    storage_account_type      = "Premium_LRS"
    write_accelerator_enabled = false
  }
  resource_group_name = "acme-azure-prod"
  secure_boot_enabled = true
  size                = "Standard_B1ls"
  source_image_reference {
    offer     = "debian-11"
    publisher = "debian"
    sku       = "11-gen2"
    version   = "latest"
  }
  tags = {
    app = "acme-prod"
  }
  vtpm_enabled = true
  zone         = "1"
    lifecycle {
        ignore_changes = [
            # Ignore changes to tags, e.g. because a management agent
            # updates these based on some ruleset managed elsewhere.
            admin_ssh_key,
        ]
    }
}

resource "azurerm_storage_account" "acmeprodstore-0e2" {
  access_tier              = "Hot"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  blob_properties {
    change_feed_enabled      = false
    last_access_time_enabled = false
    versioning_enabled       = false
  }
  cross_tenant_replication_enabled = false
  location                         = "eastus"
  name                             = "acmeprodstore"
  network_rules {
    bypass         = ["AzureServices"]
    default_action = "Allow"
  }
  queue_properties {
    hour_metrics {
      enabled               = true
      include_apis          = true
      retention_policy_days = 7
      version               = "1.0"
    }
    logging {
      delete  = false
      read    = false
      version = "1.0"
      write   = false
    }
    minute_metrics {
      enabled      = false
      include_apis = false
      version      = "1.0"
    }
  }
  resource_group_name = "acme-azure-prod"
  tags = {
    app = "acme-prod"
  }
}

resource "azurerm_virtual_network" "acme-prod-compute-vnet-a42" {
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  name                = "acme-prod-compute-vnet"
  resource_group_name = "acme-azure-prod"
  subnet {
    address_prefix = "10.0.0.0/24"
    name           = "default"
  }
  tags = {
    app = "acme-prod"
  }
}

resource "azurerm_cosmosdb_account" "acme-prod-db-7e8" {
  analytical_storage {
    schema_type = "WellDefined"
  }
  backup {
    interval_in_minutes = 240
    retention_in_hours  = 8
    storage_redundancy  = "Local"
    type                = "Periodic"
  }
  capabilities {
    name = "EnableServerless"
  }
  capacity {
    total_throughput_limit = 4000
  }
  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }
  geo_location {
    location           = "eastus2"
    zone_redundant     = false
    failover_priority  = 0
  }
  location            = "eastus2"
  name                = "acme-prod-db"
  offer_type          = "Standard"
  resource_group_name = "acme-azure-prod"
  tags = {
    app                     = "acme-prod"
    defaultExperience       = "Core (SQL)"
    hidden-cosmos-mmspecial = ""
  }
}

resource "azurerm_network_security_group" "acme-prod-compute-nsg-01e" {
  location            = "eastus"
  name                = "acme-prod-compute-nsg"
  resource_group_name = "acme-azure-prod"
  security_rule {
    access                     = "Allow"
    destination_address_prefix = "*"
    destination_port_range     = "22"
    direction                  = "Inbound"
    name                       = "SSH"
    priority                   = 300
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }
  tags = {
    app = "acme-prod"
  }
}

resource "azurerm_resource_group" "acme-azure-prod-7d9" {
  location = "eastus"
  name     = "Acme-Azure-Prod"
  tags = {
    app = "acme-prod"
  }
}

