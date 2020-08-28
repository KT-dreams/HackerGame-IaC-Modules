provider "aws" {
   region  = var.core_region
   version = "~> 2.5"
}

terraform {
  backend "s3" {
    bucket = "kt-dreams-terraform-state"
    key    = "state"
    region = "eu-central-1"
  }
}

module "dynamodb" {
  source      = "./dynamodb"
  core_region = var.core_region
  providers = {
    aws = aws
  }
}

resource "aws_iam_user" "hacker_game_service_user" {
  name = "srv_hacker_game"
}

resource "aws_iam_user_policy" "srv_hacker_game_policy" {
  depends_on = [aws_iam_user.hacker_game_service_user]
  name       = "srv_hacker_game_policy"
  user       = "srv_hacker_game"

  policy     = <<EOF
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
                "dynamodb:Query",
                "dynamodb:UpdateItem"
            ],
            "Resource": "arn:aws:dynamodb:eu-central-1:358547536439:table/users"
        }
    ]
}
EOF
}
