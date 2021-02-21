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
| ec2_cluster | terraform-aws-modules/ec2-instance/aws | ~> 2.0 |

## Resources

| Name |
|------|
| [aws_ami](https://registry.terraform.io/providers/hashicorp/aws/3.0/docs/data-sources/ami) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami\_name | Name of base AMI to use. | `string` | `"symfony-web-image"` | no |
| aws\_region | AWS region where AMI can be used. | `string` | `"us-east-1"` | no |
| instance\_type | Type of instance used. | `string` | `"t3.micro"` | no |

## Outputs

