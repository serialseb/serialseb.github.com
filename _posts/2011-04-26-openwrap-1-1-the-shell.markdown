---

comments: false
date: 2011-04-26 07:40:20+00:00
layout: post
slug: openwrap-1-1-the-shell
title: OpenWrap 1.1 – The Shell
wordpress_id: 41
---

OpenWrap 1.1 is around the corner, and has a *lot* of new features and improvements that I’ll be blogging about as they land.

One part that has now been released is an updated shell. It is the _o_ tool you use and love and can grab from [http://openwrap.org](http://openwrap.org).

The command subsystem in OpenWrap 1.1 has been updated significantly, with many great new features. As things sometime go, we had to change the way the shell calls into OpenWrap.

The good news is that the 1.1 shell will still run OpenWrap 1.0 commands, so you can update now in the full knowledge that all will be good.

Note that we have tweaked the networking code for the first installation, so if you’re behind a proxy that is automatically configured, and the download used to stop at the first file, this problem should be resolved. If you still have issues, please let us know by [filling a bug report](https://github.com/openrasta/openwrap-bootstrap/issues/new).
