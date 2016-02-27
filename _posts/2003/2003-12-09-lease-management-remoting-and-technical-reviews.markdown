---
layout: post
title: Lease Management, Remoting and Technical Reviews?
modified:
categories:
excerpt:
tags: [remoting, .net]
image:
  feature:
date: 2003-12-09T15:50:10+00:00
---

Interesting read on msdn: http://msdn.microsoft.com/msdnmag/issues/03/12/LeaseManager/default.aspx

To be honest the article is good and explain a not so well known side of remoting. But but but, frankly, this is frightening:

In fact, even in the case of a client in one AppDomain accessing an object in a different AppDomain (but in the same process), garbage collection still works because in the same process all AppDomains share the same managed heap.
Now this sentence could have been “garbage collection could still works”. The reality is that, as soon as you cross your AppDomain, wherever you are and whatever you intend on doing, whatever your process name, you WILL go through the lease management system. Even in intra process calls. This is the reason why 80% of the plug-ins architectures relying on secondary AppDomains just fail miserably and why you get so many questions about RemotingExceptions on the microsoft newsgroups…
