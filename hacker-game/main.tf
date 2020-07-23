provider "aws" {
   region  = var.core_region
   version = "~> 2.5"
}

resource "aws_dynamodb_table" "users" {
  name         = "users" 
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "username"
    type = "S"
  }

  global_secondary_index {
    name            = "UsernameIndex"
    hash_key        = "username"
    projection_type = "ALL"
  }
}

resource "aws_dynamodb_table" "requests" {
  name         = "requests"
  billing_mode = "PAY_PER_REQUEST"
  hash_key      = "request_uuid"
  
  attribute {
    name = "request_uuid"
    type = "S"
  }
}

resource "aws_iam_user" "hacker_game_service_user" {
  name                 = "srv_hacker_game"
}

resource "aws_iam_user_policy" "srv_hacker_game_policy" {
  depends_on = [aws_iam_user.hacker_game_service_user]
  name       = "srv_hacker_game_policy"
  user       = "srv_hacker_game"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:DeleteItem",
                "dynamodb:GetItem",
                "dynamodb:Scan",
                "dynamodb:UpdateItem"
            ],
            "Resource": [
                "arn:aws:dynamodb:eu-central-1:358547536439:table/users",
                "arn:aws:dynamodb:eu-central-1:358547536439:table/requests"
            ]
        }
    ]
}
EOF
}
