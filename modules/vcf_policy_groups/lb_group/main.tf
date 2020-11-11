locals {
  member_paths = [ for key, value in var.condition: (data.nsxt_policy_group.member_groups[key]).path]
}

data "nsxt_policy_group" "member_groups" {
  for_each = {
    for key, value in var.condition: key => value
  }
  display_name = each.value
}



resource "nsxt_policy_group" "groups" {
  depends_on = [
    data.nsxt_policy_group.member_groups
  ]
  display_name = var.group
  criteria {
    path_expression {
      member_paths = local.member_paths
    }
  }
}