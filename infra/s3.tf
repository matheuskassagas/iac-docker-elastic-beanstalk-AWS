resource "aws_s3_bucket" "beanstalk_deplays" {
  bucket = "${var.name}-deplays"
}

resource "aws_s3_bucket_object" "dockerRun" {
  depends_on = [
    aws_s3_bucket.beanstalk_deplays
  ]
  bucket = "${var.name}-deplays"
  key = "${var.name}.zip"
  source = "${var.name}.zip"

  etag = filemd5("${var.name}.zip")
}