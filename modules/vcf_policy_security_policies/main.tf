# locals {
#   member_paths = [ for key, value in var.rules: (data.nsxt_policy_group.member_groups[key]).path]
# }

locals {
    scope_groups = flatten([ for group in var.rules: group["scope"]  ])
    source_groups = flatten([ for group in var.rules: group["source_groups"]  ])
    destination_groups = flatten([ for group in var.rules: group["destination_groups"]  ])

}

data "nsxt_policy_group" "scope_groups" {
  for_each = { for key, value in local.scope_groups: key => value if value != "Any"}
  display_name = each.value
}

data "nsxt_policy_group" "source_groups" {
  for_each = { for key, value in local.source_groups: key => value if value != "Any"}
  display_name = each.value
}

data "nsxt_policy_group" "destination_groups" {
  for_each = { for key, value in local.destination_groups: key => value if value != "Any"}
  display_name = each.value
}


# data "nsxt_policy_group" "destination_groups" {
#   for_each = { for key, value in local.data_groups: key => value}
#   display_name = each.value
# }

resource "nsxt_policy_security_policy" "security_policy" {
  display_name = var.display_name
  category = var.policy["category"]
  stateful = var.policy["stateful"]
  tcp_strict = var.policy["tcp_strict"]

  dynamic "rule" {
    for_each = { for key, value in var.rules: key => value }
    content {
      display_name = rule.key
      destination_groups = [for value in rule.value["destination_groups"]: data.nsxt_policy_group.destination_groups[rule.key]]
    }
  }
}
