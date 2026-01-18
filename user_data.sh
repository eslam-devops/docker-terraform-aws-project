user_data = base64encode(<<-EOF
#!/bin/bash
set -e

dnf update -y


dnf install -y docker
systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user

# استنى Docker
sleep 10

# شيل أي nginx لو موجود
systemctl stop nginx || true
systemctl disable nginx || true
dnf remove -y nginx || true


docker rm -f ez-store || true

docker pull eslamzain99/ez-store:latest
docker run -d \
  --name ez-store \
  --restart always \
  -p 9090:80 \
  eslamzain99/ez-store:latest

echo "EZ Store is running"
EOF
)
