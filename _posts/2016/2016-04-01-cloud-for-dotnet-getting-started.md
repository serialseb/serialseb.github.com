---
title: Cloud for .net – Infrastructure in source control
date: 2016-04-01 21:30:00 +0200
serial: cloud-for-dotnet
comments: true
published: true
tags: [devops, terraform, packer]
---

More and more clients are deploying their applications to the cloud. This presents many challenges for .net developers: Windows has had a poor story for remote management compared to the *nix world, AWS is less common than Azure, and the move to managing infrastructure in the cloud often comes with the extra challenge of deployment of heterogeneous environments.

Often, the phrase “chose the right tool for the job” is floated around as a practical approach to chosing technology. Yet, there are few tools that started by supporting Windows. This situation is changing rapidly, and tools like terraform and packer are starting to become practical approaches to deploying environments to the cloud.

## Infrastructure as code

When starting with AWS, many developers, myself included, tend to start by doing what they already did before: do everything manually in the AWS console, spawn new VMs, go to remote desktop, install things using whatever documentation they may have written before, or simply, and more worryingly, from memory. Each new machine deployment is time-consuming, configuration misses steps, and there is no trail of what was changed and when.

The promise of [Terraform] is to help solve some of those infrastructure problems. Instead of accessing your AWS console, you create a bunch of files that allow you to keep in source control, in code, what you would have on your AWS console. It does the same with many other providers, but I'll focus on AWS because it's what I know.

## Getting started

To get started, you need to install Terraform, and the AWS command-line utilities.

For mac, we use [home brew][homebrew].

```bash
brew update
brew install terraform
brew install awscli
```

For windows, we use [chocolatey].

```cmd
choco install terraform
choco install awscli 
```

Once brew has installed everything, you need to configure your aws secret information, which you can do the most easily using `aws configure`, it sets everything up for you to use the AWS command-line tools, which terraform and packer will also use.

## Creating your first server

We'll start with something simple that should get us a long way, creating just one server. Let's create a new project.

```shell
$ git init restflix
$ cd restflix
```

Terraform is modeled around the concept of resources. Each "thing" that exists in the AWS console can be modelled as one of the resources supported by terraform.

To create an EC2 instance, we'll need to create a new TF file, which uses a format called [HCL]: something in-between JSON and YAML, optimised for manual editing without crazy whitespace handling.

Let's start by setting up the provider itself the AWS provider itself, so we can chose the region in which we run our code.

```hcl
provider "aws" {
  region = "us-east-1"
}
```

On to spinning up a server. We start by adding an EC2 instance resource.

```hcl
resource "aws_instance" "my_cool_server" {

}
```

First, we need to decide on the instance type, which is the kind of machine you want your OS to be ran on. There are [many to chose from][instance-types], but as you may be using a free account, we'll use a `t2.micro`, which goes against your free credits.

Second, we need to know which OS image to use, which Amazon provides as AMIs. You have many to chose from, [including Windows][windows-ami], which we'll start with. Head to that page, chose your edition, and go to the "Manual Configuration" tab, in which you will find the ami-id.

Note that AMIs, or Amazon Machine Images, are per region. Each region Amazon supports has different AMI ids, so you want to make sure you chose the one for the default region on your account, which is `us-east-1`.

Putting it all together, we have our first instance ready.

```hcl
resource "aws_instance" "my_cool_server" {
  ami = "ami-3d787d57"
  instance_type = "t2.micro"
}
```

That's it. This will create a new instance for us.

## Checking all is in order

In terraform, changes to the infrastructure are done in a two-step process. First we `plan`, to see what changes terraform will make to our infrastructure.

Bring back your command line, and issue the plan command.

```
$ tf plan
Refreshing Terraform state prior to plan...


The Terraform execution plan has been generated and is shown below.
Resources are shown in alphabetical order for quick scanning. Green resources
will be created (or destroyed and then created if an existing resource
exists), yellow resources are being changed in-place, and red resources
will be destroyed.

Note: You didn't specify an "-out" parameter to save this plan, so when
"apply" is called, Terraform can't guarantee this is what will execute.

+ aws_instance.my_cool_server
    ami:                      "" => "ami-3d787d57"
    availability_zone:        "" => "<computed>"
    ebs_block_device.#:       "" => "<computed>"
    ephemeral_block_device.#: "" => "<computed>"
    instance_state:           "" => "<computed>"
    instance_type:            "" => "t2.micro"
    key_name:                 "" => "<computed>"
    placement_group:          "" => "<computed>"
    private_dns:              "" => "<computed>"
    private_ip:               "" => "<computed>"
    public_dns:               "" => "<computed>"
    public_ip:                "" => "<computed>"
    root_block_device.#:      "" => "<computed>"
    security_groups.#:        "" => "<computed>"
    source_dest_check:        "" => "1"
    subnet_id:                "" => "<computed>"
    tenancy:                  "" => "<computed>"
    vpc_security_group_ids.#: "" => "<computed>"


Plan: 1 to add, 0 to change, 0 to destroy.
```

The result tells us what terraform will do, so we can check that only the right things get created.

## Starting the instance

If you're happy with the result, check-in your code, and `terraform apply` to make the changes and wait for your windows box to come alive.

```
$ git add -A
$ git commit -m "My first windows server"
$ terraform apply

aws_instance.my_cool_server: Refreshing state... (ID: i-6c1312f6)
aws_instance.my_cool_server: Creating...
  ami:                      "" => "ami-3d787d57"
  availability_zone:        "" => "<computed>"
  ebs_block_device.#:       "" => "<computed>"
  ephemeral_block_device.#: "" => "<computed>"
  instance_state:           "" => "<computed>"
  instance_type:            "" => "t2.micro"
  key_name:                 "" => "<computed>"
  placement_group:          "" => "<computed>"
  private_dns:              "" => "<computed>"
  private_ip:               "" => "<computed>"
  public_dns:               "" => "<computed>"
  public_ip:                "" => "<computed>"
  root_block_device.#:      "" => "<computed>"
  security_groups.#:        "" => "<computed>"
  source_dest_check:        "" => "1"
  subnet_id:                "" => "<computed>"
  tenancy:                  "" => "<computed>"
  vpc_security_group_ids.#: "" => "<computed>"
aws_instance.my_cool_server: Creation complete

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: terraform.tfstate
```

And voila, you have your first windows server, all in source control.

## Turtles, all the way down

As it stands, the machine can't be remoted into, so you can't really do anything with it. Let's make sure you don't pay for a running instance that you have no use for, we're going to destroy it all.

```
$ terraform destroy

Do you really want to destroy?
  Terraform will delete all your managed infrastructure.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_instance.my_cool_server: Refreshing state... (ID: i-bc171626)
aws_instance.my_cool_server: Destroying...
aws_instance.my_cool_server: Destruction complete

Apply complete! Resources: 0 added, 0 changed, 1 destroyed.
```

Here we go, after confirming, to make sure sure sure you are not making a terrible mistake, the whole thing is going down. That was easy wasn't it?

[windows-ami]: <https://aws.amazon.com/windows/resources/amis/>
[instance-types]: <https://aws.amazon.com/ec2/instance-types/>
[chocolatey]: <https://chocolatey.org>
[homebrew]: <http://brew.sh>
[HCL]: <https://github.com/hashicorp/hcl>