vms = {
  vm1 = {
    nic_name    = "nic-frontend-vm"
    location    = "centralindia"
    rg_name     = "rg-mahesh-dev"
    vnet_name   = "vnet-mahesh-dev"
    subnet_name = "frontend-subnet"
    pip_name    = "pip-mahesh-dev-01"
    vm_name     = "frontend-vm"
    size        = "Standard_F2"
    kv_name     = "kv-mahesh-dev"
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
  vm2 = {
    nic_name    = "nic-backend-vm"
    location    = "centralindia"
    rg_name     = "rg-mahesh-dev"
    vnet_name   = "vnet-mahesh-dev"
    subnet_name = "backend-subnet"
    pip_name    = "pip-mahesh-dev-02"
    vm_name     = "backend-vm"
    size        = "Standard_F2"
    kv_name     = "kv-mahesh-dev"
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
}

rgs = {
  rg1 = {
    name       = "rg-mahesh-dev"
    location   = "centralindia"
    managed_by = "Terraform"
    tags = {
      env = "dev"
    }
  }
}

networks = {
  vnet1 = {
    name                = "vnet-mahesh-dev"
    location            = "centralindia"
    resource_group_name = "rg-mahesh-dev"
    address_space       = ["10.0.0.0/16"]
    tags = {
      environment = "dev"
    }
    subnets = [
      {
        name             = "frontend-subnet"
        address_prefixes = ["10.0.1.0/24"]
      },
      {
        name             = "backend-subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
    ]
  }
}

public_ips = {
  app1 = {
    name                = "pip-mahesh-dev-01"
    resource_group_name = "rg-mahesh-dev"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      app = "frontend"
      env = "prod"
    }
  }
  app2 = {
    name                = "pip-mahesh-dev-02"
    resource_group_name = "rg-mahesh-dev"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      app = "frontend"
      env = "prod"
    }
  }
}


key_vaults = {
  kv1 = {
    kv_name  = "kv-mahesh-dev"
    location = "centralindia"
    rg_name  = "rg-mahesh-dev"
  }
}
