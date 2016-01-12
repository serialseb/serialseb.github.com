---

comments: true
date: 2010-10-17 23:31:38+00:00
layout: post
slug: creating-your-own-openwrap-repository-on-a-file-share
title: Creating your own OpenWrap repository on a file-share
wordpress_id: 9
---

I’m feeling in a blogging mood. There are so many things that are cool in OpenWrap that you can expect quite a bit of content in the next few days.



One of the features we have in OpenWrap, and have had for a while, is using a simple file share as a remote repository.



From a command line, add a remote repository by providing a name and a path. I’ll do that a mythical server I’ll call cherenkov.



    <div><b>PS C:\src\demo></b><i> o add-remote corp file://cherenkov/c$/tmp/remoterepo/</i></div>
    # OpenWrap v1.0.0.0 ['C:\src\demo\wraps\_cache\openwrap-1.0.0.18871048\bin-net35\OpenWrap.dll']
    Remote repository 'corp' added.







Note that I could’ve created a local repository (one on my hard drive) by using [_file:///c:/tmp/remoterepo/_](/tmp/remoterepo/) instead.





You can now publish packages. I’ll be cheeky and reuse a package I downloaded from NuPack that got converted automatically in the OpenWrap format, which [I showed you how to do in one of my previous posts](http://codebetter.com/blogs/sebastien_lambla/archive/2010/10/17/using-nupack-as-a-package-repository-in-openwrap.aspx).





    <div><b>PS C:\src></b><i> o publish-wrap corp C:\users\sebastien.lambla\appdata\local\openwrap\wraps\Castle.Core-2.5.1.wrap</i></div>
    # OpenWrap v1.0.0.0 ['C:\Users\sebastien.lambla\AppData\Local\OpenWrap\wraps\_cache\openwrap-1.0.0.19021568\bin-net35\OpenWrap.dll']
    Publishing package 'Castle.Core-2.5.1.wrap' to 'corp'







And just to make sure, let’s go and see what is now in our remote package.





    <div><b>PS C:\src></b><i> o list-wrap -remote corp</i></div>
    # OpenWrap v1.0.0.0 ['C:\Users\sebastien.lambla\AppData\Local\OpenWrap\wraps\_cache\openwrap-1.0.0.19021568\bin-net35\OpenWrap.dll']
     - Castle.Core
       Versions: 2.5.1




Job done.
