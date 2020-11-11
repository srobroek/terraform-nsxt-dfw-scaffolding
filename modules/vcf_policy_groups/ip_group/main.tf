
resource "nsxt_policy_group" "groups" {

  display_name = var.group
  criteria {
    ipaddress_expression {
      ip_addresses = var.condition
    }
  }
}


