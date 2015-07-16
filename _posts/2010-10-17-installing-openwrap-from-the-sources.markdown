---
author: sebastienlambla
comments: true
date: 2010-10-17 17:44:10+00:00
layout: post
slug: installing-openwrap-from-the-sources
title: Installing OpenWrap from the sources
wordpress_id: 7
---

OpenWrap normally relies on a central server for providing the initial shell and its associated packages. However, when you get on a new machine, you don’t necessarily want to get the release server, or it’s down.

 

Fear not, for the process is dead easy.

 

### Get the sources

 

First things first, you need to get yourself the source code. It’s at [http://github.com/openrasta/openwrap](http://github.com/openrasta/openwrap). If you don’t know how to use git, go install [msysgit](http://code.google.com/p/msysgit/downloads/list), open yourself a github account, fork OpenWrap to your account (by clicking on the _fork_ command from the project’s page), and at a command line, type the following command to clone your fresh new repository.

 
    
    <div><b>PS C:\tmp></b><i> git clone git://github.com/yourusername/openwrap.git</i></div>





Do the same thing for the shell source code, which you can find at [http://github.com/openrasta/openwrap-bootstrap.git](http://github.com/openrasta/openwrap-bootstrap.git).





### Build and install the shell





The _openwrap-bootstrap_ project contains the shell. It’s a very small executable that has the sole responsibility of finding the OpenWrap packages and executing them.





To build it, simply open the solution and run it. The shell will ask you if you want to install itself and add the correct path to your path environment variable (this is the _i_ option). Once this is done, close the shell, as if you have no access to the server, it will crash on you with a nice error message.





### Install OpenWrap in your System Repository





Now open a console where you cloned OpenWrap. The beauty of the per-project deployment of OpenWrap is that you don’t need any install of the packages themselves on your machine. We’ll leverage this feature to build and run the OpenWrap packages.





Go to the _/wraps_ folder, and use the _add-wrap openwrap –system_ command. This is the command you provide to get OpenWrap installed, and you do it with the –system flag so it goes to your system repository.




    
    <div><b>PS C:\src\openwrap\wraps></b><i> o add-wrap openwrap -system</i></div>
    # OpenWrap v1.0.0.0 ['C:\src\openwrap\wraps\_cache\openwrap-1.0.0.18871048\bin-net35\OpenWrap.dll']
    Wrap descriptor found.
    Project repository present.
    Copying 'openwrap-1.0.0.18871048' from 'Current directory' to 'System repository'
    Copying 'openfilesystem-1.0.0.18676829' from 'Current directory' to 'System repository'
    Copying 'sharpziplib-0.85.5.452' from 'Current directory' to 'System repository'
    Making sure the cache is up-to-date...





You’re done. You’ll now be able to execute OpenWrap commands from anywhere.
