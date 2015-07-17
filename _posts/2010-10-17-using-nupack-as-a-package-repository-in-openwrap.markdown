---

comments: true
date: 2010-10-17 20:06:15+00:00
layout: post
slug: using-nupack-as-a-package-repository-in-openwrap
title: Using NuPack as a package repository in OpenWrap
wordpress_id: 8
---

NuPack came out a short while ago. While NuPack is only a subset of what OpenWrap was built to solve, a lot of libraries have already been added to their repositories, probably for the sole reason that it’s Microsoft and some people get excited about them doing anything having to do with Visual Studio.

 

But in the OpenWrap team, we think that packages are good, that’s why we’ve worked hard on our system for so many months. And we think you should, as a dedicated OpenWrap users, be able to import those packages until such a time the world adopt OpenWrap as the main way to deliver dependencies to you.

 

So you can do this now. At a command line, add nupack as a repository through the usual remote command.

 
    
    <div><b>PS C:\src\demo></b><i> o add-remote nu nupack://go.microsoft.com/fwlink/?LinkID=199193</i></div>
    # OpenWrap v1.0.0.0 ['C:\src\demo\wraps\_cache\openwrap-1.0.0.18871048\bin-net35\OpenWrap.dll']
    Remote repository 'nu' added.





From now on, any nupack will be downloaded and converted to the OpenWrap native format and be usable as usual in OpenWrap. Note that we only support things that do not have dependencies on PowerShell, so while you get command support out of the box with OpenWrap packages, we will do nothing with the PowerShell scripts at all.





You can query packages on that new server using the list-wrap –query command.




    
    <div><b>PS C:\src\demo></b><i> o list-wrap -query *castle* -remote nu</i></div>
    # OpenWrap v1.0.0.0 ['C:\src\demo\wraps\_cache\openwrap-1.0.0.18871048\bin-net35\OpenWrap.dll']
     - Castle.Components.Validator
       Versions: 1.1.0
     - Castle.Core-log4net
       Versions: 2.5.1
     - Castle.Core-NLog
       Versions: 2.5.1
     - Castle.Core
       Versions: 1.1.0, 1.2.0, 2.5.1
     - Castle.DynamicProxy
       Versions: 2.1.0, 2.2.0
     - Castle.Windsor-log4net
       Versions: 2.5.1
     - Castle.Windsor-NLog
       Versions: 2.5.1
     - Castle.Windsor
       Versions: 2.1.1, 2.5.1
     - SNAP.CastleWindsor
       Versions: 1.0







And add one to the package, say the latest castle.core version:




    
    <div><b>PS C:\src\demo></b><i> o add-wrap castle.core</i></div>
    # OpenWrap v1.0.0.0 ['C:\src\demo\wraps\_cache\openwrap-1.0.0.18871048\bin-net35\OpenWrap.dll']
    Wrap descriptor found.
    Project repository present.
    Dependency added to descriptor.
    Copying 'Castle.Core-2.5.1' from 'nu' to 'System repository'
    Copying 'Castle.Core-2.5.1' from 'nu' to 'Project repository'
    Making sure the cache is up-to-date...







And you’re done. On a side-note, the NuPack project will shift to the horrendous OData protocol, but provided they don’t break the examples they’ve shown of what atrocities introducing the EDM will do to their xml documents, we already support that too.
