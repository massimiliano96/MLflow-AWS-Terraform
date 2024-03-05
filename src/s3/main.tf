resource "random_pet" "pet_name" {
  length    = 2
  separator = "-"
}
resource "aws_s3_bucket" "s3_bucket_test_tf" {
  bucket = "mlflow-artifacts-${random_pet.pet_name.id}"
}

resource "aws_s3_bucket_ownership_controls" "s3_ownership_tf_test" {
  bucket = aws_s3_bucket.s3_bucket_test_tf.id
  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_acl" "s3_acl_tf_test" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_ownership_tf_test]

  bucket = aws_s3_bucket.s3_bucket_test_tf.id
  acl    = var.acl
}