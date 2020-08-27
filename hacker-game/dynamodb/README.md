# DynamoDB module

Module is prepared to use in both AWS DynamodB and DynamoDB Local.

### Provider
This provider configuration is prepared for Local DynamoDB.
To apply tables to AWS DynamoDB use another provider when 
adding module.

Example:
```
module "dynamodb" {
  source      = "./dynamodb"
  core_region = var.core_region
  providers = {
    aws = aws.my_provider_alias
  }
}
```

### Backend
Module use local backend as default.

## Variables
| Name | Description |
|------|-------------|
| core_region | Region where tables should be placed. |
