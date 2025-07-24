# GitHub OIDC Setup Guide for AWS

## Overview
This document provides a walkthrough for setting up OpenID Connect (OIDC) authentication between GitHub Actions and AWS. This allows GitHub Actions workflows to securely authenticate with AWS without storing long-lived credentials.

## Manual Setup

### 1. Create an OIDC Identity Provider in AWS

1. Navigate to the IAM console in AWS
2. Go to "Identity providers" and click "Add provider"
3. Select "OpenID Connect" as the provider type
4. Enter `https://token.actions.githubusercontent.com` as the provider URL
5. Enter `sts.amazonaws.com` as the audience
6. Verify the provider and click "Add provider"

### 2. Create an IAM Role with Trust Policy

1. In the IAM console, go to "Roles" and click "Create role"
2. Select "Web identity" as the trusted entity type
3. Choose the GitHub OIDC provider you just created
4. For the Audience, select `sts.amazonaws.com`
5. Add a condition to restrict access to specific repositories:
   ```json
   {
     "StringLike": {
       "token.actions.githubusercontent.com:sub": "repo:your-org/your-repo:*"
     }
   }
   ```
6. Attach the necessary permissions policies
7. Name the role (e.g., `GitHubActionsOIDCRole`) and create it

### 3. Configure GitHub Actions Workflow

Add the following to your GitHub Actions workflow:

```yaml
permissions:
  id-token: write
  contents: read

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          role-to-assume: arn:aws:iam::123456789012:role/GitHubActionsOIDCRole
          aws-region: us-west-2
```

## Terraform Setup

Alternatively, use the Terraform configuration in `../terraform/oidc-role.tf` to set up the OIDC provider and IAM role:

1. Update the variables in the Terraform configuration:
   - Set `github_org` to your GitHub organization name
   - Set `github_repo` to your repository name

2. Apply the Terraform configuration:
   ```bash
   cd oidc-ci/terraform
   terraform init
   terraform apply
   ```

3. Update your GitHub Actions workflow with the role ARN output from Terraform.

## Security Considerations

- Restrict the OIDC trust relationship to specific repositories and branches
- Apply the principle of least privilege to the IAM role permissions
- Consider adding additional conditions like requiring specific GitHub environments

## Troubleshooting

- Verify the thumbprint for the GitHub OIDC provider is correct and up-to-date
- Check that the `sub` claim in the condition matches your repository format
- Ensure the role has the necessary permissions for your workflow
- Review CloudTrail logs for authentication failures

## Additional Resources
- [GitHub Actions OIDC Documentation](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
- [AWS IAM OIDC Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html)
