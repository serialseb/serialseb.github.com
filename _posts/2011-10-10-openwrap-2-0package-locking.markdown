---

comments: true
date: 2011-10-10 15:02:12+00:00
layout: post
slug: openwrap-2-0package-locking
title: OpenWrap 2.0–Package locking
wordpress_id: 83
---

Well, this one was scheduled for much later in the development process of OpenWrap, but ended up being built last week.


## Why locking, a historical perspective


OpenWrap is very much a [http://semver.org-friendly](http://semver.org-friendly) system. When you take dependencies on packages, we **ignore** the revision number (that’s the _4_ in _1.2.3.4_). The reason is two-fold: the first one is that we believe in semver.org. The second one is that the revision is supposed to be used by library developers that want to hotfix a package urgently for security reasons, a side-effect of us ignoring that number alltogether.

The point is, in your package version, you must not deploy incompatible changes using revision numbers. It’s been like that since the inception of OpenWrap, so the behavior we’re talking about has been present in public releases since **May 2010**.

Many months later, nuget was announced, and people started publishing packages with the freedom to do whatever they want with their version numbers, even if it’s following no convention at all, rendering version numbering completely useless. It follows the nuget mantra of _we’re not changing what you currently do_, and is at odds with the OpenWrap mantra of_ we make it very very hard for you to shoot yourself in the foot_.

As it happens, guidance on that issue was published nearly a year ago at [http://codebetter.com/sebastienlambla/2010/10/15/building-polyglot-packages-for-openwrap-and-nupack/](http://codebetter.com/sebastienlambla/2010/10/15/building-polyglot-packages-for-openwrap-and-nupack/).

An OpenWrap customer recently encountered an issue where a package was pushing visible changes in the revision number, and that ended up auto-updating their solution, breaking their code. Definitely not something I want OpenWrap users to deal with.

At this stage, there are two ways to solve the problem. The first one is to do whatever the other package manager does, even if it leads people in the pit of failure. The other one is to add functionality that solves the problem in a way that puts people in the pit of success, while still preventing people from doing stupid things. That, and asking nicely the author of the package to reconsider their versioning scheme (as a side-note, the problem already happened with nhibernate, they refused to _change anything because of one tool_, while raven changed the versioning scheme within two hours, kudos to @ayende for being on the ball).


## Introduction


It is often the case that you want to make sure everyone in your team uses the same package versions. You could of course ask everyone to not update anything, but if someone adds a new package, dependencies between an old and the new package could be impacted by the update.

Or maybe it is the case that at development time, you want to freeze in time certain packages you rely on, so you can decide when to update them, independently of any other package you may want to add in the meantime.

You could specify strict equality to package versions in your descriptor (aka _depends: openwrap = 2.0.0)_, and for a project that only exists to build, say, an asp.net web app, that may be valid. If however you use your project to build a package, and the goal of OpenWrap is for one day everything to be a package, then you’re sharing your development-time dependencies with the world, and you prevent people from updating dependent libraries when they know they want to.

With locking, you can specify that a package, a list of packages or all of your packages are frozen in time. Trying to add, remove or update a locked package will simply fail.


## Locking


Say I have a new project that depends on OpenWrap 2.0.

    
    C:\demos\testlock> o list-wrap
     - Mono.Cecil (available: 0.9.4.1)
     - openfilesystem (available: 1.0.0.61263243)
     - openwrap (available: 2.0.0.81714117)


If a new version of OpenWrap becomes available, updating OpenWrap is going to be automatic.

    
    C:\demos\testlock> o update-wrap openwrap -proj
    Updating project packages...
    Project repository: openwrap updated [2.0.0.84854337 -> 2.0.0.84856266].
    ...
    Project repository: Package openwrap-2.0.0.84856266 anchored.


I can lock all my current packages by issuing the lock-wrap command.

    
    C:\demos\testlock> o lock-wrap
    Package 'openwrap' locked at version '2.0.0.84856266'.
    Package 'SharpZipLib' locked at version '0.86.0'.
    Package 'openfilesystem' locked at version '1.0.0.61263243'.
    Package 'tdnet-framework' locked at version '2.0.0.48555719'.
    Package 'Mono.Cecil' locked at version '0.9.4.1'.


Now all my packages are locked. Attempting to update any of those packages will do nothing. All the same, if I attempt to remove a locked package.

    
    C:\demos\testlock> o remove-wrap openwrap
    Cannont remove package 'openwrap' as it is currently locked. Unlock the package with 'unlock-wrap openwrap' first, then
    remove.


Of course, you can decide to lock only one package with the –Name input on the command, and you can prevent dependent packages from being locked with –IgnoreDependencies. Check the get-help section on lock-wrap for all the details.


## Unlocking


As simple as locking, the other way around, but I’ll just unlock openwrap and leave its dependencies locked.

    
    C:\demos\testlock> o unlock-wrap openwrap -ignoredependencies
    Package 'openwrap' unlocked.




## Sharing locked packages


Once  you’ve added and removed locks on your solution, it is up to you to decide if you want those locks to be shared with your team or not.

The way to do this is very simple. A new _packages.lock_ file has been added to the /wraps directory. If you want the locks shared, add it to source control. If you don’t want other team members to unlock, make the file read-only. Simples.


## The feature you don’t want to use, ever


Finally, there is a hidden feature that allows you to declare a dependency in your descriptor to be strict (aka include the revision number). It was there all along but not usable unless you were the package manager itself, and now we’ve surfaced it, for those scenarios where you’re doing something stupid, you know about it and you want us to back-off with all of our convention, good of the ecosystem mantra.

You can declare a dependency using the _Identical To_ unicode character, U+2261, more commonly known as **≡**. In your descriptor, you can then have:


<blockquote>depends: openwrap ≡ 2.0.0.84856266</blockquote>


And we’ll respect that. It’s not surfaced on the command line, and the use of the unicode character is to make it extra hard for you to do the wrong thing, while not preventing you to shoot your foot if that’s really your need.


## Conclusion


As usual, if you have any question about how to use those features, please post them on [http://stackoverflow.com](http://stackoverflow.com) and tag them with OpenWrap. If you have bug reports, please add them to [http://github.com/openrasta/openwrap/issues](http://github.com/openrasta/openwrap/issues). We are entirely community-focused and do the right thing for the software ecosystem. We can’t do that without you, users, so get in touch when you need to and we’ll try our hardest to help.
