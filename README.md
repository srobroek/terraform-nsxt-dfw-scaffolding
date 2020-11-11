# terraform-nsxt-dfw-scaffolding
Automatically build your NSX DFW scaffolding using terraform

## Usage

- Clone this repository
- Install terraform
- run terraform init in the current working directory
- fill out the relevant variables in terraform.tfvars. Set the password through an environment variable if you want or grab it from a vault. 
- update the groups.yml, tags.yml to your liking. Format should be pretty clear. By default it will create a set of groups and tags used in a consumer/provider microsegmentation model for VMware VCF/VVD, but this can obviously be customised to whatever your application looks like and can be used in a repeatable fashion to automatically provisioning microsegmentation architectures. However, even when using the defaults you will still have to update all the ip_groups and segment groups (for obvious reasons)
- run terraform apply and watch the magic


## Limitations

- groups currently only support one of the following member types:
  - ip addresses
  - segments
  - other groups
  - tags 
- groups don't support mixed types
- all your groups not mentioned in the groups.yml must exist before running this TF, it will not automatically create groups on-demand. 
- creation of firewall rules are a WIP 
- tags must be noted as scope|tag in the condition for tag_groups. This is a limitation of the NSX-T API. 
- things might probably break or cause things to catch on fire. caveat emptor and all. 
