---

comments: true
date: 2011-09-04 23:52:06+00:00
layout: post
slug: summer-holidays-are-over-time-for-a-new-roadmap
title: Summer holidays are over, time for a new roadmap
wordpress_id: 66
---

As many of you many have noticed, things have stalled a bit over the summer on the master branches of openrasta and openwrap. While our amazing contributors are still sending pull requests and development has continued, as the owner of the master branches I’ve not been there to maintain the new packages, as I decided to take the summer slow and learn how to*rest*.

Now that the summer is over, I’m glad to clarify the roadmap for OpenEverything frameworks:

 - OpenWrap 2.0 with ReSharper support and cached remote implementation is nearly done, but a lot of features planned for 2.0 will be rescheduled for future versions. I expect a release for this in the next two weeks.
 - OpenRasta 2.1 work is coming along nicely, with all the bug fixes that have been suggested, and some extension points that will be needed for the work on 3.0 to start. I expect that work to be completed by the end of September. I’ll also make OpenRasta available on NuGet, although it *will* auto-install OpenWrap in your solution.

We’re dropping .net 2.0 support, as it’s been out of the binaries for a while and no one has requested them back, so I’ll assume no one needs that anymore. Note that some work is going in this release that will let OpenRasta manage in-memory / caching automatically, so if your code depends on the request or response stream being seekalbe, I’d start making some changes now.

	- OpenRasta 2.2 will be next, and again we’ll take any additional enhancements that don’t break binary compatibility. I’d like to continue taking those changes and start doing per-feature or per-bugfix releases.
	- OpenRasta 3.0 is going to be where heavy rewriting is going to happen in parts of the API I don’t like, and we’ll take the luxury of redesigning and renaming / refactoring what needs to be (for example, IType et al will probably disappear and be replaced by a simpler model, the key/values binding model will be updated to provide additional information and extensibility points for those crazy people wanting a plug-in validation framework).
	In order to guarantee that  your components using OpenRasta 2 will still work on 3, we’ll be type-redirecting the published extensibility interfaces that are changing into a 2.0-specific legacy API package. In other words, we’ll plug most of the existing contributors, codecs, interceptors, decorators and all other non-generic interfaces straight in the new API, using the same composition engine that will be used by OR 3.0 itself.
 - OpenHttp and OpenWebFx are the two components that will provide the basis for OR 3. The former is an extension of the unified hosting environment OpenRasta already has been using for two years, and allows hosting across HttpListener, TCP, IISCore, asp.net and in-memory, based on an async pull mechanism (as opposed to, say, OWIN which is push based, one of the two reasons I’m not implementing OWIN myself). OpenWebFx is the building blocks of a web framework, aka provides the http pipeline model and a couple of building blocks that are core to OpenRasta (codecs, media types, content negotiation…). This will leave OpenRasta itself as a combination of many packages and a bit of custom code on top of it (mainly, the registration API).
Code will be out when it’s out, I make no promises, but do expect to see beta versions running on the beta openwrap package repository by the end of the year.
 - Everything else is already in the process of migrating to its own packages, so you can expect a first release of OpenContainer (the IoC type resolving compatibility layer) and associated releases to appear around the OR 2.2 timeframe. You can also expect a diagnostics package for OR 2.1 (pluggable of course, named openrasta-diagnostics), a 2.1-specific devtools package (that installs the templates to create projects and solutions thanks to OpenWrap project manipulation), a temporary openrasta-fluent package that contains the new and more compact registration API (which will be type redirected back in the 3.0 API as a replacement for the old syntax), a couple of codecs that will be maintained by us (openrasta-codecs-jsonnet for example, with support for anonymous types and dynamics), etc. Some of those packages (such as our support for Unity, StructureMap, Windsor and Ninject) will be looking for new owners as I start delegating a lot of the package releases to whoever wants to manage them.


This is the schedule for the end of the year, no guarantee implied, as any work I do for clients drives those two frameworks as a priority. If you’re interested in sponsoring some work on OpenEverything for your own needs, please do let me know, we can always figure something out.
