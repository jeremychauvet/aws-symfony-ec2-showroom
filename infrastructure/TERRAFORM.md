## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| ami\_id | ID of AMI to use. | `any` | n/a | yes |
| route53\_zone | Zone managed by Route 53 | `any` | n/a | yes |
| aws\_region | AWS region where AMI can be used. | `string` | `"us-east-1"` | no |
| instance\_type | Type of instance used. | `string` | `"c5.large"` | no |
| tags | Tags used to ABAC and billing. | `map(string)` | <pre>{<br>  "CreatedBy": "Terraform",<br>  "Project": "MyOnlineBookStore"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| account\_id | n/a |
| ami\_id | n/a |
| elb\_dns\_name | The DNS name of the load balancer. |
| natgw\_ids\_aza | NAT gateway AZa |
| private\_route\_table\_aza | Private route table AZa |
| route53\_dns\_name | The DNS public name. |
