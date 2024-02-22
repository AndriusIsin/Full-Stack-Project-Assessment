provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "video-recommendations-andrius" {
  bucket = "video-recommendations-andrius"

  website {
    index_document = "index.html"
  }

  force_destroy = true  

  versioning {
    enabled = false  
  }

  lifecycle_rule {
    enabled = false  
  }
}

resource "aws_iam_user_policy" "s3_bucket_policy" {
  name       = "S3BucketPolicyModificationPolicy"
  user       = "Andrius"
  policy     = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:PutBucketPolicy"
        Resource = "arn:aws:s3:::video-recommendations-andrius"
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "video-recommendations_policy" {
  bucket = aws_s3_bucket.video-recommendations-andrius.bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "Statement1",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::video-recommendations-andrius/*"
      }
    ]
  })
}

resource "aws_s3_bucket_versioning" "video-recommendations" {
  bucket = aws_s3_bucket.video-recommendations-andrius.bucket

  versioning_configuration {
    status = "Suspended"  
  }
}

resource "aws_s3_bucket_public_access_block" "video-recommendations-andrius_public_access_block" {
  bucket = aws_s3_bucket.video-recommendations-andrius.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "video-recommendations-andrius_website" {
  bucket = aws_s3_bucket.video-recommendations-andrius.bucket

  index_document {
    suffix = "index.html"
  }

  routing_rule {
    redirect {
      host_name = "video-recommendations-andrius.s3-website-eu-west-2.amazonaws.com"
      protocol  = "http"
    }
  }
}
