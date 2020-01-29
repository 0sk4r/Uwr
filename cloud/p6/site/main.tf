# Configure the AWS Provider
provider "aws" {
  region  = "eu-west-1"
}

resource "aws_s3_bucket" "b" {
  bucket = "cloud-react-site"
  acl    = "public-read"
#   policy = "${file("policy.json")}"

  website {
    index_document = "index.html"
    error_document = "error.html"

}
}