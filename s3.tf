resource "aws_s3_bucket" "amohr_bucket" {
  bucket = "bucket-test-terraform-${local.sufix}"
}