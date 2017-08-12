---
layout: post
title: Versionning and WinFS
tags: [winfs]
date: 2003-11-27T09:59:51+00:00
---

[Here](http://blogs.gotdotnet.com/jmazner/PermaLink.aspx/4959aaae-365d-4bc4-985c-057594b97d8c), Jeremy asks if we want versioning in the file system.

Let’s think about what exactly ins WinFX and WinFS targeted at, in term of product strategy. That’s right, including more of the common tasks in the OS. Go over the simple “The OS deals with hardware, for everything else you need to add stuff”. Word uses versioning and reviewing. Excel would. Aggregators like newsgator would too. I would love to be able to undo changes to a file I did, even after saving and quitting my application. Versionning is a must, in the delta form obviously. Don’t only do it on text, but also on any binary file. Add an extension to the WinFS type handler for the application developer (understand, me), to implement it. Then show it in the shell, as a stack. Ask the user which version he wants to see (simple form of a checkout), or let the application deal with it too.

Yes, obviously, this should really be optional. Set either by the application or by the user for applications not supporting it natively. Real source control. And don’t call it either versioning or source control. Call it… Well, call it something that makes sense to my mother, and that I can read without being annoyed. You’re the smart guys and I’m not in Redmond yet :-)
