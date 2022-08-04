resource "aws_dynamodb_table" "mgk-terraform-locks" {
  name         = "mgk-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}