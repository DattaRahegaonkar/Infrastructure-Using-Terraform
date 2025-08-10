
resource "aws_dynamodb_table" "state_lock_table" {
  name         = "${var.env}_Infra_State_Lock_Table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key     = "${var.hash_key}"

  attribute {
    name = "${var.hash_key}"
    type = "S"
  }

  tags = {
    Name        = "${var.env}_Infra_State_Lock_Table"
    environment = var.env
  }

}