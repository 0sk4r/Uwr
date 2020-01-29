provider "aws" {
  region = "eu-west-1"
}


resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "btc-price"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5

  hash_key  = "Date"
  range_key = "Price"
  
  attribute {
    name = "Date"
    type = "N"
  }

  attribute {
    name = "Price"
    type = "N"
  }
  tags = {
    Name = "dynamodb-table-1"
  }
}
