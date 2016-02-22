---
title: Are SPAs dead?
published: false
comments: true
---

Link http://www.infoq.com/articles/no-more-mvc-frameworks
http://www.infoq.com/news/2015/11/daniel-jacobson-ephemeral-apis



An interesting conversation has been going on on twitter. You know when you always say ”This is just not the right medium, I'll blog about “. So I did. I'm going the long way around but I'd ralther go for clarity here.

The browser is a wonderful piece of technology that, over the last 21 years, has passed the test of time. It's principle is rather simple: display media types like HTML the best it can, and allow people to navigate away from the current document to the next document by clicking links.

When AJAX started appearing, much was made of finally being able to navigate without causing a hard refresh. This was the beginning of the development of a lot of code to expose _all the data_ in XML, all rendered by lots of code that was also written, in the [best language in the world][javascript-crockford], Javascript.

We used to build simple HTML, and add javascript on top of to make the state transitions smoother, and not cause as much of a page refresh. In that process we were losing a while bunch of things: the browser state was not preserved between transitions (values in forms, scroll position, history management), the links were all but gone, but it worked and it looked more like a windows "App".

Then someone had the idea (probably the guys that built outlook on the web, as they invented `XmlHttpRequest` to start with) to create single resource applications, aka a single page loading everything from an API. Problem solved, because angular?

Unfortunately, deploying an application by pushing a single page to the client, together with its tens of megabytes of javascript, made things even worse. Not only had we lost links and browser state, now we also lost two more things, maybe even three: progressive rendering was but gone, initial data was gone

[javascript-crockford]:<http://www.crockford.com/javascript/javascript.html>
