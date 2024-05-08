resource "azurerm_managed_disk" "acme-prod-compute_osdisk_1_7625aed452544927864b193ac465b195-3c2" {
  create_option              = "FromImage"
  disk_iops_read_write       = 120
  disk_mbps_read_write       = 25
  disk_size_gb               = 30
  hyper_v_generation         = "V2"
  image_reference_id         = "/Subscriptions/d378a515-98e2-4a88-8992-bb194eeeebb2/Providers/Microsoft.Compute/Locations/eastus/Publishers/debian/ArtifactTypes/VMImage/Offers/debian-11/Skus/11-gen2/Versions/0.20240211.1654"
  location                   = "eastus"
  name                       = "acme-prod-compute_osdisk_1_7625aed452544927864b193ac465b195"
  on_demand_bursting_enabled = false
  os_type                    = "Linux"
  resource_group_name        = "acme-azure-prod"
  storage_account_type       = "Premium_LRS"
  tags = {
    app = "acme-prod"
  }
  tier                   = "P4"
  trusted_launch_enabled = true
  zone                   = "1"
}


resource "azurerm_linux_virtual_machine" "acme-prod-compute-61c" {
  additional_capabilities {
    ultra_ssd_enabled = false
  }
  admin_ssh_key {
    public_key = "ssh-rsa REDACTED-BY-FIREFLY:d92815ceac74fe5b1aaa28fa744bd57ad6bd2680db582c689e5b0d502e60513c:sha256 generated-by-azure"
    username   = "azureuser"
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


resource "azurerm_network_interface" "acme-prod-compute282_z1-7be" {
  ip_configuration {
    name                          = "ipconfig1"
    primary                       = true
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = "/subscriptions/d378a515-98e2-4a88-8992-bb194eeeebb2/resourceGroups/Acme-Azure-Prod/providers/Microsoft.Network/publicIPAddresses/acme-prod-compute-ip"
    subnet_id                     = "/subscriptions/d378a515-98e2-4a88-8992-bb194eeeebb2/resourceGroups/Acme-Azure-Prod/providers/Microsoft.Network/virtualNetworks/acme-prod-compute-vnet/subnets/default"
  }
  location            = "eastus"
  name                = "acme-prod-compute282_z1"
  resource_group_name = "acme-azure-prod"
  tags = {
    app = "acme-prod"
  }
}


resource "azurerm_network_security_group" "acme-prod-compute-nsg-aef" {
  location            = "eastus"
  name                = "acme-prod-compute-nsg"
  resource_group_name = "acme-azure-prod"
  security_rule {
    access                     = "Deny"
    destination_address_prefix = "*"
    destination_port_range     = "3389"
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


resource "azurerm_public_ip" "acme-prod-public-access-c2f" {
  allocation_method   = "Dynamic"
  location            = "eastus"
  name                = "acme-prod-public-access"
  resource_group_name = "acme-azure-prod"
}


resource "azurerm_resource_group" "Acme-Azure-Prod-b6c" {
  location = "eastus"
  name     = "Acme-Azure-Prod"
  tags = {
    app = "acme-prod"
  }
}


resource "azurerm_public_ip" "acme-prod-compute-ip-795" {
  allocation_method   = "Static"
  location            = "eastus"
  name                = "acme-prod-compute-ip"
  resource_group_name = "acme-azure-prod"
  sku                 = "Standard"
  tags = {
    app = "acme-prod"
  }
  zones = ["1"]
}

