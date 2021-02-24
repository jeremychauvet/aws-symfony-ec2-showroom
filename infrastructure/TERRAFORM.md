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
| [aws_elb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elb) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | AWS region where AMI can be used. | `string` | `"us-east-1"` | no |
| tags | Tags used to ABAC and billing. | `map(string)` | <pre>{<br>  "CreatedBy": "Terraform",<br>  "Project": "MyOnlineBookStore"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
