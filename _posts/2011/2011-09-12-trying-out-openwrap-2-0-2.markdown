---

comments: true
date: 2011-09-12 21:11:56+00:00
layout: post
slug: trying-out-openwrap-2-0-2
title: Trying out OpenWrap 2.0
wordpress_id: 71
tags: [openwrap]
---

_[Update 3: github is not pushing the changes to openwrap.org properly, I’ve updated the link to the shell in the post to point to the correct file.]_

_[Update 2: The problems with side-by-side of 2.0 and 1.0 seem to be mostly resolved. Do not install 2.0 in your system repository just yet, keep it in a test project, and please update OpenWrap to the newly released 1.0.1 version which solves some of those issues.]_

_[Update: I’ve temporarily removed the 2.0 packages from the beta server due to unforeseen 1.0.0 / 2.0 side-by-side execution due to a bug in 1.0.0. Expect a new set of packages soon.]_

We’ve come a long way since the initial work started on OpenWrap 1.1 that turned into 2.0.

We now have ReSharper 6 support and a whole lot of new features, and we’re 50 open issues from being feature complete. Still, it’s time to announce a few things.

First, the shell has been updated to 2.0, and bring back the possibility of deleting your /wraps folder when something goes bad to force an update, as well as fix a bunch of bugs that existed in the 1.1 release. Go [download it now](http://github.com/OpenWrap/openwrap.github.com/raw/master/o.exe).

The second thing is that test packages of OpenWrap 2.0 are available for testing, but not on the main repository. If you have OpenWrap 1.0 installed, you can upgrade a specific project to OpenWrap 2.0 by adding the beta repository.

    C:\src> o add-remote beta http://wraps.openwrap.org/beta/
    # OpenWrap Shell 2.0.0.8
    # Copyright © naughtyProd Limited 2009-2011
    # Using C:\Users\sebastien.lambla\AppData\Local\openwrap\wraps\_cache\openwrap-2.0.0.81133579\bin-net35\OpenWrap.dll (2.0.0.0)
    Remote repository 'beta' added.

    <font color="#444444" face="Georgia" size="3">Then you can update your project to the new test version.</font>

    <font color="#444444" face="Georgia" size="3"></font>

    C:\src\myProject> o update-wrap openwrap -project








If you want to install 2.0 in your system repository, and at this stage it is not recommended as those are early previews that do not guarantee that side-by-side execution will work, then any 1.0 project may fail with **noun not found** errors. If this is your case:






  * Change your wrap descriptor to force 1.0, so “depends: openwrap content” should be changed to “depends: openwrap = 1.0 content”

  * Force an update to 1.0.1 by doing “o update-wrap openwrap –proj –usesystem”

  * If this fails, let us know how, then simply reset your system repository to a known state using the –shellpanic flag before executing your update-wrap command.



In the next couple of weeks there will be very long blog posts about all the new features we have in there for you, but if you’ve been dying to test out the alpha releases, now you know how.




As usual, contributors are welcome, bug reports should be filled on [http://github.com/openrasta/openwrap/](http://github.com/openrasta/openwrap/). If you’ve not involved yourself in real open source, by the people, for the people, in the open and in all honesty, now is the time.




OpenWrap is the longest running and most open package manager on .net, come and have a look.
