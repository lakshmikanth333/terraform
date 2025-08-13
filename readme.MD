# Terraform AWS Infrastructure Projects

![Terraform](https://img.shields.io/badge/Terraform-1.5.0-blue)
![AWS](https://img.shields.io/badge/AWS-Provider-orange)

## About This Repository
Welcome! 👋  
This repository contains my **hands-on Terraform projects** where I build and manage AWS infrastructure using **Infrastructure as Code (IaC)** best practices.  

Here you will find examples ranging from basic EC2 and S3 setup to advanced **VPCs, modules, multiple environments, and remote state management**. The goal is to demonstrate a **scalable, modular, and professional IaC workflow**.

---

## Key Topics & Projects Covered

### 1️⃣ Basics of Terraform & IaC
- Advantages of Infrastructure as Code  
- Terraform installation and setup  
- Creating EC2 instances and Security Groups  
- Using **variables, data types, conditions, loops**, and **count-based resources**  
- Outputs for resources like EC2 public IP and S3 bucket names  

![Terraform Basics](https://via.placeholder.com/600x300?text=Terraform+Basics+Diagram)

---

### 2️⃣ Intermediate Concepts
- **Route53 DNS setup** along with EC2  
- Use of **locals, data sources**, and reusable **modules**  
- Understanding **Terraform state**, **remote state** with S3 and DynamoDB  
- Loops and conditional resource creation  

![Terraform State](https://via.placeholder.com/600x300?text=Terraform+State+Diagram)

---

### 3️⃣ Advanced Topics & Best Practices
- Managing **multiple environments** with **workspaces** and **separate repositories**  
- Module development for **VPCs, Security Groups, and Bastion hosts**  
- VPC concepts: Subnets, Internet Gateways, Route Tables, VPC Peering  
- **SSM Parameter Store** for secrets and configurations  
- Writing **security group rules** and using **open-source modules**  

![Advanced Modules](https://via.placeholder.com/600x300?text=Advanced+Terraform+Modules)

---

## Repository Structure

├── main.tf # Main Terraform configuration
├── variables.tf # Input variables
├── outputs.tf # Output values
├── modules/ # Reusable modules (EC2, VPC, SG, Bastion)
├── envs/ # Environment-specific variable files
│ ├── dev.tfvars
│ └── prod.tfvars
├── provisioners/ # Example scripts and remote-exec
├── README.md # Project documentation
└── diagrams/ # Architecture diagrams and images

yaml
Copy
Edit

---

## Usage & Commands

1. **Initialize Terraform**
```bash
terraform init
Validate Configuration

bash
Copy
Edit
terraform validate
Preview Changes

bash
Copy
Edit
terraform plan -var-file="envs/dev.tfvars"
Apply Infrastructure

bash
Copy
Edit
terraform apply -var-file="envs/dev.tfvars"
Destroy Resources (if needed)

bash
Copy
Edit
terraform destroy -var-file="envs/dev.tfvars"
Best Practices Implemented
Modular design for reusability and scalability

Separate workspaces and variable files for different environments

Secure defaults for S3, EC2, and Security Groups

State management with remote backend (S3 + DynamoDB)

Integration with SSM Parameter Store for secret management

