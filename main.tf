terraform {
  # Adding required version because import blocks support is in 1.5 
  required_version = ">=1.5"
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
    }
  }
}

/* Provider configuration with signature-based authentication. */

provider "aci" {
  # cisco-aci user name (local User)
  username = var.APIC_USERNAME
  # cisco-aci signature based cert
  private_key = "tfcert.key"
  cert_name   = "tfcert.crt"
  # cisco-aci url
  url      = var.APIC_URL
  insecure = true
}
