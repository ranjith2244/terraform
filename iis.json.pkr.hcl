variable "client_id" {
   type = string
}

variable "client_secret" {
  type = string
}

variable "rg" {
  type = string
}

variable "tenant_id" {
   type = string
}

variable "subscription_id" {
   type = string
}

variable "img" {
   type = string
}

source "azure-arm" "autogenerated_1" {
  azure_tags = {
    dept = "Engineering"
    task = "Image deployment"
  }
  build_resource_group_name         = var.rg
  client_id                         = var.client_id
  client_secret                     = var.client_secret
  communicator                      = "winrm"
  image_offer                       = "WindowsServer"
  image_publisher                   = "MicrosoftWindowsServer"
  image_sku                         = "2016-Datacenter"
  managed_image_name                = var.img
  managed_image_resource_group_name = var.rg
  os_type                           = "Windows"
  subscription_id                   = var.subscription_id
  tenant_id                         = var.tenant_id
  vm_size                           = "Standard_D2_v2"
  winrm_insecure                    = true
  winrm_timeout                     = "5m"
  winrm_use_ssl                     = true
  winrm_username                    = "packer"
}

build {
  sources = ["source.azure-arm.autogenerated_1"]

  provisioner "powershell" {
    inline = ["Add-WindowsFeature Web-Server", "while ((Get-Service RdAgent).Status -ne 'Running') { Start-Sleep -s 5 }", "while ((Get-Service WindowsAzureGuestAgent).Status -ne 'Running') { Start-Sleep -s 5 }", "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit", "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"]
  }

}
