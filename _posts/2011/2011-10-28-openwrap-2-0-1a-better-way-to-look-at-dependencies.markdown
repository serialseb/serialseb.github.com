---
comments: true
date: 2011-10-28 11:32:22+00:00
layout: post
slug: openwrap-2-0-1a-better-way-to-look-at-dependencies
title: OpenWrap 2.0.1 – a better way to look at dependencies
wordpress_id: 103
tags: [openwrap]
---

There are many many features in OpenWrap 2.0, and at this rate it will take me many weeks before we go through them all. As such, I shall only blog about the things that are fully finished (and why you’ve not seen anything about remotes in 2.0 yet, that’s coming, you’ll like it, trust me).

## Before

One of the things that has been difficult in the past with OpenWrap was knowing exactly what dependencies you had and how versions got selected. Worse than that, while in a project, the list-wrap command would only show you the list of packages currently in your folder, be it that they are in use or not.

## A better list-wrap

So we’ve worked very hard to give you a better way to see what’s going on from the command line (and it’s always my belief that if you can make something understandable in 80*120 characters, you can make it understandable in *anything*).

## Listing project packages

The first change is when you issue a list-wrap command within a project.

<table border="0" > <tbody > <tr >
<td >

    <b><span>C:\src\openwrap [exp_list_wrap +5 ~25 -4 !]></span></b><i><span> o list-wrap</span></i>
    # OpenWrap Shell 2.0.0.10
    # Copyright © naughtyProd Limited 2009-2011
    # Using C:\src\openwrap\wraps\_cache\openwrap-2.0.0.86438072\bin-net35\OpenWrap.dll (2.0.0.1)
    ─default scope
     ├─SharpZipLib 0.86.0
     ├─openfilesystem 1.0.0.61263243
     ├─openwrap 2.0.0.86438072
     ├─tdnet-framework 2.0.0.48555719
     └─Mono.Cecil 0.9.4.1
    ─tests scope
     ├─NUnit 2.5.9.10348
     ├─SharpZipLib 0.86.0
     ├─openfilesystem 1.0.0.61263243
     ├─openwrap 2.0.0.86438072
     ├─tdnet-framework 2.0.0.48555719
     └─Mono.Cecil 0.9.4.1



</td></tr></tbody></table>  
A couple of things are visibly different 1.0.




First, we now show the currently-used package for each of the scopes. if you don’t know what scopes are, I’d refer you back to the wiki documentation, the feature is one of the first we built for the now defunct 1.1, and will be blogged about when I consider the feature *complete*.




Second, we show you the packages *currently in use*. No more showing you lots and lots of package versions that are available but not used anymore, we only show you *the same thing your projects will get*.




Third, we show it as a tree. I love ASCII art and thought it absolutely had its place in a package manager.




## Gimme gimme gimme a packaaaa aaage per line…




Of course, that’s also a vast improvmenet on what we had before. But as you know, package resolution ca get a bit hairy when a lot of packages have different rules, and trying to check manually what the heck is going on requires checking the package itself, something I’m sure you don’t want to be doing.




So now we can look at the whole of the resolution tree by adding an –includeDependencies flag. What’s the output then, I hear you ask with excitement and awe in your voice?


<table border="0" >
<tbody >
<tr >

<td >

    <b><span>C:\src\openwrap [exp_list_wrap +5 ~25 -4 !]></span></b><i><span> o list-wrap -iD</span></i>
    # OpenWrap Shell 2.0.0.10
    # Copyright © naughtyProd Limited 2009-2011
    # Using C:\src\openwrap\wraps\_cache\openwrap-2.0.0.86438072\bin-net35\OpenWrap.dll (2.0.0.1)

    ─default scope
     ├─depends: sharpziplib = 0.86
     │ └─SharpZipLib 0.86.0
     ├─depends: openfilesystem = 1.0
     │ └─openfilesystem 1.0.0.61263243
     │   └─depends: openwrap content
     │     └─openwrap 2.0.0.86438072
     │       ├─depends: sharpziplib = 0.86
     │       │ └─SharpZipLib 0.86.0
     │       ├─depends: openfilesystem = 1.0
     │       │ └─openfilesystem 1.0.0.61263243
     │       │   └─...
     │       ├─depends: openwrap content = 2.0
     │       │ └─openwrap 2.0.0.86438072
     │       │   └─...
     │       ├─depends: tdnet-framework
     │       │ └─tdnet-framework 2.0.0.48555719
     │       └─depends: Mono.Cecil = 0.9.4
     │         └─Mono.Cecil 0.9.4.1
     ├─depends: openwrap content = 2.0
     │ └─openwrap 2.0.0.86438072
     │   ├─depends: sharpziplib = 0.86
     │   │ └─SharpZipLib 0.86.0
     │   ├─depends: openfilesystem = 1.0
     │   │ └─openfilesystem 1.0.0.61263243
     │   │   └─depends: openwrap content
     │   │     └─openwrap 2.0.0.86438072
     │   │       └─...
     │   ├─depends: openwrap content = 2.0
     │   │ └─openwrap 2.0.0.86438072
     │   │   └─...
     │   ├─depends: tdnet-framework
     │   │ └─tdnet-framework 2.0.0.48555719
     │   └─depends: Mono.Cecil = 0.9.4
     │     └─Mono.Cecil 0.9.4.1
     ├─depends: tdnet-framework
     │ └─tdnet-framework 2.0.0.48555719
     └─depends: Mono.Cecil = 0.9.4
       └─Mono.Cecil 0.9.4.1





</td></tr></tbody></table>


Now, that’s a lot of information, but you should be piping this stuff to _less_ anyway. The –includeDependencies flag (which I’ve shortened to –iD here, thanks to our great console algorithm that does the right thing most of the time) lets you see *exactly* what happens.




From your original descriptor (_“default scope”_), you can see all the dependencies you have declared, as you’ve specified them. For each of the packages that were found in your current project for those dependencies, you see their dependencies too, and on and on. The only time we don’t show something is when the tree is recursive (say, openwrap depending on openwrap), in which case we show you the “…” line you can see above.




## Remote packages




There’s a bit of changes to the remote packages too.




First, we’ve fixed the silly bugs where you got all the remote packages even if you specified –remote _name_, A very annoying stupid issue that appeared in 2.0 when we rewrote the remote support (yes, I do know that’s not been blogged about either yet, be patient, we’re nearly there).




Second, we’ve changed the displaying to show you what packages were found in which repository, so you can understand where things come from without cluttering the actual output. Say I have two remotes, remote1 and remote2, and they each have copies of openwrap. A simple _o list-wrap –remote_ is now much easier to understand.


<table border="0" >
<tbody >
<tr >

<td >

    <b><span>C:\src\openwrap [master]></span></b><i><span> o ls-wrap -query openwrap -rem</span></i>
    local
    └─openwrap (1.0.2, 1.0.1, 1.0.0)
    └─openwrap-bootstrap (1.0.0)

    local
    └─openwrap (2.0.1, 2.0.0, 1.1.0)



</td></tr></tbody></table>


Couple of things have changed.




We now segregate packages by remote, so you can see immediately which remote has which package, making knowing where things come from much easier.




The second change is that we only show the first three components of package versions by default, as this is what OpenWrap understands and what you should rely on.




## Conclusion




Understanding dependencies between packages can be a bit of a challenge. The new list-wrap should give you better understanding of what is actually going on.
