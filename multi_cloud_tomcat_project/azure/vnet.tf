
resource "azurerm_virtual_network" "tomcat_vnet" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.tomcat_rg.location
  resource_group_name = azurerm_resource_group.tomcat_rg.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.tomcat_rg.name
  virtual_network_name = azurerm_virtual_network.tomcat_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "tomcat_pub_ip" {
  name                = "tomcat-ip"
  location            = azurerm_resource_group.tomcat_rg.location
  resource_group_name = azurerm_resource_group.tomcat_rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "tomcat_net_int" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.tomcat_rg.location
  resource_group_name = azurerm_resource_group.tomcat_rg.name

  ip_configuration {
    name                          = "configuration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.tomcat_pub_ip.id
  }
}

resource "azurerm_network_security_group" "tomcat_nsg" {
  name                = "tomcat-nsg"
  location            = azurerm_resource_group.tomcat_rg.location
  resource_group_name = azurerm_resource_group.tomcat_rg.name

  security_rule {
    name                       = "allow-ssh"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    priority                   = 100
  }

  security_rule {
    name                       = "allow-http"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    priority                   = 200
  }
}

# Attach the NSG to the network interface
resource "azurerm_network_interface_security_group_association" "tomcat_nic_nsg" {
  network_interface_id      = azurerm_network_interface.tomcat_net_int.id
  network_security_group_id = azurerm_network_security_group.tomcat_nsg.id
}