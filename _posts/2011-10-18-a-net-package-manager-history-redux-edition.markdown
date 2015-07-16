---
author: sebastienlambla
comments: true
date: 2011-10-18 00:34:32+00:00
layout: post
published: false
slug: a-net-package-manager-history-redux-edition
title: A .net package manager history - redux edition
wordpress_id: 86
---

**note to reviewers: this is a draft, still need to rewrite the nuget part a bit to make it more factual, I realize it's a bit too edgy right now. This won't go out until it's accurate and non-controversial (but not complacent), so any feedback is welcome.**

_The thing to realize is that the destination is never the most important part of the journey. It’s the journey itself._

There are many things to talk about when one discuss the topic of package management in .net. Part of that history is usually recounted inaccurately by various sources, and while I've tried very hard to not blog about it, it has become so widespread that I think it is time that I give my side of the history behind all the various projects that existed before the modern times when everyone started listening (aka the NuGet era). I'm going to try and be as accurate as I can in giving my view on that history as it happened, based on published and available material. I will happily take any correction / modifications required by the people involved in all those projects, and update this post accordingly.

Please note that my goal here is not to inflame yet another conversation about the reason for existence of any of those projects, but to once and for all settle the _how we got there_ question. Hopefully this will be the last time I have to get myself involved in those conversations, and we can all move forward to discussing current featuresets. And if that fails, at least I can just copy and paste the URI to this blog rather than repeat the same stuff over and over again.

**Once upon a time...**

Let's go back to the beginning of why I built OpenWrap.

OpenRasta, the web framework that did two years ago everything that .net 4.5 will do for you in two years time, started becoming big. From dependency injection interaction to markup to http to view engines, a lot of moving parts were starting to appear, based on other projects, and the monolithic nature of the framework distribution channel became more and more incompatible with the compositional nature of the framework itself. In other words, while you could add and replace bits and pieces everywhere to enrich the framework, the bits that came out of the box were all tied in common releases, making pushing new versions out close to impossible.

Another area that was itching was that I wanted people to be able to very easily start building extensibility points and distribute them independently of the core framework. It would reduce my workload while release people from the difficulty of getting adoption for their plugins when the distribution medium is a "copy a dll in a folder" solution.

Finally, I always thought that, for a web site like a windows application, depending on a javascript file, some dll's, some XAML or some CSS were *exactly the same thing*. Replacing "Add Reference" definitely was one of the minor scenarios compared to composition of content for applications, and the over-focus on adding dlls just didn't feel right.

**Before OpenWrap...**

Of course, there is a long history before and alongside OpenWrap's development, and we should assert right now that package management was in the works a very long time ago already, with me having no involvement **whatsoever**.

**Hornget**

The grand-dad of all package manager efforts was hornget. The guys that worked on this were very smart, and looked at how you could distribute packages by providing a way to build from source any package that you may require.

The earliest date I can find about hornget (on the[ Scottish Alt.net mailing list](http://groups.google.com/group/scotaltnet/browse_thread/thread/4d2a0b0daad6b535#)) goes all the way back to **28th October 2008**. Yeap, that's 3 years ago.

Due to the reluctance or inability of a lot of OSS frameworks to have something that *can* build from source, the project failed to be maintainable, despite the huge amount of efforts the original developers put into it.

As it happens, the guys behind hornget were scottish people I knew well. We had a long conversation at DDD Ireland in **April 2009** (god time flies) about how I needed to update hornget to manage binary dependencies instead of source-based ones. The experiments I did over the couple of months after that taught me that what was in hornget wasn't compatible with what I wanted to do with OpenWrap, and I had to drop the idea of leveraging their work.

**Another contender, with a false start (or two)**

Going back in history, another project was started by a bunch of people to try and address the same issue, but this time binary-based. My good friend David Laribee explained to me that they started by doing a .net-specific solution, and at some point gave up and adopted a model where they leveraged rubygems with a very thin .net layer.

Nubular, as you can see from [their initial commit on github](https://github.com/nu/nu/commit/9e3d2ef15ba6a0e3d23fdb9b7ce088e90012533c), goes back as far as **January 2008**.

Interestingly enough, I only heard of that effort as the hornget project was getting off the ground, and by the time I got to it, they had moved to rubygems, making them relying on a different technology and a different distribution mechanism that couldn't quite support what I wanted to do with what was to become OpenWrap.

Back then (and sadly I can't browse twitter history to pull those messages back), a lot of conversations were had between some nubular people and myself. They had a valid point, they wanted to leverage existing infrastructures, didn't want to invest development effort into a native solution (and as we've seen, because they had tried in the first phase of their project), so their refusal to work with what I was doing with OpenWrap was perfectly justified. Their warning that the ramp-up time to get a fully workable solution in native .net code would take a huge amount of time was also very accurate, as OpenWrap has been nearly two years in the making.

**Other projects**

Of interest for historical perspectives are two projects, one I knew about and one I discarded.

[Bricks](http://jonorossi.com/blog/archive/2010/04/11/bricks-a-preview-of-a-.net-package-manager.aspx) appeared in **April 2010**. Jon Rossi and I have had chats subsequently to the official announcement, and discussed in a very constructive ways how those projects could be related, and even kind of agreed on a merge at some point in the future when OpenWrap would be mature enough to support such a move. This never quite happened, both because OpenWrap ended up taking much longer than I originally thought, and because Jon's focus switched to a different model after that (and before the NuGet announcement).

Another project that appeared around the same time was Refix. I will openly admit that I discarded that project for it's reliance on assemblies as the package unit, something I didn't think would fit with what I needed to build. Still, they had their [first commit](http://refix.codeplex.com/SourceControl/changeset/changes/d37605cca276) in **May 2010**, and as such had something out at the same time as OpenWrap.

**Bring in the OpenWrap**

Now this is what I knew about the package management world in .net at the time, and those are the reasons why none of the projects that existed ended up being a foundation for OpenWrap, however hard I tried and prototyped.

So in August / September 2009, I started prototyping a couple of ideas of how the system could work. I presented them to a couple of MVPs and community leaders in **December 2009**, showing the dynamic resharper injection of dependencies and MSBuild interaction that would become OpenWrap 1.0 in** September 2010**.

At Mix in Vegas in **March 2009**, I discussed extensively what OpenWrap was and what it was doing with certain PMs from Microsoft, an interesting fact for what is to follow.

This got published as source code in **[May 2010](https://github.com/openrasta/openwrap/commit/49d0419e6a6dbe370dddeed4a36ff04f7f245596)**, for the [progressive.net workshop](http://skillsmatter.com/podcast/open-source-dot-net/packaging-with-openwrap) I did on dependency management in .net in London.

**The NuGet appearance**

For the sake of objectivity, I can only reveal what is public knowledge of how NuGet came to be, so let's analyze what others have said and try to reconstruct the history of NuGet.

NuGet used to be called NuPack when it was [first announced](http://www.outercurve.org/News/articleType/ArticleView/articleId/20/Outercurve-Foundation-Announces-NuPack-as-Fifth-Project-in-ASPNET-Open-Source-Gallery) in **October 2010 **(by the outercurve foundation annoucenment), and their [public code](http://nuget.codeplex.com/SourceControl/changeset/changes/bb979bf0b7e2) dates back to **August 2010**. Thanks to a post from [Rob Reynolds](http://devlicio.us/blogs/rob_reynolds/archive/2010/10/06/the-evolution-of-package-management-for-net.aspx), we also know that initially the project was called NPack and was started 4 months before the last Nubular reset, which would put the start of the NPack project around between **January **and** March 2010**.

According to the press release from the outercurve foundation, both Nubular and NuGet "decided to collaborate and contribute the combined project to the Foundation".

Thanks to [Bil Simser](http://weblogs.asp.net/bsimser/archive/2010/10/06/unicorns-triple-rainbows-package-management-and-lasers.aspx), we know that the nubular guys were "approached by Microsoft about a double-secret-probation project that they were looking for feedback on. Together with [Rob Reynolds](http://ferventcoder.com/), [Dru Sellers](http://codebetter.com/blogs/dru.sellers/default.aspx), and [Eric Hexter](http://www.lostechies.com/blogs/hex/default.aspx) [they] spent the next few weeks collaborating together with Microsoft directly on NuPack.".

This tells us two things:



	
  * First, the last update to code in nubular by any of those contributors dates back from the [31st of August](https://github.com/nu/nu/commit/c5b24448e4f645dd0a7b2e90ca346fe33da472b1). We can go further, as Bil places the Microsoft outreach after the wiki arrived and a user blog post was created (which was in the beginning of August 2010). As such we know that the communication between the Nubular guys and NuPack was between the beginning and the end of August 2010.

	
  * Second, the fact that code on NuPack dates back from **August 2010**, and the fact that the first commit from any of the contributors referred to by Bil is from the **19th of September 2010**, means that there is no known contribution between the date at which NuPack outreached to Nubular and the time the first commit from any of those contributors ever contributed back to that project.




To put it more clearly: **nupack is not nubular, nor has code merged**. The source code shows us that the nubular project **abandonned** all their code, moved to the solution Microsoft had built, and merged _communities_. I suppose it was a natural extension to their "let's not build infrastructure" mantra that made them not want to work on OpenWrap at the time.




A while later, the project went through their third renaming excercise, to become NuGet.




It is now an open-source project, it was from September, but it wasn't when it was NPack built without the community.




Many have questioned if Microsoft had approached OpenWrap about collaborating together, and I can safely say that no such proposal was ever made by anyone on that team and any suggestion that there was an outreached invitation to merge projects, code, philosophies and communities to those involved in OpenWrap would be inaccurate. As such, we continued and are continuing building OpenWrap.










**Where we are now**




There are a couple of truth that need to be told, or as we say in French, one has to give to Caesar what belongs to Caesar.




Without Microsoft entering the package manage world, we wouldn't have the number of packages we now have. And for OpenWrap, this is great news, as since the early previews of the latest arrival on the package management scene, we've supported their feeds and package formats. This makes OpenWrap the package manager with the **most packages** on the .net platform.




The VS integration that those guys built with PowerShell is cool, and I like it. Especially of course as it means you can run OpenWrap directly from the _Package Management Console_.




The history is not all rosy, and quite a few times the NuGet team has taken has impacted our users in OpenWrap, mostly because they either take a completely different point of view, or break expectations that a project like OpenWrap makes about packages, with no communication channel outreaching from MS back to us. This has been documented [over](http://www.developerfusion.com/news/92152/nuget-surprise-update-breaks-openwrap-open-standard-not-so-open/) and [over ](http://nuget.codeplex.com/discussions/237992?ProjectName=nuget)again so there is no need to repeat the obvious there, collaboration has not happened.




**Conclusion and the future**




The goal of this post is not to diminish anyone's effort in package management, it's a hard space to crack, but to tell history as it happened. Many package managers in .net existed, few survived and historical data doesn't support some content out there that takes liberty with reality.




I hope through this post that I have explained where everything came from, how we got where we are. And it is my hope that this is the last time that I have to explain why OpenWrap exists when NuGet also does.




In the end, growing the market is good for everyone. If we manage to work together in the future by taking care of the impact that each of us have on each others, we may actually be able to grow together. So far it's been hit and miss, and more miss than hits, and it's my sincere wish that, by clearing up the past with **facts**, facing reality and moving forward **responsibly**, we can all work towards a greater good without killing the ecosystem.




Are you up for the challenge?
