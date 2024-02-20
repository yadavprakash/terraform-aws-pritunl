#tfsec:ignore:aws-ec2-enable-at-rest-encryption
module "ec2" {
  source      = "git::git@github.com:opsstation/terraform-aws-ec2.git"
  name        = var.name
  environment = var.environment

  ##----------------------------------------------------------------------------------
  ## Below A security group controls the traffic that is allowed to reach and leave the resources that it is associated with.
  ##----------------------------------------------------------------------------------
  #tfsec:aws-ec2-no-public-ingress-sgr
  vpc_id            = var.vpc_id
  ssh_allowed_ip    = var.ssh_allowed_ip
  ssh_allowed_ports = var.ssh_allowed_ports
  #Instance
  instance_count = var.instance_count
  ami            = var.ami
  instance_type  = var.instance_type

  #Keypair
  public_key = var.public_key

  #Networking
  subnet_ids = var.subnet_ids

  #tfsec:aws-ec2-enable-at-rest-encryption
  #IAM
  iam_instance_profile = var.iam_instance_profile

  #Root Volume
  root_block_device = var.root_block_device

  #EBS Volume
  ebs_volume_enabled = var.ebs_volume_enabled
  ebs_volume_type    = var.ebs_volume_type
  ebs_volume_size    = var.ebs_volume_size

  #Tags
  instance_tags = var.instance_tags

  #Mount EBS With User Data
  user_data = var.user_data
}
