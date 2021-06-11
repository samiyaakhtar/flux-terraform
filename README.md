# flux-terraform
Terraform script to deploy fluxv2 

## Getting started 

- create a `terraform.tfvars` file with the following contents: 
  ```
  target_path="<path in your manifest where cluster config or manifests reside>"
  url="ssh://git@ssh.dev.azure.com/v3/orgname/projectname/manifest"
  branch_name="<branch name>"
  known_hosts="<cat your known_hosts file by running `cat ~/.ssh/known_hosts | grep azure` and copy the entry for ssh.dev.azure.com (this is needed for create an SSH key successfully)>"
  ```
- Run `terraform init` and `terraform apply`
- There will be an output for an SSH key to create in AzDO settings, which will allow flux to authenticate with AzDO. Make sure to copy this or run `terraform output` to copy and create this key in AzDO settings. 

