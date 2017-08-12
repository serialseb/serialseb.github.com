---
layout: post
title: Is a Blog SOA?
tags: [soa]
date: 2003-11-11T12:15:51+00:00
---

From [Fabrice](http://weblogs.asp.net/fmarguerie/posts/36765.aspx), [Julien](http://jazbee.int.webmatrixhosting.net/PermaLink,guid,c6b774b5-3727-493d-8dc1-e10fbec1566e.aspx) which is a new comer, think his blog is a SOA service. I must say I so much disagree.

 - Services share schema and contract, not class
   This is not entirely true, and proves to be completely wrong. RSS specs are not XSD compliant, and on the other side of the pipe, XML-RPC is not schema based. It is actually far far from it.
 - Service policy is determined based on policy
   Real validation of RSS feeds can't really be expressed by XSD, and RSS is not even an infoset by it's lack of namespaces and extensibility points (Dave Winer might say something different, but...)
 - Boundaries are explicit
   Which boundaries are explicit between user authentication, posting, reading, commenting, track-backing, pinging, etc?
 - Services are autonomous
   The only point where I do agree.

The fact is, for a blog to be considered SOA, you need a two way channel, which is autonomous, and has a clear way of communication, in a message oriented way. Atom is a good step in that direction. But no, dasBlog is not yet an SOA :)
