# 🌐 Eslam Zain – Cloud-Native Web Platform on AWS

## 🚀 Project Overview
This project demonstrates a **production-grade cloud architecture** built on **AWS**, designed and automated using **Terraform** and **Docker**.
It showcases real-world **DevOps best practices**, focusing on scalability, security, and automation.

The application is deployed inside **Docker containers** running on **EC2 instances** managed by an **Auto Scaling Group**, fronted by an **Application Load Balancer (ALB)** and accelerated globally via **Amazon CloudFront**.

---

<img width="1472" height="704" alt="image" src="https://github.com/user-attachments/assets/fa235dce-1ceb-46eb-84ad-7eebd35a29da" />


## 🏗️ Architecture Overview
User → CloudFront → Application Load Balancer → EC2 (Docker Containers)

---

## ☁️ AWS Services Used
- Amazon VPC
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG)
- Amazon EC2
- Docker
- Amazon CloudFront
- AWS IAM
- AWS CloudWatch
- AWS Systems Manager (SSM)

---

## 📦 Docker Deployment
```bash
docker pull eslamzain99/ez-store:latest
```

---

## 🔐 Security Best Practices
- Secure IAM roles
- No SSH required (SSM)
- Controlled Security Groups

---

## 🛠️ Infrastructure as Code (Terraform)
Modular Terraform design ensures reproducible and scalable infrastructure.

<img width="826" height="221" alt="image" src="https://github.com/user-attachments/assets/adcaef36-b82c-4549-bced-8e5779817bbc" />


---

## 📊 Monitoring
- CPU alarms
- ALB request monitoring

---

## 🌍 Live Access
Access the app through ALB or CloudFront domain.

<img width="1600" height="817" alt="image" src="https://github.com/user-attachments/assets/05c366d4-1a90-4a85-9a27-b045b9d05b42" />

<img width="1885" height="919" alt="image" src="https://github.com/user-attachments/assets/be737223-f8e0-4e70-8a32-2b89fe453093" />
<img width="1901" height="911" alt="image" src="https://github.com/user-attachments/assets/2a4f9e1e-6796-48a9-b131-5f954aca7399" />
<img width="1903" height="912" alt="image" src="https://github.com/user-attachments/assets/2b7525ac-b05a-4bf8-8af0-95af3d22a5c5" />




---

## 👨‍💻 Author
**Eslam Zain** – DevOps Engineer

---
