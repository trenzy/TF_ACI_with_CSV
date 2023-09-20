/* 
  Create a Tenant, VRF, Application Profile, EPG and BD
  using data read in from csvdecode in locals.tf. We 
  also use each.key for each of the dependences for the
  objects.
*/

resource "aci_application_profile" "ap_csv_example" {
  for_each    = local.test
  tenant_dn   = aci_tenant.tenant_csv_example[each.key].id
  name        = each.value.ap
  description = "CSV with Terraform"
  annotation  = "orchestrator:terraform"
}

resource "aci_tenant" "tenant_csv_example" {
  for_each = local.test
  #instance_type = each.value.instance_type
  name        = each.value.tenant
  description = "CSV with Terraform"
  annotation  = "orchestrator:terraform"
}

resource "aci_vrf" "vrf_csv_example" {
  for_each    = local.test
  tenant_dn   = aci_tenant.tenant_csv_example[each.key].id
  name        = each.value.vrf
  description = "CSV with terraform"
  annotation  = "orchestrator:terraform"
}

resource "aci_application_epg" "epg_csv_example" {
  for_each               = local.test
  application_profile_dn = aci_application_profile.ap_csv_example[each.key].id
  name                   = each.value.epg
  description            = "CSV with terraform"
  annotation             = "orchestrator:terraform"
  relation_fv_rs_bd      = aci_bridge_domain.bd_csv_example[each.key].id
}

/* 
  Though we are configuring the Bridge Domains here and read in infomation such as 
  name, we are making a lot of assumptions on the other configurations here. This 
  could almost be it's own CSV since there are so many configuration options for BDs.

*/   

resource "aci_bridge_domain" "bd_csv_example" {
  for_each                  = local.test
  tenant_dn                 = aci_tenant.tenant_csv_example[each.key].id
  description               = "CSV with terraform"
  annotation                = "orchestrator:terraform"
  name                      = each.value.bd-name
  arp_flood                 = "yes"
  ep_move_detect_mode       = "garp"
  ip_learning               = "yes"
  limit_ip_learn_to_subnets = "yes"
  bridge_domain_type        = "regular"
  unicast_route             = "yes"
  unk_mac_ucast_act         = "flood"
  unk_mcast_act             = "flood"
  v6unk_mcast_act           = "flood"
}
