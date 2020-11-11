# resource "nsxt_policy_vm_tags" "vm_tags" {
#   for_each = toset(local.vms.*.vm)

#   instance_id = data.nsxt_policy_vm.vcf_vms[each.value].instance_id

#   dynamic "tag" {
#     for_each = {
#       for key,value in local.vm_tags_pairs: key => value if value["vm"] == each.value
#     }
#     content {

#     scope = tag.value["scope"]
#     tag = tag.value["tag"]
#   }
#     }
# }

locals {

tags = flatten([for scope_key,scope in var.tags : [
  for tag_key, tag in scope : {
    scope_key = scope_key
    tag_key = tag_key
    tag = tag 
    scope = scope 
  }
]])

}

data "nsxt_policy_vm" "vcf_vms" {
   display_name = var.vm
}


resource "nsxt_policy_vm_tags" "vm_tags" {
  depends_on = [
    data.nsxt_policy_vm.vcf_vms 
  ]
  
  instance_id = (data.nsxt_policy_vm.vcf_vms).instance_id

  dynamic "tag" {
    for_each = { for tag in local.tags : "${tag.scope_key}.${tag.tag_key}" => tag }

    content {
      scope = tag.value.scope_key
      tag = tag.value.tag
    }
  }
}


