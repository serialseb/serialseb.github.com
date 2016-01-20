---

comments: true
date: 2012-02-16 22:39:08+00:00
layout: post
slug: http-caching-is-complicated-for-everyone
title: Http Caching is complicated for everyone
redirect_from: "/blog/2012/02/16/http-caching-is-complicated-for-everyone-even-ayende/"
wordpress_id: 126
---

As you may know, one of the talks I’m giving this year is _HTTP caching 101_.

I feel it’s important to educate everyone on HTTP. One of the interesting things is the fact that the spec names things in a very, well, strange way.

Take my good friend Ayende that complains about Silverlight [not respecting the HTTP specification](http://ayende.com/blog/4755/silverlight-and-http-and-caching-oh-my). Now I think everyone will agree that Oren is a brilliant person, so if he gets it wrong, it’s probably the spec that sucks. Point is, silverlight is not necessarily wrong in this case.

See, a resource representation (the thing that is controlled by caching instructions) can be in three states: Up-to-date, fresh and stale.

Up-to date representations are the ones that we know are current _according to the origin server_.

When a representation is being sent back with no expiry and no caching instructions, it’s allowed (and encouraged) to cache it for however long an implementation may decide, it’s left up to the developers. The spec encourages using heuristics for this. If you want something more reliable, you should provide a max-age or an Expires (or ideally, both).

Now, as long as the representation hasn’t expired, it’s considered by caches (proxies or your browser cache) as fresh.

Now that’s where things become confusing. When you send back a **must-revalidate** with your response, it doesn’t mean that the client needs to revalidate at all times with the server. It means that a client needs to revalidate **once the representation is stale**, aka it has gone over it’s expiration date. In the case ayende shows here, the client makes the decision that the data was cacheable previously (I’d think that the response would’ve had a Last-Modified so heuristics could kick in), and so doesn’t see the point of asking the server to validate a fresh cache entry. This is why when Oren added the Expires header in the past, the entry became stale on arrival, making must-revalidate work as expected.

So what if you want the client to revalidate always before serving a cached entry? In that case, you can send a **no-cache**, which of course doesn’t mean do not cache. It means that the client needs to revalidate both fresh and stale entries, and then may use the cached copy if it’s up to date.

So to sum up: no-cache doesn’t mean do not cache, must-revalidate doesn’t mean always revalidate, most people get http caching wrong because it is not intuitive Thankfully, if you come to [my talk](http://vimeo.com/36409207), or my [ReST training course](http://skillsmatter.com/course/open-source-dot-net/building-rest-architectures-on-dot-net), or use the [openrasta-caching](https://github.com/openrasta/openrasta/wiki/caching) plugin, you won’t have to care much about those problems.
