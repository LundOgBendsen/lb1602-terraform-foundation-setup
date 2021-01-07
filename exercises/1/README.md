# What will you have learned after performing this exercise

Verify you have the requisites and installs required for this course correctly
set up. How to create and destroy a basic piece of infrastructure on Amazon with
terraform.

## Prerequisites

This is what you need to install before starting the part of the course where we
work together as a group.

### AWS account

This course is run on Amazon. To participate in the hands on part, you need to
have an account on Amazon. If you do not have one already, create one now. Go
to [this page](https://portal.aws.amazon.com/billing/signup?exp=default&redirect_url=https%3A%2F%2Faws.amazon.com%2Fregistration-confirmation#/start)
to create a new account or sign in to an existing account. With an Amazon
account you get some free computing power with your account. You can use some of
that on this course. If you used up your free tier, you may have to pay for the
juice you use on this course. This will sum up to ... maybe 1 usd.

Once the account is created, you will need credentials to use the account
programmatically. To get credentials, create an AIM user (an IAM user is a
'sub-user' on the account you just created). Do this now, by
going [here](https://console.aws.amazon.com/iam/home#/users$new?step=details)
and follow the instructions below:

* select a user name, e.g. lb1602

* tick of programmatic access and console access

* click 'next'

* click 'attach existing policies directly'

* search for and tick off "AmazonEC2FullAccess", and "AmazonVPCFullAccess"

* click 'next' to get to the tags page

* click 'next' again

* verify that you have these three Managed policies AmazonEC2FullAccess,
  AmazonVPCFullAccess, IAMUserChangePassword

* click 'create user'

* click 'Download .csv'. It has _Access key ID_ and _Secret access key_, very
  important 8)

* Click 'send email' to send login instructions to yourself.

Now you have created your user. To use the use on your local machine, you must
find the .csv file you just downloaded and copy the credentials to an aws
specific file. On linux you create or edit the file
```~/.aws/credentials```
on windows ```C:\Users\<user>\.aws\credentials```

```
[default]
aws_access_key_id = YOUR_ACCESS_KEY_FROM_CSV 
aws_secret_access_key = YOUR_SECRET_FROM_CSV
```

### terraform

Find instructions to install terraform
on [terraforms homepage](https://learn.hashicorp.com/tutorials/terraform/install-cli)
and install it on your system. I installed terraform on linux
using [tfenv](https://github.com/tfutils/tfenv). tfenv helps you handle
multiple (or growing) versions of terraform. You can install terraform any way
you like, the important part for this course, is that you have terraform
version >= 0.14.0 and > 0.15.0 installed on your system.

### aws cli

Find
instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
to install it on your system. We use the latest version in the hour of writing,
being 2.1.7. I believe you will be fine as long as you use any version 2.x.y
variant.

## Tasks

Verify that your terraform files are valid. Start by running opening a shell,
and _cd_ into exercises/1.

Then run

```
terraform validate
```

in this directory. Expect an output along the lines of

```
Success! The configuration is valid.
```

initialize terraform

```
terraform init
```

Create the infrastructure

```
terraform plan -out plan
```

this should give output along the lines of

```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.example will be created
  + resource "aws_instance" "example" {
      + ami                          = "ami-0b5247d4d01653d09"
.
.
.
          + volume_type           = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

This plan was saved to: plan

To perform exactly these actions, run the following command to apply:
    terraform apply "plan"

```

You are happy. Lets do the actual creation of the infrastructure

```
terraform apply plan
```

this will take a little time (a couple of minutes), during which some output
will be shown. Eventually you should see something like:

```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

On the output. Success.

Be sure to destroy the created infrastructure again, otherwise it will stay
turned on, and this costs money.

This is done by the command

```
terraform destroy
```

or

```
terraform destroy -force
```

Once *that* has successfully completed, you have created and destroyed a small
infrastructure using terraform, and verified that your tooling works.

If you are curious as to what the terraform resources in the exercise-1.tf 
file means, 
[here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) is 
a good place to look. 