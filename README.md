# AWS SES Terraform module

This Terraform module configures Amazon Simple Email Service (SES) for a specified domain. It sets up DKIM, DMARC, advanced delivery dashboard, and proper MAIL FROM records.

## Usage

```hcl
module "ses" {
  source  = "tigpt/ses/aws"
  version = "1.0.0"

  domain           = "sample.com"                           ## Your domain to configure SES
  zone_id          = aws_route53_zone.primary.zone_id       ## Zone ID of your hostedzone for this domain
  quarentine_email = "mail@sample.com"                      ## Email to use for dmarc quarentine

  providers = {
    aws.domain = aws.usw2                                   ## Use only 'aws' if you deploy all in one account, or use another provider if domain is in a differnt account, check the complete example folder for more details.
  }
}
```

## Support

Do you want to help me maintain this module? Buy an AWS SES t-shirt!

[![Buy an AWS SES t-shirt](https://cottonbureau.com/mockup?vid=20449976&hash=84sz&w=120)](https://cottonbureau.com/people/tiago-rodrigues)

[Purchase here 😃](https://cottonbureau.com/people/tiago-rodrigues)

## Resources Created

- `aws_ses_domain_identity`
- `aws_ses_domain_dkim`
- `aws_route53_record` (DKIM records)
- `aws_route53_record` (DMARC record)
- `aws_sesv2_account_vdm_attributes`
- `aws_ses_domain_mail_from`
- `aws_route53_record` (MAIL FROM MX record)
- `aws_route53_record` (MAIL FROM SPF record)

## Examples

- [Complete SES](https://github.com/tigpt/terraform-aws-ses/tree/main/examples/complete) with multiple account setup.

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/tigpt/terraform-aws-ses/issues/new) section.


## Inputs


| Name | Description | Type | Default | Required |
|--|--|--|--|--|
| domain | Domain to use with SES | string | n/a | yes |
| zone_id | Zone ID for the Route 53 resource | string | n/a	| yes |
| quarentine_email | Quarantine email for DMARC | string | n/a	| yes |
| tags | Tags for all resources | map(string) | {}| 	no |

## Providers

| Name | Alias | Description |
|--|--|--|
| aws | | The AWS provide |
| aws | domain | The AWS provider for the domain (if using a different account)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.34 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.34 |

## Outputs

No outputs are defined for this module.

## Modules

No modules.

## Authors

Module is maintained by [Tiago Rodrigues](https://tig.pt) with help from [these awesome contributors](https://github.com/tigpt/terraform-aws-ses/graphs/contributors).

## License

MIT Licensed. See [LICENSE](https://github.com/tigpt/terraform-aws-ses/tree/master/LICENSE) for full details.
