---
layout: post
title: TDD and Databases
modified:
categories:
excerpt:
tags: [testing]
image:
  feature:
date: 2003-11-11T14:28:30+00:00
---

I've read quite a lot of bloggers ([here](http://dotnetjunkies.com/WebLog/seichert/posts/3420.aspx) for example) complaining about removing records from their test database.

Most of them go through some of the nifty SQL features that are VERY VERY VERY handy. How about this, you prepare your database, and save it as an mdb file... That, for example, you include as a resource in your preferred source control system.

Then, when testing your file, you copy it, and in your unit test, you use the following connection string in SqlClient:

Initial File Name="YourPath:\YourFile.mdb"

Then you can discard your whole file after working on it. As simple as you can get.
