---
date: 2016-01-15 12:00:00
comments: true
title: Rebuilding SerialSeb.com – Comments
serial: rebuilding-serialseb-com
published: false
---
With all my prose migrated, it was only fair to try and migrate yours!

When codebetter.com migrated over to wordpress, I moved over to [disqus][disqus]. One less thing to do, and anything reducing spam was a *good thing*.

# Adding disqus to the new site

As the [Minimal Mistakes theme][minimal-mistakes] comes with disqus support, it's only a matter of editing your `config.yml` to use your disqus shortname (which, for some unexplained reason, on my blog, was called codebetterblog, which is going to be very confusing I'm sure).

```yml
owner:
  disqus-shortname: codebetterblog
```

# Migrating the wordpress entries

The next step is to tell disqus that I moved the entries from the codebetter blog to their new URIs. For this we need a mapping between old and new, in CSV no-less, because there is no way I'd do that manually.

Remember how in the previous part I used the tools to migrate the entries to jekyll? One cool side-effect of using those scripts is an extra header added just for WordPress blog. For example, the header for my perenial post on Vertical Slice Technologies contains this jekyll front matter.
```
---
comments: true
date: 2013-07-11 08:54:32+00:00
layout: post
slug: unit-testing-is-out-vertical-slice-testing-is-in
title: Unit testing is out, Vertical Slice Testing is in
wordpress_id: 169
---
```
When I migrated, I elected to keep the new blog entires in the `/year/month/slug/` format, which codebetter was already using, so to generate the csv, I put the following code in a file in my site and left jekyll to do the hard work.
```
{%for post in site.posts %}{% if post.wordpress_id %}http://codebetter.com/sebastienlambla/{{post.url | remove: "/blog/" }}, http://serialseb.com{{post.url}}{%endif%}
{%endfor%}
```
Upload to disqus, and we're done. I've also enabled the option in disqus to only allow comments from serialseb.com, to make sure no one accidently revived the old post comments.

[disqus]: <>
[minimal-mistakes]:<>
