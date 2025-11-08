# Web Server Infrastructure with NLB

## Architecture

![Architecture Diagram](ARCHITECTURE.png)

## Components

| Component | Details | Location |
|-----------|---------|----------|
| **NLB** | Network Load Balancer on port 80 | Public Subnet |
| **EC2** | Apache web server (Amazon Linux 2) | Private Subnet |
| **Security** | Only 91.231.246.50 can access NLB | NLB Security Group |
| **NAT Gateway** | Enables EC2 outbound internet access | Public Subnet |
| **IGW** | Internet Gateway for internet connectivity | VPC |

## Deploy

```bash
terraform init
terraform plan
terraform apply -var="public_key=$(cat ~/.ssh/id_rsa.pub)"
```

## Access

From 91.231.246.50:
```bash
curl http://<nlb-dns>
```

Get the NLB DNS:
```bash
terraform output nlb_dns
```

## Cleanup

```bash
terraform destroy
```
