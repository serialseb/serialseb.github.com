---
layout: post
title: Rebuilding SerialSeb.com – Importing content
comments: true
tags: serialseb.com, jekyll
serial: rebuilding-serialseb-com
date: 2016-01-12 10:17:00
---
I have to admit to being a bit of a digital hoarder. I keep digital copies of everything, and I have bits of code, svn repos and backups all the way to 2001. It probably comes from the fact that I had a big crash of my raid0 data around that time and lost everything. I still have pst files and backup archives of an old exchange server with years of emails that i've not managed to recover just yet, but eventually I will!

But I disgress. The first step in getting serialseb.com in shape was to decide what content to import. Over the years, I've moved my blog forward without taking much care in moving the old posts, resulting in four different blogs over the years. The one-stop-shop mantra of the blog design's principles means there was no other solution than to bring it all.

## Jekyll

I have gotten a lot of benefits from the combination of github-pages, jekyll and liquid-templates, the first time I designed the site, so I decided to stay on the platform. Static scales well, is served for free by github at thier own costs, and I wanted to have as little maintenance as possible, automating all services using existing systems, as little code involved as possible.

## Blogger and WordPress

The simplest first part to move was the blogger and codebetter sites. Jekyll [comes with importers][jekyll-import] for most types of sites, and the import just worked, in both cases. I won't bore you with the details as you just have to follow the tutorial site.

Unfortunately, neither tools retrieved images, and the content is still in html, but overall it's a small price to pay. My attempts at finding a correct html to markdown converter have been mostly fruitless unfortuantely. If you know of a good one, let me know in the comments.

## Older self-hosted dasBlog platforms

When I killed the old thetechnologist.net blog, which I used to self-host on the then very trendy [dasBlog][dasBlog], I kept all the xml files it generated, in case I ever wanted to revive the content. Nearly 8 years later, I tried, and realised it was much more work than I thought. It was also blatantly  missing content.

If only there was a standard-based format for archiving and retrieving blog posts... And that's when I remembered [the wayback machine][wayback-machine]. This little gem of a service archives from time to time web sites and keep them for future generations. After crawling through the various versions avaiable, I managed to download a couple of RSS feeds from various years, and used once more the jekyll-import tool, and voila, content!

[jekyll-import]: <http://import.jekyllrb.com>
[wayback-machine]: <http://web.archive.org/web/*/thetechnologist.is-a-geek.com>
[dasBlog]:<https://github.com/shanselman/dasblog/>
