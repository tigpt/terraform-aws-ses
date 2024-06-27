#######################
#--- SES Resources ---#
#######################

resource "aws_ses_domain_identity" "this" {
  domain = var.domain
}

# setup dkim

resource "aws_ses_domain_dkim" "this" {
  domain = var.domain
}

resource "aws_route53_record" "amazonses_dkim_record" {
  provider = aws.domain
  count    = 3
  zone_id  = var.zone_id
  name     = "${aws_ses_domain_dkim.this.dkim_tokens[count.index]}._domainkey"
  type     = "CNAME"
  ttl      = "600"
  records  = ["${aws_ses_domain_dkim.this.dkim_tokens[count.index]}.dkim.amazonses.com"]
}

#setup dmarc

resource "aws_route53_record" "amazonses_dmarc_record" {
  provider = aws.domain
  zone_id  = var.zone_id
  name     = "_dmarc.${var.domain}"
  type     = "TXT"
  ttl      = "600"
  records  = ["v=DMARC1;p=quarantine;rua=mailto:${var.quarentine_email}"]
}

# setup advanced delivery dashboard

resource "aws_sesv2_account_vdm_attributes" "this" {
  vdm_enabled = "ENABLED"

  dashboard_attributes {
    engagement_metrics = "ENABLED"
  }

  guardian_attributes {
    optimized_shared_delivery = "ENABLED"
  }
}

# Setup ses emails for proper MAIL FROM record.

resource "aws_ses_domain_mail_from" "this" {
  domain           = var.domain
  mail_from_domain = "ses.${var.domain}"
  depends_on = [
    aws_ses_domain_identity.this
  ]
}

# Route53 MX record
resource "aws_route53_record" "ses_domain_mail_from_mx" {
  provider = aws.domain
  zone_id  = var.zone_id
  name     = aws_ses_domain_mail_from.this.mail_from_domain
  type     = "MX"
  ttl      = "600"
  records  = ["10 feedback-smtp.${data.aws_region.current.name}.amazonses.com"]
}

# Route53 TXT record for SPF
resource "aws_route53_record" "ses_domain_mail_from_txt" {
  provider = aws.domain
  zone_id  = var.zone_id
  name     = aws_ses_domain_mail_from.this.mail_from_domain
  type     = "TXT"
  ttl      = "600"
  records  = ["v=spf1 include:amazonses.com -all"]
}


