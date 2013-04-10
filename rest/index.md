---
title: Practical ReST - book & class
layout: baseline
---

ReST is the architecture of the web. Heard that before? Want to understand how ReST can let you build distributed
systems, make your rich clients smarter, or simply want to design amazing ReST APIs?

"Practical ReST" is there to help. The class is an intensive 3 days of discussion, design, training and some coding
for both nodejs and .net developers (with ruby and java content available on request). The book is the natural extension
to the class. Each attendee will get the online edition of the book and access to all the reference material used during
the class.

The book is a crowd-funded project. The more funding, the faster the book will be published! You can
[order a copy now][kickstarter] on kickstarter or [read more about it](book.html).

[kickstarter]: {{site.rest_kickstarter_url}}

## Latest news

{%for entry in site.categories.rest%}
<article>
 <h1><a href="{{entry.url}}">{{entry.title}}</a></h1>
 <div>{{entry.content}}</div>
</article>
{% endfor %}
