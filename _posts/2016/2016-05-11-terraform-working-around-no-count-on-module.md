---
title: Working around the lack of count in Terraform modules
date: '2016-05-11 16:50:00 +0100'
comments: true
tags: [terraform, devops, aws]
---
Terraform modules  do not currently support `count`, and so reusing a module a dynamic number of ways is impossible. To work around this, we can rely on a small DSL and `null_resources`.

Same advice as previous entries apply, this is advanced stuff, harder to read and more complex, use with caution and for good reason.

Let's imagine that I have a module that spins up a variable number of machines, one per release branch in my source control system. Due to the dynamic nature of this, and without access to `count` on module, i'd either have to use a templating language, something i'm not happy doing, or I'd use a little dsl.

I'll define my module with a variable called instances, with a format I invent, a coma-separated list of instance names and their instance types, themselves separated with a colon.

```
variable "instances" { default = "webserver:t2.micro,api:t2.small" }
```

We already know that `split` allows us to have collections by splitting strings, so the initial, and pretty unreadable, first step is to abuse string interpolation as is.

```tf
resource "aws_instance" "servers" {
  // number of servers is simply the string split by coma
  count = "${length(split(",",var.instances))}"
  // name is the first bit in each string
  name = "${element(split(":",element(split(",",var.instances),count.index)), 1)}"
  instance_type = "${element(split(":",element(split(",",var.instances),count.index)), 1)}"
}
```

My brain has already melted. Things get a bit easier if you pass lists around, but not that much.

One alternative is to create a instances and instance_types variables, keeping two lists in sync makes interpolation a bit less obtuse, but as a user makes things pretty hard to get right.

Another one is to use the less-known `null_resource`. We abuse its triggers a little bit by doing the splitting there instead, which allows us to give nicer names to things.

```tf
resource "null_resource" "let" {
  // we reuse this in all counts because count only interpolates from variables
  count = "${length(split(",",var.instances))}"
  triggers {
    // we do the coma splitting here text splitting here
    server_raw = "${element(split(",", var.instances),count.index)}"
  }
}
resource "null_resource" "servers" {
  count = "${length(split(",",var.instances))}"
  triggers {
    // we do the colon splitting here
    name = "${element(split(":",element(null_resource.let.*.triggers.server_raw, count.index)),0)}"
    instance_type = "${element(split(":",element(null_resource.let.*.triggers.server_raw, count.index)),1)}"
  }
}
```

We've now kept all the nasty string processing somewhere away from our resources. It has an added bonus, the tf plan is rather useful to read:

```tf
+ null_resource.let.0
    triggers.#:          "" => "1"
    triggers.server_raw: "" => "web:t2.micro"

+ null_resource.let.1
    triggers.#:          "" => "1"
    triggers.server_raw: "" => "app:t2.small"

+ null_resource.servers.0
    triggers.#:             "" => "2"
    triggers.instance_type: "" => "t2.micro"
    triggers.name:          "" => "web"

+ null_resource.servers.1
    triggers.#:             "" => "2"
    triggers.instance_type: "" => "t2.small"
    triggers.name:          "" => "app"
```

We can now declare our instances using some better symbolic names.

```tf
resource "aws_instance" "servers" {
  // kept so we can interpolate correctly
  count = "${length(split(",",var.instances))}"
  
  name = "${element(null_resource.servers.triggers.*.name, count.index)}"
  instance_type = "${element(null_resource.servers.triggers.*.instance_type, count.index)}"
}
```

If you can't avoid the complexity, with this trick you keep it localised and more readable. Terraform will soon allow lists and maps passed to modules, but count is still somewhat far off. If you're interested in an alternative syntax I suggested, check out the [github issue][ghlet].

[ghlet]: <https://github.com/hashicorp/terraform/issues/4084>