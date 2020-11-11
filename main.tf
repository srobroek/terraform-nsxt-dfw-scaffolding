locals {


}

provider "nsxt" {
  allow_unverified_ssl      = var.nsxt_cluster_allow_unverified_ssl
  max_retries               = 10
  retry_min_delay           = 500
  retry_max_delay           = 5000
  retry_on_status_codes     = [429]
  username                  = var.nsxt_cluster_username
  password                  = var.nsxt_cluster_password
  host                      = var.nsxt_cluster_fqdn
}


locals {


  vms = yamldecode(file(var.tags_yml_file))["vms"]
  groups_yml = yamldecode(file(var.groups_yml_file))["groups"]
  tag_groups = {for key, value in local.groups_yml: key => value if value["type"] == "tag_group"}
  member_groups = {for key, value in local.groups_yml: key => value if value["type"] == "member_group"}
  ip_groups = {for key, value in local.groups_yml: key => value if value["type"] == "ip_group"}  
  segment_groups = {for key, value in local.groups_yml: key => value if value["type"] == "segment_group"}  
  lb_groups = {for key, value in local.groups_yml: key => value if value["type"] == "lb_group"}  
  placeholder_groups = {for key, value in local.groups_yml: key => value if value["type"] == "placeholder_group"}  

#  security_policies = yamldecode(file(var.security_policies_yml_file))["policies"]
}



  module "vcf_policy_vm_tags" {
   source = "./modules/vcf_policy_vm_tags"
   for_each = {
     for key, value in local.vms: key => value
   }
   tags = each.value
   vm = each.key
  }


  module "ip_group" {
    for_each = {
      for key, value in local.ip_groups: key => value
    }
    group = each.key
    condition = each.value["condition"] 

    source = "./modules/vcf_policy_groups/ip_group"

  }

  module "tag_group" {
    for_each = {
      for key, value in local.tag_groups: key => value
    }
    group = each.key
    condition = each.value["condition"] 

    source = "./modules/vcf_policy_groups/tag_group"

  }

  
  module "segment_group" {
    for_each = {
      for key, value in local.segment_groups: key => value
    }
    group = each.key
    condition = each.value["condition"] 

    source = "./modules/vcf_policy_groups/segment_group"

  }

 module "lb_group" {
    for_each = {
      for key, value in local.lb_groups: key => value
    }
    group = each.key
    condition = each.value["condition"] 

    source = "./modules/vcf_policy_groups/lb_group"

  }

 module "placeholder_group" {
    for_each = {
      for key, value in local.placeholder_groups: key => value
    }
    group = each.key
    source = "./modules/vcf_policy_groups/placeholder_group"

  }
  

### We depend on all the child groups being created first
  module "member_group" {
  depends_on = [
    module.tag_group,
    module.ip_group,
    module.segment_group,
    module.lb_group,
    module.placeholder_group
  ]
  for_each = {
    for key, value in local.member_groups: key => value
  }
  group = each.key
  condition = each.value["condition"] 

  source = "./modules/vcf_policy_groups/member_group"

}


# module "vcf_policy_security_policy" {
#   depends_on = [
#     module.member_group
#   ]
#   for_each = {
#     for key, value in local.security_policies: key => value 
#   }
#   display_name = each.key 
#   policy = each.value
#   rules = each.value["rules"]

#   source = "./modules/vcf_policy_security_policies"
# }





