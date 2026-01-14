user_data = base64encode(<<-EOF
#!/bin/bash
set -e

# تحديث
dnf update -y

# Docker
dnf install -y docker
systemctl enable docker
systemctl start docker

# صلاحيات
usermod -aG docker ec2-user

# استنى Docker
sleep 10

# شيل أي nginx لو موجود
systemctl stop nginx || true
systemctl disable nginx || true
dnf remove -y nginx || true

# شيل أي كونتينر قديم
docker rm -f ez-store || true

# شغل التطبيق
docker pull eslamzain99/ez-store:latest
docker run -d \
  --name ez-store \
  --restart always \
  -p 80:80 \
  eslamzain99/ez-store:latest

echo "EZ Store is running"
EOF
)
