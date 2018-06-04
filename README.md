# Prerequisites

## Terraform

```
terraform init
```

## AWS cli

```
aws configure
```

## Key Pairs

- taken from https://docs.aws.amazon.com/cli/latest/userguide/cli-ec2-keypairs.html
- the key pair we have in the [variables](./variables.tfvars) and used throughout this README is named `terraform`. If you want to name your ssh key differently, make sure you pass to terraform like that:

```
terraform apply -var-file=variables.tfvars -auto-approve -var key_name="MY_SSH_KEY_NAME"
```

### Create a new key pair

```
aws ec2 create-key-pair --key-name terraform --query 'KeyMaterial' --output text > terraform.pem && chmod 400 terraform.pem
```

### Displaying Your Key Pair

```
aws ec2 describe-key-pairs --key-name terraform
```

### Deleting Your Key Pair

```
aws ec2 delete-key-pair --key-name terraform && rm -f terraform.pem
```

# Usage

1. Plan (get a preview of what would be the impact of the command):

```
terraform plan -var-file=variables.tfvars
```

2. Apply

```
terraform apply -var-file=variables.tfvars

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

Select `yes` when asked to enter a value.

If you know what you are doing and you want to skip the confirmation:

```
terraform apply -var-file=variables.tfvars -auto-approve
```


3. Update the hosts

```
terraform output instances > hosts
```

4. Make sure you have connection to the hosts

- notice we are not using your default ssh user to connect to the remote host machine, but we are using `ubuntu`.

```
ansible all -i hosts -m ping -u ubuntu
```

5. Prepare

# Destroy all instances

```
terraform destroy -var-file=variables.tfvars -auto-approve
```
