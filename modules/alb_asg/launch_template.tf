# resource "aws_launch_template" "this" {
#   name_prefix   = "${var.name}-lt-"
#   image_id      = data.aws_ami.amazon_linux.id
#   instance_type = var.instance_type

#   key_name = var.key_pair_name

#   iam_instance_profile {
#     name = var.iam_instance_profile_name
#   }

#   vpc_security_group_ids = [var.ec2_sg_id]
#   user_data = base64encode(
#     file("${path.root}/user_data.sh")
#   )
# }

# resource "aws_launch_template" "this" {
#   name_prefix   = "${var.name}-lt-"
#   image_id      = data.aws_ami.amazon_linux.id
#   instance_type = var.instance_type

#   key_name = var.key_pair_name

#   iam_instance_profile {
#     name = var.iam_instance_profile_name
#   }

#   vpc_security_group_ids = [var.ec2_sg_id]

#   user_data = base64encode(var.user_data)
# }

# variable "user_data" {
#   type        = string
#   description = "User data script for EC2 instances"
# }

resource "aws_launch_template" "this" {
  name_prefix   = "${var.name}-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  key_name = var.key_pair_name

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  vpc_security_group_ids = [var.ec2_sg_id]

  user_data = base64encode(<<-EOF
    user_data = base64encode(<<-EOF
#!/bin/bash
set -e


dnf update -y

# Docker
dnf install -y docker
systemctl enable docker
systemctl start docker


usermod -aG docker ec2-user

# Docker
sleep 10


systemctl stop nginx || true
systemctl disable nginx || true
dnf remove -y nginx || true


docker rm -f ez-store || true

docker pull eslamzain99/ez-store:latest
docker run -d \
  --name ez-store \
  --restart always \
  -p 80:80 \
  eslamzain99/ez-store:latest

echo "EZ Store is running"
EOF

  )
}





