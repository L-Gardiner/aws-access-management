# AWS Access Management

This mini project demonstrates how to securely manage AWS access using two professional approaches:

1. **Developer CLI Access** using [Granted](https://github.com/common-fate/granted)
2. **CI/CD Pipeline Access** via [GitHub Actions OIDC](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html)

Both flows are implemented and documented with Terraform, IAM best practices, and GitHub Actions.

---

## 📁 Structure

```
aws-access-management/
├── README.md                      # High-level explanation (this file)
├── .gitignore
├── granted/                      # For local developer role assumption
│   ├── terraform/
│   │   └── iam-role.tf           # IAM role and trust policy for CLI access
│   └── docs/
│       └── granted-setup.md      # Setup instructions with Granted and ~/.aws/config
├── oidc-ci/                      # For GitHub OIDC-based CI/CD role assumption
│   ├── terraform/
│   │   └── oidc-role.tf          # OIDC IAM role + trust + permissions
│   ├── .github/
│   │   └── workflows/
│   │       └── deploy.yml        # Example Terraform-based GitHub workflow
│   └── docs/
│       └── oidc-setup.md         # Manual + Terraform OIDC trust walkthrough
```

---

## 🚀 Components

### 🔐 1. Developer CLI Access (Granted)
- Long-lived IAM user with no direct permissions
- IAM role with admin access
- Role trusted only by the IAM user
- Granted CLI + `assume -c` launches secure sessions

### 🤖 2. GitHub OIDC Access
- GitHub Actions assumes IAM role using identity token
- Role trusted only by `repo:<owner>/<repo>:*`
- Used for Terraform deployments without storing AWS secrets

---

## 📸 Screenshots
Throughout the setup, you’ll be prompted to take screenshots of:
- IAM Role trust policy for Granted
- ~/.aws/config showing Granted profile
- IAM Role trust policy for OIDC
- GitHub Actions `assume` job with successful AWS auth

These will be embedded in the respective setup guides.

---

## 📦 Prerequisites
- AWS account with root access to set up IAM
- Terraform CLI
- Granted CLI (`brew install granted`)
- GitHub repo created and connected
- GitHub Actions enabled

---

## ✅ Outcomes
- Clear split between dev and CI identity
- Secure, minimal, credential-less GitHub deployments
- Professional access strategy for personal or team projects