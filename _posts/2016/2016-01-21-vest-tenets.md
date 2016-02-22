---
layout: post
comments: true
title: VeST Redux – The Tenets of Vertical Slice Technologies
serial: vest-redux
date: 2016-01-21 16:57
tags: [vest]
---

Once upon a time, I blogged about my homegrown approach to [designing systems using VeST][designing-systems].

I've implemented this stack of practices on quite a few projects over the years, and I've been pushed to formalise it's definition. Why coin a term? Because it's easier to talk about a package when it has a name, and I find those things useful as a package.

Those practices are all anchored in XP and other agile practices, and I have gotten an enormous mileage from using them. I believe sharing what I think I stumbled upon is a great way to move the goal post ad continue the conversation.

## The Tenets of Vertical Slice Technologies

Building systems is a complex endeavour. Vertical Slice Technologies is my holistic approach to designing specification-driven applications, iterating over small features and simple systems.

I value the following software principles:

  - Building and deploying small features quickly and **iterating** on a problem.
  - Building **composeable** autonomous components that communicate and work together in a monolith or spread over a distributed network.
  - Prioritising **Minimum Viable Product** features of the smallest possible size that can bring value by being deployed.
  - Building as quickly and as early as possible a line through the implementation of a system, a **fishing line** or **tracer bullet** to put in place all the required components as early as practical, and grow them as the feature-set grows.
  - Focusing on **Keeping It Simple Stupid** and design the simplest possible system that can work for a feature.
  - Discover with the business and the teams what each feature ought to do and what acceptance criterias are upfront, using **Behaviour-Driven Design** approaches, and encode them in the code where they are the sole source of truth of the understanding of a system.
  - Providing, alongside our libraries and services, in-memory fully-featured **Production-grade fakes** people can use in their own code-base, the same we use to build our systems, so our consumers do not have to mock APIs themselves.
  - Providing, alongside our libraries, **test rigs** for components consumers can implement, so that they don't have to reverse-engineer the expected behaviour of the extension point we provide, and use them ourselves in our implementation.

This blog post serial will deep dive in _how to_ build a system that follows those principles, not as the sole way of doing it, but as the way I found to be useful.

Thanks for all the reviewers that have spent some time giving me feedback on this entry, you know who you are.

[designing-systems]:<http://serialseb.com/blog/2013/07/11/unit-testing-is-out-vertical-slice-testing-is-in/>
