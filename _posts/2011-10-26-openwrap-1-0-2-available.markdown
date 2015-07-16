---
author: sebastienlambla
comments: true
date: 2011-10-26 17:55:03+00:00
layout: post
slug: openwrap-1-0-2-available
title: OpenWrap 1.0.2 available
wordpress_id: 95
---

I’ve just pushed a new version of the 1.0 OpenWrap package.

To get it if you're a new user, head to http://openwrap.org and click the download button. If you have OpenWrap currently, it's one command away:

    
    c:\src\> o update-wrap openwrap -project


We **highly** recommend that you update any of your 1.0 projects to this new version, so you can be fully-compatible with 2.0 when we get to beta status.

No new features, just fixes: we now automatically changes projects that take dependencies on OpenWrap without putting a version, which continues to be an issue when 1.0 and 2.0 cohabitate, and ReSharper 5.1 support should now work as expected.
