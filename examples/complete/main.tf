resource "aws_route53_zone" "primary" {
  provider = aws.usw2
  name     = "sample.com"
}

module "ses" {
  source = "../../"

  domain           = "sample.com"
  zone_id          = aws_route53_zone.primary.zone_id
  quarentine_email = "mail@sample.com"

  providers = {
    aws.ses    = aws.usw1
    aws.domain = aws.usw2
  }
}
