---
title: Rebuilding SerialSeb.com – Serials
serial: rebuilding-serialseb-com
---
You may have noticed a list of other blog entries in this serial just above (provided I don't update the design again).

One thing I wanted to do was to automatically group posts together that are part of one story arc. I call those serials.

To do that, each of my post that is part of a serial may have an additional instruction in the front-matter.

```
---
title: Rebuilding SerialSeb.com – Supporting Serials
serial: rebuilding-serialseb-com
---
```

One of the powerful features of Liquid Templates is its capacity to use extended metadata you define in each post, and make it available at templating time.

For the list of entries in the serial, i created a new include file in `_includes/serial/toc.html`, that creates the master list of all posts part of a serial.

First, it's included in the template for a blog post, somewhere in `_layouts/post.html`.

```
{%include serial/toc.html post=page %}
```

Here, i assign the post variable to the page object, so I can reuse the same TOC be it that I'm in a page or enumerating over posts.

```
{%raw%}
{%if include.post.serial %}

{% assign postsInSerial = site.posts | where: "serial", include.post.serial | reverse %}
Part of a serial:
<ol>
{% for post in postsInSerial %}
{%assign cutoffTitle = post.title %}
  <li>
    {%if post.url == include.post.url%}<b>{{cutoffTitle}}{%endif%}</b>
    {%if post.url != include.post.url%}<a href="{{post.url}}">{{cutoffTitle}}</a>{%endif%}
  </li>
{%endfor%}
</ol>
<hr/>
{%endif%}
{%endraw%}
```

Filters like `sort`, `reverse` and `where` are used to filter out from the post collections, but they only work if you assign the filtered list to a new variable. If you try it in the `for` it just doesn't work. That's 12 hours lost right there.
