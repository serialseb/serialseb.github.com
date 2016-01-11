---

comments: true
date: 2010-10-18 22:39:39+00:00
layout: post
slug: contributing-to-openwrap
title: Contributing to OpenWrap
wordpress_id: 11
---

I’ve already detailed how to [fork OpenWrap to your github account](http://codebetter.com/blogs/sebastien_lambla/archive/2010/10/17/installing-openwrap-from-the-sources.aspx). Now you want to make some changes. Here’s a small guide of the main things you need to do, and a quick intro to git as well to make sure everybody can contribute.

 

[pre-emptive-strike] You should always use branching when working on something. This is a 5 minutes intro on how to get on with git, not a best-practice guide. [/pre-emptive-strike]

 

First things first, make sure your auto.crlf settings are set. This is important so the line endings stay the same across all developers, and** if you forget this, I won’t be able to take the pull request at all**.

 

In the directory in which you have your clone of OpenWrap, you can issue the following command.

 
    
    <div><b>PS C:\src\openwrap></b><i> git config core.autocrlf false</i></div>





Now you can start working on the code. Once you have made the changes you want, you can build OpenWrap as simply as issuing the build command.




    
    <div><b>PS C:\src\openwrap></b><i> o build-wrap</i></div>





Which you can then follow by updating your local copy of openwrap with another one-liner.




    
    <div><b>PS C:\src\openwrap></b><i> o update-wrap</i></div>





### Picking a task





Our issue tracker is at [http://github.com/openrasta/openwrap/issues](http://github.com/openrasta/openwrap/issues). I’ve annotated a bunch of issues with self-explanatory tags, from bugs to easy to what we want before we call this release a 1.0.0 release.





When you have chosen something from that list, just add a comment to the github issue to let everyone know you’re working on it.





### When you’re happy with your changes





Chances are, as you changed OpenWrap’s code, you probably updated your packages a couple of times. This leaves behind a couple of things you need to get rid off before doing a pull request.





First, each time you build, a new package is added to the current directory. Delete them all, as they don’t need to be in the repository.




    
    <div><b>PS C:\src\openwrap></b><i> del *.wrap</i></div>





Now, you also want to clean-up old packages that are no longer in use. Again, it’s a one-liner.




    
    <div><b>PS C:\src\openwrap></b><i> o clean-wrap</i></div>





You now should only have your changes in your current repository.





Making your commit and pushing





First, you can always have a look at the changed files you have using the git status command.




    
    <div><b>PS C:\src\openwrap></b><i> git status</i></div>
    # On branch edge
    # Changed but not updated:
    #   (use "git add <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working directory)
    #
    #       modified:   src/OpenWrap.Commands/Wrap/PackageDescriptionOutput.cs
    #
    no changes added to commit (use "git add" and/or "git commit -a")





This shows you that you’ve changed a specific file.





You now just need to add those files to your _staging area_, aka the things you want to be committed back in your repository.




    
    <div><b>PS C:\src\openwrap></b><i> git add src/OpenWrap.Commands/Wrap/PackageDescriptionOutput.cs</i></div>





Once that is done, you simply need to commit your changes. Make your git commit imperative and descriptive of what you’re doing. If you’re tackling an issue and you think you’ve solved it, use the _close #xx_ text in your commit message, that will help close the issue you were trying to fix.




    
    <div><b>PS C:\src\openwrap></b><i> git commit -m "Writes the nuke property of a pacakge in list. Closes #999."</i></div>





When you’re ready to publish to github what you have, you simply need to do a push.




    
    <div><b>PS C:\src\openwrap></b><i> git push origin master</i></div>





This will publish your code for all to see.





### Sending a pull request





You are now nearly ready to become a full fledged OSS contributor. The only thing left is to send your changes to the upstream project so they can have a look at it.





Simply follow the instructions at [http://help.github.com/pull-requests/](http://help.github.com/pull-requests/) and you’ll know exactly what to do.





### Signing a Contributor Agreement





The last thing you may have to do, depending on what patch comes in, is to sign a contributor agreement (usually referred to as a CLA). This is a little piece of paper that assigns a license to your copyright in producing the patch you’re sending back to the hosting project (OpenWrap). You won’t always need it, and if you do, I’ll get in touch with you. Fear not, pull-request us as much as you can.





We are, after all, built by the community, and building for the community, in the open, from day one. That’s how we roll.
