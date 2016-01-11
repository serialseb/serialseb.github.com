---

comments: true
date: 2010-10-18 14:44:20+00:00
layout: post
slug: using-the-command-help-subsystem-in-openwrap
title: Using the command help subsystem in OpenWrap
wordpress_id: 10
---

Documentation in a command-line tool is important. My latest push (as of a few minutes ago) implements a much improved get-help command. This should let you discover a lot of the functionality of OpenWrap without needing my blog posts.

 

### Updating OpenWrap

 

I assume that you’re using the sources to run OpenWrap. Now is time to update your local copy with the latest changes, rebuild and reinstall. Difficult? We shall see.

 

To update, you simply issue a standard git command.

 
    
    <div><b>PS C:\src\openwrap></b><i> git pull origin master</i></div>





Then, you need to rebuild OpenWrap. As OpenWrap uses OpenWrap to build itself, it’s pretty straightforward.




    
    <div><b>PS C:\src\openwrap></b><i> o build-wrap</i></div>







That should produce a package in your current directory, all ready for update, which we can also do in one go.




    
    <div><b>PS C:\src\openwrap></b><i> o update-wrap</i></div>





### Getting a list of commands





As I’ve hinted several times before, commands are just one of the many things you can package in an OpenWrap package. They’re just plain old csharp code, which enables plenty of interesting scenarios I’ll talk about in a follow-up post.





So let’s see what we now have in our help system.




    
    <div><b>PS C:\src\openwrap></b><i> o get-help</i></div>
    # OpenWrap v1.0.0.0 ['C:\src\openwrap\wraps\_cache\openwrap-1.0.0.19057598\bin-net35\OpenWrap.dll']
    
    List of available commands
    --------------------------
    
    wrap update:
            Updates packages to their latest versions in local repositories.





Note that I’ve removed most of the content so this blog entry doesn’t get too big. What if you want help on a specific command, such as the clean-wrap command?




    
    <div><b>PS C:\src\openwrap></b><i> o get-help clean-wrap</i></div>
    # OpenWrap v1.0.0.0 ['C:\src\openwrap\wraps\_cache\openwrap-1.0.0.19057598\bin-net35\OpenWrap.dll']
    COMMAND
            clean-wrap
    
    DESCRIPTION
            Removes packages no longer in use in the local repositories.
    
    USAGE
            clean-wrap [[-System] <Boolean>] [[-Project] <Boolean>] [[-Name] <String>]
    
    PARAMETERS
            -System <Boolean>
                    Limits the cleaning to the system repository.
    
            -Project <Boolean>
                    Limits the cleaning to the project repository.
    
            -Name <String>
                    Specifies the name of the package for which to remove unused versions. If omitted, the clean will affect all packages.





There you go, now there is no excuse not to know commands by heart. And if you want to help translate those commands in your native language, I’m happy to take pull requests and Contributor License Agreements!





Later in the week we’ll see how easy it is for you to package your own commands to be deployed alongside your package. If you feel investigative, you can have a look at [the source code for existing commands](http://github.com/openrasta/openwrap/tree/master/src/OpenWrap.Commands/).
