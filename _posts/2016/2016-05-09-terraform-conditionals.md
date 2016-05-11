---
title: Creating Terraform resources conditionally
date: '2016-05-09 18:30:00 +0200'
comments: true
tags: [terraform, devops, aws]
---
Terraform has modules, and they are both insanely great and absolutely infuriating at times.

When you split your logical resources in modules, you often want to make sure you make them configurable, bh aving some resources only generated when you set a flag in a variable.

```tf
variable "create_server" { default = true }
resource "aws_instance" "insanely_great_server" {
  count = "${var.create_server}"
}
```

This works throught the magic of variables of type boolean being parsed as 0 or 1 when `ints` are involved, such as in count. So far so good. But what if you want to create a resource only when a variable is *not* set, say, if you wanted to pass an elastic IP address to a resource, or let it create one.

```tf
// let's create the variable, defaults to nothing
variable "eip" { default = "" }

// create an eip if none was passed
resource "aws_eip" "maybe_eip" {
  count="${replace(replace(var.nat_eip,"/.+/","0"),"/^$/","1")}"
}

// and finally, use the eip or the created one
resource "aws_nat_gateway" "nat" {
  allocation_id = "${coalesce(var.eip,aws_eip.maybe_eap.id)}"
  // and other stuff here
}
```

As any good developer knows, when you're stuck in a corner, if you have regex, you now have +* problems but at least one solution.

Here, we use regex to turn any `(.+)` string into `0`, so if an eip was passed we don't create anything, and if that didn't work out, we turn the empty string `^$` into a 1.

Only thing left to do is to coalesce, aka to take the first non empty string in the list, trying first the passed-in eip, and second the created eip.

Morale of this tale, when a resource has a `count` of 0 or 1, it's just like an `only_if`. For more information, check out the [github issue][issue] with the proposed future of conditionals.

[issue]: <https://github.com/hashicorp/terraform/issues/1604>