provider "aws" {
   region  = var.core_region
   version = "~> 2.5"
}

resource "aws_dynamodb_table" "users" {
  name           = "users" 
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "username"
    type = "S"
  }

  global_secondary_index {
    name               = "UsernameIndex"
    hash_key           = "username"
    read_capacity      = 5
    projection_type    = "ALL"
  }
}
