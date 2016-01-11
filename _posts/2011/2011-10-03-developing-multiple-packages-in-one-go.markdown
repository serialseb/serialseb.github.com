---

comments: true
date: 2011-10-03 17:50:49+00:00
layout: post
slug: developing-multiple-packages-in-one-go
title: Developing multiple packages in one go
wordpress_id: 82
---

Very often, it is the case that you are working on multiple packages at the same time. Keeping dependencies up-to-date in those scenarios can be a very tedious process.

One of the new features of OpenWrap 2.0 is the ability to build things from the command-line very quickly.

Let’s say that your project has the following layout:

  * MainProject
    * src
    * wraps

Let’s say that you also work on a reusable library called MyLib. The simplest thing is for you to add a reference to the code in a separate folder. I’m going to put a link in a folder within wraps called etc/MyLib. You can do that with an svn:external, a git submodule, an ntfs junction, whatever you want.

Now when you’re at the command line, building that dependency is rather simple.
    
    o build-wrap -from wraps/etc/MyLib -quiet -incremental -debug
    







This instructs OpenWrap to use the project in there and build a package in your current folder. The Incremental flag (which is also new) lets the MSBuild runner build only what has changed in that project, and –debug builds the package in debug mode.




Only thing you now need is to update the library. OpenWrap has supported updating packages from the current directory since day one, so it’s as simple as doing:
    
    o update-wrap MyLib
    







Now you may have a bunch of those libraries, so maybe doing a little script would make things easier. Powershell to the rescue.
    
    ls wraps/etc | %{
      o build-wrap -from $_.FullName -quiet -incremental -debug
    }
    o update-wrap
    







This will now build any referenced project in your wraps/etc and automatically update everything. I’ve not added error detection for failed builds (you can do that easily enough by checking for o.exe returning something else than 0). What’s not in there either is to build inter-dependent packages in order in which they depend on each others. This is left as an exercise to the reader (hint, you only need to build a small dependency tree based on parsing “depends: name” in descriptors in each, get an ordered list and update sequentially each project before building it, which is easy as peas and should take a whole of 10 lines of powershell).




One of the things that I’m evaluating for future versions is to bake that feature in, so that any source code in wraps/etc/packageName would automatically be built on-demand and follow the dependency graph. If you think that would be useful to how you build your projects, let us know by joining the [OpenWrap mailing list](http://www.google.co.uk/url?sa=t&source=web&cd=1&ved=0CBsQFjAA&url=http%3A%2F%2Fgroups.google.com%2Fgroup%2Fopenwrap-devel&ei=xfWJTouhH-ec0AXLhqXeDw&usg=AFQjCNGfy_egaNS03z11B6UvCq7bq2PIyA&sig2=_x89HMR5PcDZIxB85MMn5Q)!
