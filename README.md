# Prerequisites

## Ansible

- please install it through `pip` (not through `brew`). Ansible is using `boto` (python interface for AWS), so installing ansible through pip is the working option. Something like the following should work (your mileage may vary):

```
$ pip install --upgrade pip
$ pip install boto
$ pip install ansible
$ ansible --version
ansible 2.5.4
  config file = /Users/georgi/Projects/livingdocs/bluewin/performance-testing/ansible.cfg
  configured module search path = ['/Users/georgi/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /Users/georgi/.pyenv/versions/3.5.0/lib/python3.5/site-packages/ansible
  executable location = /Users/georgi/.pyenv/versions/3.5.0/bin/ansible
  python version = 3.5.0 (default, Mar 17 2017, 17:54:06) [GCC 4.2.1 Compatible Apple LLVM 7.3.0 (clang-703.0.31)]
```

## Terraform setup

- installation guide if you need one: https://www.terraform.io/downloads.html.
- example of a terraform running successfully:

```
$ terraform --version
Terraform v0.11.7
```

## AWS cli

- configure the AWS cli. This might be already configured for most of you, but make sure you use the right credentials (bluewin, livingdocs). The configuration requires aws access key and aws secret access key.
- here is a good [aws + terraform guide](https://hackernoon.com/introduction-to-aws-with-terraform-7a8daf261dc0). Use the part on how to create on aws account and configure the cli.
- example of a successful configuration:

```
$ aws --version
aws-cli/1.15.31 Python/3.5.0 Darwin/17.5.0 botocore/1.10.31
$ aws configure list
      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************57VQ shared-credentials-file
secret_key     ****************ANQ1 shared-credentials-file
    region             eu-central-1      config-file    ~/.aws/config
```

# Setup

## Terraform

1. You need to setup terraform and install the needed packages:

```
$ terraform init
```

<details>
<summary>Full output of a successful run</summary>

```bash
Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "aws" (1.22.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 1.22"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary
```
</details>

<br/>

2. Ensure you have aws configuration and terraform setup by checking the state:

```
terraform plan -var-file=variables.tfvars
```

If aws and terraform setup is correct and working, you would most likely see an output which at the end says:

```
Plan: 4 to add, 0 to change, 0 to destroy.
```

<details>
<summary>Full output of a successful run</summary>

```bash
$ terraform plan -var-file=variables.tfvars
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_default_vpc.default
      id:                                    <computed>
      assign_generated_ipv6_cidr_block:      <computed>
      cidr_block:                            <computed>
      default_network_acl_id:                <computed>
      default_route_table_id:                <computed>
      default_security_group_id:             <computed>
      dhcp_options_id:                       <computed>
      enable_classiclink:                    <computed>
      enable_classiclink_dns_support:        <computed>
      enable_dns_hostnames:                  <computed>
      enable_dns_support:                    "true"
      instance_tenancy:                      <computed>
      ipv6_association_id:                   <computed>
      ipv6_cidr_block:                       <computed>
      main_route_table_id:                   <computed>

  + aws_instance.web-performance-test[0]
      id:                                    <computed>
      ami:                                   "ami-c7e0c82c"
      associate_public_ip_address:           <computed>
      availability_zone:                     <computed>
      ebs_block_device.#:                    <computed>
      ephemeral_block_device.#:              <computed>
      get_password_data:                     "false"
      instance_state:                        <computed>
      instance_type:                         "t2.micro"
      ipv6_address_count:                    <computed>
      ipv6_addresses.#:                      <computed>
      key_name:                              "terraform"
      network_interface.#:                   <computed>
      network_interface_id:                  <computed>
      password_data:                         <computed>
      placement_group:                       <computed>
      primary_network_interface_id:          <computed>
      private_dns:                           <computed>
      private_ip:                            <computed>
      public_dns:                            <computed>
      public_ip:                             <computed>
      root_block_device.#:                   <computed>
      security_groups.#:                     "1"
      security_groups.1271829205:            "with-ssh-security-group"
      source_dest_check:                     "true"
      subnet_id:                             <computed>
      tags.%:                                "1"
      tags.Name:                             "web-performance-test"
      tenancy:                               <computed>
      user_data:                             "8ad701e23aad06df493cc1291465222a8155b4c5"
      volume_tags.%:                         <computed>
      vpc_security_group_ids.#:              <computed>

  + aws_instance.web-performance-test[1]
      id:                                    <computed>
      ami:                                   "ami-c7e0c82c"
      associate_public_ip_address:           <computed>
      availability_zone:                     <computed>
      ebs_block_device.#:                    <computed>
      ephemeral_block_device.#:              <computed>
      get_password_data:                     "false"
      instance_state:                        <computed>
      instance_type:                         "t2.micro"
      ipv6_address_count:                    <computed>
      ipv6_addresses.#:                      <computed>
      key_name:                              "terraform"
      network_interface.#:                   <computed>
      network_interface_id:                  <computed>
      password_data:                         <computed>
      placement_group:                       <computed>
      primary_network_interface_id:          <computed>
      private_dns:                           <computed>
      private_ip:                            <computed>
      public_dns:                            <computed>
      public_ip:                             <computed>
      root_block_device.#:                   <computed>
      security_groups.#:                     "1"
      security_groups.1271829205:            "with-ssh-security-group"
      source_dest_check:                     "true"
      subnet_id:                             <computed>
      tags.%:                                "1"
      tags.Name:                             "web-performance-test"
      tenancy:                               <computed>
      user_data:                             "8ad701e23aad06df493cc1291465222a8155b4c5"
      volume_tags.%:                         <computed>
      vpc_security_group_ids.#:              <computed>

  + aws_security_group.with_ssh
      id:                                    <computed>
      arn:                                   <computed>
      description:                           "Managed by Terraform"
      egress.#:                              "1"
      egress.482069346.cidr_blocks.#:        "1"
      egress.482069346.cidr_blocks.0:        "0.0.0.0/0"
      egress.482069346.description:          ""
      egress.482069346.from_port:            "0"
      egress.482069346.ipv6_cidr_blocks.#:   "0"
      egress.482069346.prefix_list_ids.#:    "0"
      egress.482069346.protocol:             "-1"
      egress.482069346.security_groups.#:    "0"
      egress.482069346.self:                 "false"
      egress.482069346.to_port:              "0"
      ingress.#:                             "1"
      ingress.2541437006.cidr_blocks.#:      "1"
      ingress.2541437006.cidr_blocks.0:      "0.0.0.0/0"
      ingress.2541437006.description:        ""
      ingress.2541437006.from_port:          "22"
      ingress.2541437006.ipv6_cidr_blocks.#: "0"
      ingress.2541437006.protocol:           "tcp"
      ingress.2541437006.security_groups.#:  "0"
      ingress.2541437006.self:               "false"
      ingress.2541437006.to_port:            "22"
      name:                                  "with-ssh-security-group"
      owner_id:                              <computed>
      revoke_rules_on_delete:                "false"
      vpc_id:                                "${aws_default_vpc.default.id}"


Plan: 4 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

</details>

## Create a new key pair

- taken from https://docs.aws.amazon.com/cli/latest/userguide/cli-ec2-keypairs.html:

```
aws ec2 create-key-pair --key-name terraform --query 'KeyMaterial' --output text > terraform.pem && chmod 400 terraform.pem
```

- the key pair we have in the [variables](./variables.tfvars) and used throughout this README is named `terraform`. If you want to name your ssh key differently, make sure you pass to terraform like that:

```
terraform apply -var-file=variables.tfvars -auto-approve -var key_name="MY_SSH_KEY_NAME"
```

## Prepare urls list

- [ ] WIP - link to the team repo?

# Usage

1. Plan (get a preview of what would be the impact of the command - what would be created, deleted and/or updated):

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

4. Configure artillery (uploads artillery templates to the remote hosts and the urls list):

```
ansible-playbook ./configure-artillery.yml
```

5. Perform a test:

```
ansible-playbook perform-test.yml --extra-vars "artillery_duration=3 artillery_arrival_rate=7"
```

- [ ] WIP explain the `extra-vars` part

# Results

- [ ] WIP, describe how the obtain and access the results

# Destroy all instances

```
terraform destroy -var-file=variables.tfvars -auto-approve
```

# Caveats

- there is no live output of artillery while executing load testing the tested server. Ansible has not yet implemented it as a feature. Read [here](https://github.com/ansible/ansible/issues/3887) and [here](https://github.com/ansible/ansible/issues/4870).

# Help and support

Here you can find more information around the commands used in the guide:

## Displaying Your Key Pair

```
aws ec2 describe-key-pairs --key-name terraform
```

## Deleting Your Key Pair

```
aws ec2 delete-key-pair --key-name terraform && rm -f terraform.pem
```
