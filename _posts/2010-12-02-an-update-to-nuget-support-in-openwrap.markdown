---
author: sebastienlambla
comments: true
date: 2010-12-02 17:39:00+00:00
layout: post
slug: an-update-to-nuget-support-in-openwrap
title: An update to nuget support in OpenWrap
wordpress_id: 26
---

I've been pretty quiet lately, as we've been working very hard at the new package resolver infrastructure I'll blog about soon.




In the meantime, if you use OpenWrap from the master branch (the packages will be updated on the server at the weekend), I've fixed an issue we were having with NuGet packages. Indeed, some packages produced by NuGet are not in compliance with the [specs they've published](http://nuget.codeplex.com/documentation?title=Nuspec%20Format). We now process those packages by ignoring all namespaces.




To add the v1 repository to OpenWrap, simply use the add-remote command.



    
    <div><b>PS C:\src\openwrap></b><i> o add-remote legacy nuget://feed.nuget.org/ctp2/odata/v1/Packages</i></div>
