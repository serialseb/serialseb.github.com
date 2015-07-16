---
author: sebastienlambla
comments: false
date: 2011-01-05 19:52:00+00:00
layout: post
slug: strong-naming-assemblies-and-openwrap
title: Strong-naming assemblies and OpenWrap
wordpress_id: 32
---

One of the design principles of OpenWrap is not only to be a glorified _Add Reference_ dialog, but to provide a better way of dealing with dependencies, both at compile-time and at run-time.

When it comes to assemblies, it means we need to be able to choose which assembly you get when you run code. This allows for swapping assemblies based on the version of .net you’re running on, or what platform (x86, x64, unix, osx, etc).

The problem is, on .net, if you strong-name your assemblies, .net will assume that you really meant that one and only that one assembly you compiled against. This prevents us from swapping assemblies as needed based on your environment.

At the time those decisions was made, the unit of deployment was indeed the assembly, and the reasoning was to try and solve the dll-hell that has existed for a long time on windows. At that time, it was probably an acceptable idea, just like at some point in my career I thought webforms were a good idea.

When you switch to a package-based world, the decisions made by .net are getting in the way. If you try to load MyAssembly.dll version 2, and you compiled against version 1, the code will just never, ever be loaded.

## Assembly redirection

One way to solve this problem is assembly redirections. You update a .config file for your application, and you redirect version 1 to version 2. If you’re owning the config file and the application, and are only interested in build-time resolution, as is the case with the Visual Studio NuGet tooling, then that’s fine. We could even add it to OpenWrap in an hour or two and be happy with it.

Does that work for my plug-in for a WPF composite application? Does that work for replacing the version of a package used by my web server in serving html pages in my hosted environment?

The short answer is no. The long answer is that we really think that signing assemblies when using a package manager takes away the decisions from the package manager and prevents a good user experience.

That is why, in OpenWrap, we warn you against signing your assemblies when you create a package. If you don’t sign things, everything is easier, as we can make the right decisions the CLR fusion loader cannot make itself by design.

## The path forward

We do understand that some customers have corporate policies enforcing that all assemblies should be signed. We also do know that some assemblies out there, for which there is no package, are already strongly-named.

So what is the path forward for OpenWrap? It’s going to depend very much on feedback from developers.

If you want type redirection to be automatically generated for your .config file, at build-time, we’ll add that. It’ll be full of big yellow letters warning you you’re probably not doing the right thing, but it could be there if you need it.

Another thing you can do right now is publish one package with unsigned assemblies, called MyProject.wrap, and another one called MyProject-signed.wrap. Whenever one of your customers want the signed version, they can simply do a dependency override, by specifying “override: MyProject MyProject-signed” in your descriptor. Any package you reference that references MyProject will now get the signed version. This is available now and has been available for months.

Finally, post v1, we will have an extra, more involved approach to it, that will be optional and one that David Ebbo has mentioned in his recent blog posts. You’ll be able to specify in your descriptor that you want everything resigned, and whenever a new assembly is found in a new package, OpenWrap will re-sign the assembly with a key you provide. The process will not touch any existing signed assembly, but will go and re-sign all the assemblies you need with your own key. We will also provide an –unsign flag to the build command to strip-off any existing strong-naming from assemblies when you create a package.

## Conclusion

OpenWrap is an open, community-driven OSS projects with a great track record of offering the best technology, and being completely open to other solutions so that **you never get locked in**, either by an IDE vendor or in an out-dated technical environment. We understand the problems you’re facing in your organization, we have the same ones and that’s why we build this thing, out of need.

If you think we’re heading in the wrong direction, or if you want to cheer us a bit, as usual please come and talk to us on the [mailing list](http://http://groups.google.com/group/openwrap-devel), or comment on this blog post. We are by and for the community, always have been. We really want to continue being the most pain-free and most productive dependency management system on .net.
