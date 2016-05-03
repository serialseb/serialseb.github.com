---
title: Ignoring files in git, but only locally
date: 2015-05-03 11:50:00 +0100
comments: true
tags: [git]
---
I love git for one main reason: there are enough advanced commands to make nearly any problem find a solution. Ignoring some files, but only in your repository, is one of those.

For example, when doing terraform, I sometime set development-time variables in the `terraform.tfvars` file that exist for that exact purpose, say for my AWS credentials, and I really don't want the file to be committed. All the same, I probably don't want to be adding that file to the ignore list for *everyone*, which is the `.gitignore` file.

Instead, you can add your ignore to `.git/info/exclude`. I tend to do that from the command line.

```sh
$ echo 'myfolder/terraform.tfvars' >> .git/info/exclude
```
