# Granted Setup Guide

## Overview
This document provides setup instructions for using Granted to assume AWS IAM roles from the command line.

## Prerequisites
- AWS CLI installed and configured
- [Granted CLI](https://granted.dev/) installed

## Setup Instructions

### 1. Install Granted
```bash
brew install common-fate/granted/granted
```

### 2. Configure AWS Profile
Add the following to your `~/.aws/config` file:

```ini
[profile your-profile-name]
role_arn = arn:aws:iam::123456789012:role/YourRoleName
source_profile = default
region = us-west-2
```

Replace:
- `your-profile-name` with your desired profile name
- `123456789012` with your AWS account ID
- `YourRoleName` with the name of the IAM role created in terraform
- `region` with your preferred AWS region

### 3. Using Granted to Assume Roles
```bash
# List available profiles
granted profiles ls

# Assume a role
granted aws -p your-profile-name

# Run a command with temporary credentials
granted exec -p your-profile-name -- aws s3 ls
```

### 4. Troubleshooting
- Ensure your source profile has permissions to assume the target role
- Verify the trust relationship in the IAM role allows your user/role to assume it
- Check AWS CLI configuration for any syntax errors

## Additional Resources
- [Granted Documentation](https://granted.dev/docs)
- [AWS IAM Roles Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html)
