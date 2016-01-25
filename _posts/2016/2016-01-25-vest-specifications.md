---
layout: post
comments: true
title: VeST Redux – Specification-driven development
serial: vest-redux
date: 2016-01-25 12:30
published: false
---

Building software is easy. Really, it's just a matter of writing a bunch of statements that do something, and voilà, you have a running program. Building the right software is where the complexity lies.

Too often, we fail at building the right thing, and in my experience this has always come from poorly communicating what the software ought to achieve.

On the technical side, test-driven design has made great progress in becoming a mainstream approach to delivering simpler systems, and that's great when you think back on where we were in the early 2000s. Yet, more often than not, the resulting test suites can become brittle, poorly maintained, hard to read and refactor-unfriendly.

So over the years I've refined a methodology to try and address, or at least minimize, both issues.

## Features

There is a French saying, “Ce qui se conçoit bien s'énonce clairement”, which translates roughly to 
