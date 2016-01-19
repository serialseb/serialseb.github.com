---
layout: post
comments: true
published: false
title: VeST - The Tenets of Vertical Slice Technologies
serial: vest-redux
---

Once upon a time, I blogged about my homegrown approach to [designing systems using VeST][designing-systems]. The comments are very clear: it's not much about testing, it's a way of designing software, and everybody does a bit or a lot of it, and it already has many names. The approach has matured quite a bit over the last couple of years, so I think it's time we refresh the concept and delve deeper into how to build things in that way, and why. So without further due, I present you:

## The Tenets of Vertical Slice Technologies

Building systems is a complex endeavour. Vertical Slice Technologies is a holistic approach to designing specification-driven applications iterating over small features and simple systems.

We value:

  - **iterative**: building and deploying small features quickly and iterating on a problem,
  - **composition**: building autonomous components that can communicate and work together in a monolith or spread over a distributed network,
  - **mvp**: features of the smallest possible size that can bring value by being deployed,
  - **fishing line**: building as quickly as possible a line through the implementation of a system, to put in place all the required components, and grow them as the featureset grows,
  - **kiss**: building the simplest possible system that can work for a feature,
  - **BDD**: specification-driven development, where each feature behavior is specified in code, and where specifications describe what the code does and what to expect, rather than how it does it,
  - **no mocking**: providing alongside our libraries and services, in-memory fully-featured versions people can use in their own code-base, using the same testing rig we use to build our library, so our consumers do not have to mock APIs themselves,
  - **test rigs**: providing, alongside our libraries, the test suite for components consumers can implement, so that they don't have to reverse-engineer the expected behaviour of the extension point we provide.

This is the approach I've settled on, both personally and with my teams. This serial of blog posts will try and deep dive in the many _how to_ questions these ideas combined together may trigger.

[designing-systems]:<http://serialseb.com/blog/2013/07/11/unit-testing-is-out-vertical-slice-testing-is-in/>
