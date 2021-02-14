# AWS Symfony EC2 showroom

Showroom to demonstrate how deploy Symfony website in production with EC2 instances.

## Architecture

![architecture](./docs/architecture.png)

## Prerequisites

### Terraform

You must use `tfenv` and install version specified in `infrastructure/.tfenv` like that : 

```bash
johndoe@DESKTOP-XXXXXXX:~/workspace/aws-symfony-ec2-showroom/infrastructure$ tfenv install 0.14.6
Installing Terraform v0.14.6
Downloading release tarball from https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_linux_amd64.zip
###[...]### 100.0%
Downloading SHA hash file from https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_SHA256SUMS
No keybase install found, skipping OpenPGP signature verification
Archive:  tfenv_download.Miwlos/terraform_0.14.6_linux_amd64.zip
  inflating: /home/johndoe/.tfenv/versions/0.14.6/terraform  
Installation of terraform v0.14.6 successful. To make this your default version, run 'tfenv use 0.14.6'
johndoe@DESKTOP-XXXXXXX:~/workspace/aws-symfony-ec2-showroom/infrastructure$ tfenv use 0.14.6
Switching default version to v0.14.6
Switching completed
johndoe@DESKTOP-XXXXXXX:~/workspace/aws-symfony-ec2-showroom/infrastructure$ terraform version
Terraform v0.14.6
```
