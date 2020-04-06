resource "aws_s3_bucket" "MyBucket" {
   bucket = "blek-terraform-bucket2020"
   acl = "private"

   versioning {
       enabled = true
   }

   lifecycle {
       prevent_destroy = false
   }

   tags = {
       Name = "My Bucket"
       Environment = "Prod"
   }
}
