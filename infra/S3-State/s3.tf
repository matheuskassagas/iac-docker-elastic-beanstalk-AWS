# Bucket S3
resource "aws_s3_bucket" "mgk-terraform-state" {
  bucket = "mgk-terraform-state"

  # Seta nome e ambiente deste bucket
  tags = {
    Name        = "mgk-terraform-state"
    Environment = "dev"
  }

  # Habilite o controle de versão para que possamos ver o histórico de revisão completo de nosso
  # arquivos de estado
  versioning {
    enabled = true
  }

  # Ative a criptografia do lado do servidor por padrão
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# seta permissão de privado para o bucket
resource "aws_s3_bucket_public_access_block" "mgk-terraform-state" {
  bucket = aws_s3_bucket.mgk-terraform-state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

