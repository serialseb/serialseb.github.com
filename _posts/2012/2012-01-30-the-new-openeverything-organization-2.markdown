---
comments: true
date: 2012-01-30 11:51:44+00:00
layout: post
slug: the-new-openeverything-organization-2
title: The new OpenEverything organization
wordpress_id: 122
tags: [openrasta]
---

OpenRasta has been there for many years, and is the most widely used alternative framework for ReST applications.

OpenWrap has been there for a year and a half, and has some usage for advanced users wanting a nicely-architected package manager that doesn’t take dependencies on lots and lots of other technologies and doesn’t require VS.

And we have sub-projects, such as OpenFileSystem, an IO abstraction library that ought to make using the file system easier, shipping with an in-memory version that should work the same way as your target operating system.

Now all those projects are at varying stages in their life, and the amount of work I used to give to only OpenRasta has been vastly disolved, which in turns means that some users are [starting to get quite annoyed](http://dgondotnet.blogspot.com/2012/01/rest-raiding-openrasta.html) with our dreadful homepage and our lack of binary downloads.

Add to this the competitive pressure on OpenRasta introduced by Nancy and the future openrasta copycat WebAPI from the photocopier machine Microsoft, and you’ll understand that the current trend is not sustainable.

This year I’ve decided to simplify my life and delegate much more of my work to a community that has been so far very supportive but very unwilling to contribute anything back. I also want to go back to enjoying working on OSS software to build great solutions and not focus my energy on simply competing with any tool and framework microsoft invents to duplicate existing OSS solutions. I have a vision and I want to deliver on that, OpenRasta and OpenWrap are two sides of that, and I want to start making them work together the way I want without having to be dragged in competitive races with Microsoft’s marketing dollars.

So we had a planning meeting with some of the companies that use OpenRasta in anger in London and want to step up their contributions ([7digital](http://www.7digital.com/) and [huddle](http://www.huddle.com/), we love you guys!), and decided that we were going to change how things are done in the OpenEverything projects.

## Project organization

First and foremost, I’m going to contribute much less to the 2.1 branch of OpenRasta, and patches / merges / new builds are going to be handled by the contributors that are given write access to the git repository. This gives away a lot of my power.

I’m going to be focusing on the outstanding modules for OpenRasta that add a whole bunch of functionality that will be rolled-back in 3.0: the caching module (soon to arrive in 0.2 version), the new config API (with compact fluent API and convention-based config) and the dynamic / json out-of-the-box support. There’s also a new openrasta-diagnostics module that I’ve started building and want to get out there. I’ll also contribute some work towards the async support that has been requested by some.

OpenFileSystem 2.0 is going to be under Henrik Feldt supervision, and will be a merge of the amazing work he did on long-path and transactional file system support.

All of our versioning is going to be a strict application of [http://semver.org](http://semver.org) 2.0 (which is now the only standard in OpenWrap), so that will solve any breaking changes being introduced without knowing.

Of course, OSS is not a democracy, so I keep a veto right on certain changes that would impact future versions, or architectural changes that do not fit with the vision I have for all those projects. This is give and take, I give some of the control of more than 4 years worth of my development time, but I will keep the main architect role for the time being.

As for releases, anytime someone with commit access wants to create a new release, the process is very simple: they email on the mailing list, and if there’s no majority opposition, we have a new build. Simples.

## Orphaned projects

Sadly, we do have some orphaned projects in all this. Mostly, the container support for each of the IoC containers is not up-to-date for StructureMap (tests are broken) and Unity (I have no understanding of the code, so while I *think* I fixed the latest build, I can’t try it out). At this stage, anyone with a vested interest in those projects should start contributing and come help out, or risk that code not being maintained anymore.

## OSS is not just take, it’s give too

That leaves a real question for those companies that have used OpenRasta to make money and provide a killer-architecture and have contributed absolutely nothing back since the beginning.

I’ll let you in on a little secret. I give the code away on everything, so it is a company’s legal right to take and not give back. As a side-effect, it is my complete right to completely ignore those that make money on our hard work and want to keep it all to themselves, and my responsibility to not prioritize the needs of those that contributes over those that are selfish..

OSS is also about giving back, and this year it’s what is being enforced on the OpenEverything projects. Fostering contributions is what we want to get to. No more free-lunch though, that’s for sure.

## Conclusion

This new organization should let OpenRasta absorb patches and get on the 2.1 release cycle faster, and then on to 2.2, etc. This will allow me to focus on what I want to build for 3.0, and this will also allow more contributors to own projects more directly than before.

If you have comments or feedback on all those new plans, please let us know on the now unified [openeverything-dev mailing list](http://groups.google.com/group/openeverything-dev/topics).

_Please don’t use it for user questions, we’ve moved all support of all those frameworks to stackoverflow where google can do its job and users can find their answers more quickly._
