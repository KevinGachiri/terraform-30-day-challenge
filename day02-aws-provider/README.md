# Day 2 – Environment Validation and Setup

Day 2 focused on validating the Terraform and AWS environment setup and ensuring everything is working correctly before provisioning infrastructure.

---

## Setup Validation

### Terraform Version


terraform version
Terraform v1.14.7


---

### AWS CLI Version


aws --version
aws-cli/2.34.10 Python/3.13.11 Linux/x86_64


---

### AWS Identity


aws sts get-caller-identity

{
"Account": "<redacted>",
"Arn": "arn:aws:iam::<account-id>:user/terraform-labs"
}


---

### AWS Configuration


aws configure list

profile : <not set>
access_key : ****************
secret_key : ****************
region : us-east-1


---

## VS Code Extensions

- HashiCorp Terraform
- AWS Toolkit

---

## Setup Challenges

While pushing my repository to GitHub, I encountered an SSH authentication issue:


Permission denied (publickey)


This occurred because the SSH key was not loaded into the SSH agent.

### Fix


eval "$(ssh-agent -s)"
ssh-add ~/.ssh/gachs_ssh_key


### Verification


ssh -T git@github.com


After this, GitHub authentication worked and I was able to push successfully.

---

## Automation Improvement

To avoid repeating this issue, I automated SSH key loading by updating:


~/.bashrc

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/gachs_ssh_key 2>/dev/null


This ensures the SSH key is loaded automatically for every new terminal session.

---

## Key Learning

Terraform does not manage credentials directly. It relies on AWS CLI configuration.

After running:


aws configure


credentials are stored locally and Terraform automatically uses them to authenticate with AWS.

Using a dedicated IAM user instead of root credentials improves security and aligns with best practices.
