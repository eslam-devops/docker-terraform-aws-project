module "network" {
  source = "./modules/network"

  name     = "blackcrow"
  vpc_cidr = "10.0.0.0/16"

  azs = [
    "us-east-1a",
    "us-east-1b"
  ]

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  security_groups = {
    alb = {
      description = "ALB Security Group"

      ingress = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]

      egress = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }

    ec2 = {
      description = "EC2 Security Group"

      ingress = [
        # {
        #   from_port = 80
        #   to_port   = 80
        #   protocol  = "tcp"
        #   sg_refs   = ["alb"]
        # },
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          from_port = 9090
          to_port   = 9090
          protocol  = "tcp"
          sg_refs   = ["alb"]
        }
      ]

      egress = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }
}

module "iam" {
  source = "./modules/iam_custom"

  roles = {
    ec2_role = {
      service = "ec2"
      enabled = true
      policies = [
        "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      ]
    }
  }

  default_tags = {
    Project = "Eslam-Zain-Store"
  }

}
module "alb_asg" {
  source = "./modules/alb_asg"

  name                      = "Eslamzain-web"
  vpc_id                    = module.network.vpc_id
  public_subnet_ids         = module.network.public_subnet_ids
  alb_sg_id                 = module.network.security_group_ids["alb"]
  ec2_sg_id                 = module.network.security_group_ids["ec2"]
  iam_instance_profile_name = module.iam.instance_profiles["ec2_role"].name
  key_pair_name             = aws_key_pair.this.key_name

}
# user_data                 = file("${path.module}/user_data.sh")



# module "alb_asg" {
#   source = "../modules/alb_asg"

#   name                      = "blackcrow-web"
#   vpc_id                    = module.network.vpc_id
#   public_subnet_ids         = module.network.public_subnet_ids
#   alb_sg_id                 = module.network.security_group_ids["alb"]
#   ec2_sg_id                 = module.network.security_group_ids["ec2"]
#   user_data                 = <<-EOF
#                               #!/bin/bash
#                               yum update -y
#                               yum install -y httpd
#                               systemctl start httpd
#                               systemctl enable httpd
#                               echo "<h1>Welcome to BlackCrow Web Server</h1>" > /var/www/html/index.html
#                               EOF
#   iam_instance_profile_name = module.iam.instance_profiles["ec2_role"].name
#   key_pair_name             = aws_key_pair.this.key_name
# }

# module "alb_asg" {
#   source = "../modules/alb_asg"

#   name              = "blackcrow-web"
#   vpc_id            = module.network.vpc_id
#   public_subnet_ids = module.network.public_subnet_ids
#   alb_sg_id         = module.network.security_group_ids["alb"]
#   ec2_sg_id         = module.network.security_group_ids["ec2"]
#   # user_data        = <<-EOF
#   #                     #!/bin/bash
#   #                     yum update -y
#   #                     yum install -y httpd
#   #                     systemctl start httpd
#   #                     systemctl enable httpd
#   #                     echo "<h1>Welcome to BlackCrow Web Server</h1>" > /var/www/html/index.html
#   #                     EOF
#   iam_instance_profile_name = module.iam.instance_profiles["ec2_role"].name
#   key_pair_name             = aws_key_pair.this.key_name
# }


# Retrieve EC2 instances in the Auto Scaling Group
data "aws_instances" "asg_instances" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [module.alb_asg.asg_name]
  }
}

module "cloudwatch" {
  source           = "./modules/cloudwatch"
  alb_arn          = module.alb_asg.alb_arn
  asg_name         = module.alb_asg.asg_name
  ec2_instance_ids = data.aws_instances.asg_instances.ids
}

# module "cloudfront" {
#   source       = "../modules/cloudfront"
#   alb_dns_name = module.alb_asg.alb_dns_name
#   alb_zone_id  = module.alb_asg.alb_zone_id
# }
