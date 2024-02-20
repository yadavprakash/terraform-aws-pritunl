# Terraform AWS Pritunl Module
## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [License](#license)

## Introduction
Terraform module to create an pritunl resource on AWS with ElasticC IP Addresses and Elastic Block Store.

## Usage
To use this module, include it in your Terraform configuration.

## Examples
Example
```hcl
module "pritunl" {
  source      = "git::https://github.com/opsstation/terraform-aws-pritunl.git?ref=v1.0.0"
  name        = "pritunl"
  environment = "test"

  #instance
  ami           = "ami-0a8e758f5e873d1c1"
  instance_type = "t2.medium"

  #Networking
  vpc_id            = module.vpc.id
  ssh_allowed_ip    = ["0.0.0.0/0"]
  subnet_ids        = tolist(module.public_subnets.public_subnet_id)
  ssh_allowed_ports = [22, 1194]

  #Keypair
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDmPzqVYDVlaExxJBwbrXT2jG44xMM1U6Z+nCPkjStGj4ayo7Lkz8SzzFbAS0uYaXaTJfc/ZI980BwtLAeWZeaFYDABDROJHS748cTwyByUe1S+yNMrz7wbyeZllQGt6EtnxcOADuMvtBGioTgfXIzJNYb73TlPEUVlTOEDbQd+8oDpO+u7SJFgT+q5OZE5XFyYvp5hHSdLgZhXurRfjvFpqVBwiTojL5o0Q2xqXxTFOFfdoDKcjbMwFwr4vdJ5Edqqa2gcl9nRtCL4vo0m/St0ekbZ3yT9h3gRgP3+u9L0rc0f4XZxNW3b0ljWC1dEd/pAVw1k1y1xRnYKKwNaT6nZcKqFawT/G4S9fj6LrD+RPJsEgMXcIaAcGeidQolVZce4fWyAJc5Dx0ALKTkHNN7NyyTXopuK63YJ5lUEwWOYc6q9l/xM49i9hdpMD0TafqM0rWXFY3ALR9z/U0CMWwtlQ33iInGEYRqd+wupm48nuHII359uNe/GKhjqCLU5K4E= rahul@rahul"

  #IAM
  iam_instance_profile = module.iam-role.name

  #Root Volume
  root_block_device = [
    {
      volume_type           = "gp2"
      volume_size           = 20
      delete_on_termination = true
      kms_key_id            = module.kms_key.key_arn
    }
  ]

  #user data
  user_data = file("${path.module}/pritunl.sh")
}
```

## Examples
For detailed examples on how to use this module, please refer to the [examples](https://github.com/opsstation/terraform-aws-pritunl/tree/master/_example) directory within this repository.

## License
This Terraform module is provided under the **MIT** License. Please see the [LICENSE](https://github.com/opsstation/terraform-aws-pritunl/blob/master/LICENSE) file for more details.

## Author
Your Name
Replace **MIT** and **opsstation** with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.13.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2"></a> [ec2](#module\_ec2) | git::https://github.com/opsstation/terraform-aws-ec2.git | v1.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | The AMI to use for the instance. | `string` | `""` | no |
| <a name="input_ebs_volume_enabled"></a> [ebs\_volume\_enabled](#input\_ebs\_volume\_enabled) | Flag to control the ebs creation. | `bool` | `false` | no |
| <a name="input_ebs_volume_size"></a> [ebs\_volume\_size](#input\_ebs\_volume\_size) | Size of the EBS volume in gigabytes. | `number` | `30` | no |
| <a name="input_ebs_volume_type"></a> [ebs\_volume\_type](#input\_ebs\_volume\_type) | The type of EBS volume. Can be standard, gp2 or io1. | `string` | `"gp2"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. | `string` | `""` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instances to launch. | `number` | `1` | no |
| <a name="input_instance_tags"></a> [instance\_tags](#input\_instance\_tags) | Instance tags. | `map(any)` | `{}` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The key name to use for the instance. | `string` | `""` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `"https://github.com/opsstation/terraform-aws-pritunl"` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | Customize details about the root block device of the instance. See Block Devices below for details. | `list(any)` | `[]` | no |
| <a name="input_ssh_allowed_ip"></a> [ssh\_allowed\_ip](#input\_ssh\_allowed\_ip) | List of allowed ip. | `list(any)` | `[]` | no |
| <a name="input_ssh_allowed_ports"></a> [ssh\_allowed\_ports](#input\_ssh\_allowed\_ports) | List of allowed ingress ports | `list(any)` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of VPC Subnet IDs to launch in. | `list(string)` | `[]` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | (Optional) A string of the desired User Data for the ec2. | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC that the instance security group belongs to. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The instance ID. |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Private IP of instance. |
| <a name="output_tags"></a> [tags](#output\_tags) | The instance tags. |
<!-- END_TF_DOCS -->