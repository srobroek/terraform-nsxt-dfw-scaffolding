

locals {
  member_paths = [ for key, value in var.condition: (data.nsxt_policy_segment_realization.infra-segments[key]).path]
}

data "nsxt_policy_segment_realization" "infra-segments" {
  for_each = {
    for key, value in var.condition: key => value
  }
  path = "/infra/segments/${each.value}"
}



resource "nsxt_policy_group" "groups" {

  display_name = var.group
  criteria {
    path_expression {
      member_paths = local.member_paths
    }
  }
}


