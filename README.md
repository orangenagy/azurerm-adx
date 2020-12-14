# azurerm-adx

## preparation
1. Create file `adx.tfvars` with variables - specifically `resource_base_name` to specify resource base name

## running instructions
1. `az login`
2. `terraform init`
3. `terraform apply -var-file="adx.tfvars"`
