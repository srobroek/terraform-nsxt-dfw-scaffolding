## groups

# resource "nsxt_policy_group" "application_groups" {
#   for_each = { for key, value in local.application_groups: key => value if value["type"] == "ip_addresses" 
#   }
#   display_name = each.key

#   criteria {
#     ipaddress_expression {
#       ip_addresses = each.value.value
#     }
#   }


# }



# resource "nsxt_policy_group" "application_groups" {
#   count = "${var.type == "group_members" ? 1: 0}"
#   for_each = { for key, value in local.application_groups: key => value if value["type"] == "tag" 
#   }
#   display_name = each.key

#   criteria {
#     dynamic "condition" {
#       for_each = each.value.value
#       content {
#       key = "Tag"
#       member_type = "VirtualMachine"
#       operator = "EQUALS"
#       value = condition.value
#       }
#     }
#   }

# data "nsxt_policy_group" "member_group" {

# }

# locals {
#   member_paths = [
#     for c in var.condition : {
#       member_path = nsxt_policy_group.groups[c].path
#     }


    
#   ]
# }

   #  vm_tags_pairs = flatten([
  #    for tag_key,tag_value in local.tags_yml : [
  #      for vm in tag_value.vms : {
  #        tag = tag_key
  #        vm = vm
  #        scope = tag_value.scope
  #      }
  #    ]
  #  ])
# }


resource "nsxt_policy_group" "groups" {

  display_name = var.group
  criteria {
    dynamic "condition" {
      for_each = var.condition
      content {
        key = "Tag"
        member_type = "VirtualMachine"
        operator = "EQUALS"
        value = condition.value
      }
    }
  }
}


# resource "nsxt_policy_group" "application_tag_groups" {
#   for_each = { for key, value in local.application_groups: key => value if value["type"] == "tag" 
#   }
#   display_name = each.key

#   criteria {
#     dynamic "condition" {
#       for_each = each.value.value
#       content {
#       key = "Tag"
#       member_type = "VirtualMachine"
#       operator = "EQUALS"
#       value = condition.value
#       }
#     }
#   }




# resource "nsxt_policy_group" "ip_groups" {
#   depends_on = [
#     data.nsxt_policy_group.groups
#   ]
#   for_each = {
#     for key, value in var.groups: key => value if value["type"] == "ip_group"
#   }
#   display_name = each.key
#   criteria {
#     ipaddress_expression {
#       ip_addresses = each.value["condition"]
#     }
#   }
# }

# resource "nsxt_policy_group" "tag_groups" {
#   depends_on = [
#     data.nsxt_policy_group.groups
#   ]
#   for_each = {
#     for key, value in var.groups: key => value if value["type"] == "tag_group"
#   }
#   display_name = each.key
#   criteria {
#     dynamic "condition" {
#       for_each = each.value["condition"]
#       content {
#         key = "Tag"
#         member_type = "VirtualMachine"
#         operator = "EQUALS"
#         value = condition.value 
#       }
#     }
#   }
# }

# # resource "nsxt_policy_group" "loadbalancer_groups" {
# #   depends_on = [
# #     data.nsxt_policy_group.groups
# #   ]
# #   count = var.type == "loadbalancer_group" ? 1 : 0
# #   display_name = var.group

# # }

# resource "nsxt_policy_group" "segment_groups" {
#   depends_on = [
#     data.nsxt_policy_group.groups
#   ]
#   for_each = {
#     for key, value in var.groups: key => value if value["type"] == "segment_group"
#   }
#   display_name = each.key

# }

# resource "nsxt_policy_group" "member_groups" {
#   depends_on = [
#     data.nsxt_policy_group.groups
#   ]
#   for_each = {
#     for key, value in var.groups: key => value if value["type"] == "member_group"
#   }
#   display_name = each.key
#   dynamic "criteria" {
#     for_each = { for key, value in var.condition: key=>value}
#     content { 
#       path_expression {
#         member_paths = [data.nsxt_policy_group.placeholder_groups["app.platform.vrni.sddc"].path]
#       }
#     }

#   }
# }






# resource "nsxt_policy_group" "network_ip_groups" {
#   for_each = { for key, value in local.network_groups: key => value if value["type"] == "ip_addresses" 
#   }
#   display_name = each.key

#   criteria {
#     ipaddress_expression {
#       ip_addresses = each.value.value
#     }
#   }
# }


# resource "nsxt_policy_group" "application_groups" {
#   count = "${var.type == "segment_members" ? 1: 0}"
#   for_each = { for key, value in local.application_groups: key => value if value["type"] == "tag" 
#   }
#   display_name = each.key

#   criteria {
#     dynamic "condition" {
#       for_each = each.value.value
#       content {
#       key = "Tag"
#       member_type = "VirtualMachine"
#       operator = "EQUALS"
#       value = condition.value
#       }
#     }
#   }
# }

# resource "nsxt_policy_group" "application_groups" {
#   count = "${var.type == "loadbalancer" ? 1: 0}"
#   for_each = { for key, value in local.application_groups: key => value if value["type"] == "tag" 
#   }
#   display_name = each.key

#   criteria {
#     dynamic "condition" {
#       for_each = each.value.value
#       content {
#       key = "Tag"
#       member_type = "VirtualMachine"
#       operator = "EQUALS"
#       value = condition.value
#       }
#     }
#   }
# }

# resource "nsxt_policy_group" "application_groups" {
#   count = "${var.type == "loadbalancer" ? 1: 0}"
#   for_each = { for key, value in local.application_groups: key => value if value["type"] == "tag" 
#   }
#   display_name = each.key

#   criteria {
#     dynamic "condition" {
#       for_each = each.value.value
#       content {
#       key = "Tag"
#       member_type = "VirtualMachine"
#       operator = "EQUALS"
#       value = condition.value
#       }
#     }
#   }
# }