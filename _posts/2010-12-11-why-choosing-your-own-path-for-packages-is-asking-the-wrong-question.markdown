---
author: sebastienlambla
comments: true
date: 2010-12-11 02:19:00+00:00
layout: post
slug: why-choosing-your-own-path-for-packages-is-asking-the-wrong-question
title: Why choosing your own path for packages is asking the wrong question
wordpress_id: 27
---

I've had a couple of people asking me if we could change where packages get stored from the /wrap folder to their own folder. I'm not the only one with that feature request, the NuGet guys have had that question asked and even partially implemented a feature for it. I think responding to those requests is not the right thing to do, and this post is to explain why.




When the question "can I change where packages go", usually the underlying, real question, is one of two: "I want them in /lib with the rest of my traditional libraries", or "In my corporate environment I don't want to check-in all the dependencies because I don't care about xcopy deployment".




### Managing local packages




The first question usually is due to the desire developers have to keep all their dependencies in the same location. While I can understand the psychological reasons behind such a request, the reality of how a package manager usually work is quite incompatible with this approach.




Take the typical example of a command you could issue in OpenWrap: _o update-wrap nhibernate-core -clean_. This command asks OpenWrap to update a dependency and remove any old dependencies that were present.




To do so, OpenWrap needs a certain level of guarantees that you don't mess with the structure it relies on to locate packages. Imagine for a second that you copied your usual nunit dlls in /lib/nunit-2.6.0, and also had a package you depend on in one of your packages that happen to be the nunit package.




At that stage, you now have no way to differentiate between the two, the lib you own and the package that, for all intent and purposes, is owned by the package manager.




Allowing you to keep two different beasts, library dependencies you own and packages you depend on and that are owned by your package manager, would introduce a very large amount of complexity, not only for OpenWrap but also for you: it becomes very difficult for everybody to differentiate between an immutable package and a mutable dependency you pulled yourself.




For that reason, while I certainly understand why it doesn't feel "neat", keeping packages separate from libraries let everybody know what each of the beasts are, without introducing complexity.




There's also a secondary scenario to take into account. While we, as the OpenWrap team, don't see any reason why you would want to run both NuGet and OpenWrap at the same time, we do recognize that it's a probability that some people will end-up with both solutions running side-by-side in the same projects, and we certainly make sure that this scenario is functional.




As NuGet stores stuff in /packages and we store stuff in /wrap, everything is fine, neither package managers will get confused. If however you were to redirect either systems to the other repository, you'd end up with what I can only define as undefined and probably clusterfucky behaviour, and that's not something either team would want you to end up in.




### Keeping the packages out of source control




Now this scenario I can understand a bit more. A lot of corporate environments, due to the heavy tax they make developers pay by having managed desktops, do have very defined and reliable environments, quite a different thing than what open-source projects and smaller companies can afford to have.




If you do have such an environment, systematically copying new versions of updated packages in your source control increases the size of the repository, while you could potentially live happily without all those binaries.




There is a fundamental issue with this scenario, and one that neither NuGet nor OpenWrap have a solution for at this time: Whenever you don't include the exact version of a dependency you expect, and rely on a central repository to pull those as needed, you may end up with a different version from the developer sitting next to you.




Let's say I originally added a dependency by doing _o add-wrap nhibernate.core_. I shall get whatever version was the latest one at the time I started coding.




A week pass, and nhibernate 3.0 gets released, and breaks your application. The reason is simple, while I still happily run on 2.0, you have the 3.0 package.




Now there are a couple of ways we can enable this. The first one is to restrict you to absolute version definitions in the packages you take dependencies on. While this is the quickest way to get to that point (and the one the NuGet package repository very much has implemented so far), it restricts not only your dependencies at development time when you pull a package you want work on, it also restricts the runtime binding that a system like OpenWrap also takes care of.




The other solution, and the one we'll implement in OpenWrap (depending on feedback, the more users want it, the higher the priority), is in the case where you use the _use-project-repository: false_ instruction in a project (a hidden feature in OpenWrap that won't be part of the documentation until we've covered cases such as those). When you do that, as well as storing the packages in your development package folder (the _wraps/_cache_ folder), we'll also keep a list of absolute versions that you were using. Whenever a resolve or update happens, we'll only rely on that exact list to update your repository.




With this system, you'll be able to only check-in the openwrap dlls, and let the system auto-download and install all the missing dependencies based on the versions that other developers are also using.




There are a couple of issues with this system to ensure that all packages openwrap depends on are also checked-in in your source control, but those are not a big deal, just one of many features we have planned.




### Getting those features in




The OpenWrap team is very committed to features that make life easier for developers that wish to be productive with their dependency management needs.




If you want to see those things happen sooner, why not [join us on the mailing list](http://groups.google.com/group/openwrap-devel) to talk about those features, fork [our repository on github](http://github.com/openrasta/openwrap) and contribute those features? We're a cool bunch and we'll provide you with as much help as you need to implement those. And if you don't have the time, a little message on the mailing list would go a long way to make sure we cover the scenarios you need when we plan for those features.
