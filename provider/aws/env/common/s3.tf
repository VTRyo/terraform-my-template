resource "aws_s3_bucket" "my-website_bucket" {
  bucket              = "${lookup(var.s3_config, "bucket")}"
  policy              = "${file("policy/static_website_policy.json")}"
  website_endpoint    = "${lookup(var.s3_config, "website_endpoint")}"
  region              = "${lookup(var.s3_config, "region")}"

  website {
    index_document = "index.html"
  }
}
