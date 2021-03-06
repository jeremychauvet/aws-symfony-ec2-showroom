## Requirements

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| sg_http | terraform-aws-modules/security-group/aws | 3.18.0 |
| vpc | terraform-aws-modules/vpc/aws | 2.71.0 |

## Resources

| Name |
|------|
| [aws_autoscaling_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment) |
| [aws_autoscaling_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) |
| [aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) |
| [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) |
| [aws_launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) |
| [aws_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) |
| [aws_lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) |
| [aws_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) |
| [aws_placement_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/placement_group) |
| [aws_route53_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) |
| [aws_route53_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) |
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami\_id | ID of AMI to use. | `string` | `"ami-0064d21c3ab673bf8"` | no |
| aws\_region | AWS region where AMI can be used. | `string` | `"us-east-1"` | no |
| instance\_type | Type of instance used. | `string` | `"c5.large"` | no |
| route53\_zone | Zone managed by Route 53 | `string` | `"dfnprdxcl.de."` | no |
| tags | Tags used to ABAC and billing. | `map(string)` | <pre>{<br>  "CreatedBy": "Terraform",<br>  "Project": "MyOnlineBookStore"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| elb\_dns\_name | The DNS name of the load balancer. |
