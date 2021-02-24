## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| security\_group | n/a | `string` | n/a | yes |
| subnet\_id | n/a | `string` | n/a | yes |
| tags | n/a | `map(any)` | n/a | yes |
| vpc\_id | Network. | `string` | n/a | yes |
| ami\_id | ID of AMI to use. | `string` | `"ami-0dd90801535a05267"` | no |
| instance\_disk\_size | Size of instance EBS. | `string` | `"10"` | no |
| instance\_type | Type of instance used. | `string` | `"t3.micro"` | no |

## Outputs
