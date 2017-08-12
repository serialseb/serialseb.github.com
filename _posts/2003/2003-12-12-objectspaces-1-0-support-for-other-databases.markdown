---
layout: post
title: ObjectSpaces 1.0 Support for Other Databases
date: 2003-12-12T08:35:00+00:00
---

[Andrew](https://web.archive.org/web/20040215203222/http://blog.thetechnologist.net/ct.ashx?id=5b3519c7-154d-4b84-a751-5fe20323b53d&url=http%3a%2f%2fweblogs.asp.net%2faconrad%2fposts%2f42922.aspx) reports that version 1.0 of object spaces (the ORM technology to be provided with Whidbey next year) will only support SqlServer 200 and Yukon (the next generation of SQL Server for those of you who might be a bit lost with the 10+ new code names Microsoft is playing around with lately).

Scott [comments](https://web.archive.org/web/20040215203222/http://blog.thetechnologist.net/ct.ashx?id=5b3519c7-154d-4b84-a751-5fe20323b53d&url=http%3a%2f%2fwww.lazycoder.com%2farticle.php%3fstory%3d20031212011303281) on the question, why didn’t Microsoft include support for other databases when they already have managed providers. I would go further by quoting Andrew:

 > However, that said, we have designed an underlying architecture that could be extended to other datasources, even non-relational datasources.

To quote myself a bit, I’ve been saying for a long time that whenever you code an intelligent and clean architecture, you should at least provide an unsupported documentation on how to extend the current mechanism by replacing some components. My question would be, why don’t you open the extensibility points for other people to extend ObjectSpaces?
