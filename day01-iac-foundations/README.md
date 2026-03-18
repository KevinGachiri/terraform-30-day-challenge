# Day 1 – Environment Setup

## AWS Account

I already had an AWS account available for use in this challenge.

To follow better automation practices, I decided to redesign the IAM identity used for Terraform.

Originally the CLI was authenticated using an IAM user called:

`terraform-user`

---

## IAM Best Practices

Instead of continuing with this identity, I created a new IAM user called:

`terraform-labs`

The purpose was to create a clearly named identity specifically for Terraform automation.

Steps taken:

1. Created a new IAM user named **terraform-labs**
2. Assigned permissions using the **Administrators group** available in my account
3. Generated programmatic access credentials
4. Updated my local AWS CLI configuration
5. Deactivated and deleted the original `terraform-user`

This provides a cleaner automation identity for Infrastructure as Code workflows.

---

## Terraform Installation

Terraform was installed manually using the official HashiCorp binary release.

After downloading the latest version, I moved the binary into:
/usr/local/bin


To verify installation:

terraform version

Output:

Terraform v1.14.7

---

## AWS CLI Configuration

After creating the new IAM user, I configured the AWS CLI using:

aws configure


This allowed the CLI to authenticate using the programmatic credentials associated with the new automation identity.

---

## AWS Identity Verification

To confirm that the environment was authenticated correctly, I ran:

aws sts get-caller-identity


Example output (sanitized):


{
"Account": "<redacted>",
"Arn": "arn:aws:iam::<account-id>:user/terraform-labs"
}


This confirms that the CLI is authenticated with the IAM identity created for Terraform automation.

---

## DevOps Practice

Creating a dedicated IAM identity for Terraform automation aligns with DevOps best practices around **clear identity management, reduced ambiguity in automation environments, and maintainable infrastructure design**.

Designing infrastructure identities deliberately from the beginning helps reduce operational complexity when managing infrastructure as code.

---

## Moving Forward

With Terraform installed and AWS authentication verified, the environment is now ready for Infrastructure as Code development.

The next step will be configuring the **AWS provider in Terraform** and initializing the first Terraform project the first Terraform project to begin provisioning infrastructure through code.
