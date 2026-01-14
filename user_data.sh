user_data = base64encode(<<-EOF
#!/bin/bash
set -e

dnf update -y


dnf install -y docker
systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user

# Docker
sleep 10

# nginx is tacke default port 80
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
