---
title: Passing empty arrays to resource arguments in Terraform
date: '2016-05-10 15:04:00 +0100;
comments: true
tags: [terraform, devops, aws]
---
The interpolation syntax of terraform allows you to do many other things to make your modules reuseable, but one of the common problems we find is passing empty strings from variables in arrays.

Note that the strange syntax I show you are obtuse, and while someone who has done terraform for a while may well recognise the patterns, they're non-obvious and come with an increased cost in complexity and maintenance. Make sure you make the right decision between all the costs associated with reuse.

So let's say you have a module that registers an auto-scaling group, but you want to allow module consumers to pass an elastic load balancer they defined themselves. The naive approach would be to just pass it in the array attribute.

```tf
variable "elb" { default = "" }
resource "aws_autoscaling_group" "asg" {
  // stuff here
  load_balancers = ["${var.elb}"]
}
```

If you try to apply this, it will return an array of 1 with an empty string, which is not what the api expect.

The trick here is to force turning the string in an array.

```tf
resource "aws_autoscaling_group" "asg" {
  // stuff here
  load_balancers = ["${compact(split("",var.elb))}"]
}
```

And voila, an array of 0 or 1 element. Note that this problem will go away with terraform 0.7, as modules will be able to take lists as variables.
