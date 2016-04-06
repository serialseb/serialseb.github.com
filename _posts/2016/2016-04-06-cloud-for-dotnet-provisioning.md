---
title: Cloud for .net – Windows Passwords, locks and keys
date: 2016-04-06 21:49:00 +0100
serial: cloud-for-dotnet
comments: true
published: true
tags: [devops, terraform, aws]
---

We created a box, and it's with a nice security group that allows us to RDP in the machine.

By default, Amazon creates an administrator password for any machine you create, but you need an SSH key-pair to retrieve it.

## Each lock has its key

AWS needs a key to open the lock that guards the Administrator password it created on its windows instance. Without a key, the door would be open and anyone with access to your AWS console could retrieve any password.

However, a single key would be difficult to provide. You'd have to create a key, which you should keep as private as the key to your house, and then give a copy to Amazon, and they don't want you to open your house to you, or at least not when it comes to EC2 instances.

Thankfully, since the 1970s, we can thank British cryptographers for coming up with a better solution. Instead of having one key, you have two: one that you share with everyone, and one that you keep secret. If someone wants to have a lock only you can open, they only need your public key to build a door. With your private key, and only with your private key, will you be able to unlock the door. The public key is not enough, so it can be shared openly.

To create a key-pair, we use either `ssh-keygen` on all platforms that support Unix tooling, or with an extra package on windows. Make sure your terminal/cmd is open and in the folder we created so far.

For everyone:

```sh
$ mkdir .ssh
$ ssh-keygen -t rsa -C "dev" -P "" -f "./.ssh/dev"
```

For Windows:

```bat
c:\MyProject\> mkdir .ssh
c:\MyProject\> choco install win32-openssh
c:\MyProject\> ssh-keygen -t rsa -C "dev" -P "" -f "./.ssh/dev"
```

You should now have two files in the .ssh folder, `dev-deploy`, which is your private key and you should keep to yourself, and `dev-deploy.pub` which is your public key.

## Adding keys

To add the key to terraform, we create a new file, let's call it `keys.tf`, and we link to our public key, by creating an `[aws_key_pair][aws-key-pair]` resource.

```tf
resource "aws_key_pair" "dev" {
    key_name = "dev"
    public_key = "${file("./.ssh/dev.pub")}"
}
```

If you have a sharp eye, you'll have noticed that we used another interpolation, one of the in-built functions of terraform, `file`, which allows us to load a file and use whatever content as a property.

We now add the key to our instance, to make sure that we can retrieve the password once it's created.

```tf
resource "aws_instance" "my_cool_server" {
  ami = "ami-3d787d57"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.rdp.name}"]
  key_name = "${aws_key_pair.dev.key_name}"
}
```

If you `terraform apply`, you'll now have a Windows box with a password you can retrieve.

## Retrieving the password

Now we have an RDP port, and we have a key to retrieve the Administrator password. You could do that from the AWS console, by following the [manual guide from Amazon][amazon-password], but we've established by now that the command line helps us go faster.

We'll use the aws cli, which we installed in the first part, to retrieve that password.

Add the following output in your project, to retrieve the instance id.

```tf
output "my_cool_server_instance_id" {
  value = "${aws_instance.my_cool_server.id}"
}
```

If you now run `tf apply`, you'll have the instance id as part of the outputs. We can now use this to retrieve our password.

```sh
$ aws ec2 get-password-data --instance-id  i-xxxx --priv-launch-key ./.ssh/dev
```

```cmd
c:\MyProject\> aws ec2 get-password-data --instance-id  i-xxxx --priv-launch-key ./.ssh/dev
```

If you're on a mac, you can even launch the RDP session straight from the output, using a little script.

```sh
# Usage: ./rdp.sh my_cool_server_instance_id my_cool_server_public_ip
# make sure you have jq installed, using brew install jq

instance_id=$(terraform output | grep $1 | cut -d = -f 2 | sed -e 's/^[ ]//')

public_ip=$(aws ec2 terraform output | grep $2 | cut -d = -f 2 | sed -e 's/^[ ]//')

password=$(aws ec2 get-password-data --region us-east-1 --instance-id i-576e12cc --priv-launch-key ./.ssh/dev | jq -r '.PasswordData')

echo "$password" | pbcopy
open "rdp://full%20address=s:$public_ip&username=s:Administrator"
```

You'll still have to type in the password, but it's at least making it smoother.

[amazon-password]: <http://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/connecting_to_windows_instance.html>
[aws-key-pair]: <https://www.terraform.io/docs/providers/aws/r/key_pair.html>