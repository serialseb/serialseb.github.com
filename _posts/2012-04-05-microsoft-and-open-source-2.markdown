---
author: sebastienlambla
comments: true
date: 2012-04-05 11:44:09+00:00
layout: post
slug: microsoft-and-open-source-2
title: Microsoft and Open Source
wordpress_id: 143
---

I have been a vocal, and sometimes harsh, critic of Microsoft’s approach to Open Source Software. I call that activism, some call it whining, ranting or _pisser dans la soupe._ People are entitled to their opinion, and mine has been formed after working in the Microsoft sphere for more or less 14 years.

Over the years, the various component organizations within Microsoft have had various levels of involvement with Open Source, with different philosophies, and from what I have gathered over the years from post-conference drinks, internal conflicts that can be quite a challenge.

As this post is going to be long, I’m going to sum-up the problem, and you can go to the conclusion bit to read what I believe should be done differently.

Microsoft has no _vision_ when it comes to Open-Source, no strategy and no leadership. Some groups are seen as more progressive, and do tend towards a better approach to OSS. Some people consider those steps as sufficient to stop pressuring Microsoft towards responsible OSS, and I disagree: it’s only some groups, and even within those groups, the advances are still very much one of exporter. Recognizing Microsoft as an OSS-friendly player is like recognizing the People’s Republic of China under the Reagan administration, it’s a step in the direction of normalization, not a recognition of the Human Right lifetime achievements of Mao Tsedung.

[![Untitled6](http://codebetter.com/sebastienlambla/files/2012/04/Untitled6_thumb.jpg)](http://codebetter.com/sebastienlambla/files/2012/04/Untitled6.jpg)You know why I **know** Microsoft has no leadership and vision when it comes to Open-Source? Because I asked Steve Ballmer when he was in London, and he replied with this: “I don’t know, but we won’t impose any view on our divisions. I’ll come back to you by email though.” Steve, my email is still [seb@serialseb.com](mailto:seb@serialseb.com) and I’m looking forward to your views.


## Where we come from


The current state of affairs is not bad, considering where Microsoft was years ago. We’re talking about a company that positioned itself as the defender of private code, vilifying OSS licenses, having no visible OSS project going and providing its value as the integrated stack: it’s all MS or none. We have certainly come a long way.


## Opening up slowly


I think under the influence of Scott Guthrie, an internal change started deep within the asp.net team ranks, certainly a movement that resulted in the recent announcement of the opening up of the asp.net webstack as a true Open-Source project.

Now **that’s **commendable, and I applaud the move. Open-Sourcing and opening up to collaborative development for stuff you’ve built is great. Well done.


## Not invented in Redmond syndrome


Let’s be clear. The goal of MVC was to build a better Monorail, as opposed to help Monorail productize their framework for inclusion in Visual Studio.

The exact same thing happened with Nuget. With multiple projects with different approaches already in the work, Microsoft started their NPack project (I seem to recall someone at Oredev mentioning it was originally built as part of the WebPages tooling). It wasn’t to be open-source to start with, hence why the existing OSS projects didn’t get the news until much later.

But, I hear you say, Nuget is an open-source project from Outercurve, and they combined their code with another project. The open-sourcing was decided very late in that process, once the investment in code was so large that the ship had left already and nothing would stop it. And on a side-note, there was no merging of the code, the Outercurve foundation’s press release was inaccurate, just look at the history.

What really happens when a new project gets produced by Microsoft? It sucks the air out of a lot of community projects, often including all the best ideas of said projects, and Microsoft gives nothing back. If you’re in that boat, you either redraw your plans based on their new announcements (usually rewriting on top of the new shiny stuff), or you dissolve your group and join their OSS project (the Nuget / Nubular case).

Certain projects (like nhibernate and nunit) continue to happily go forward, and maybe the OSS alternatives that are impacted by Microsoft entering a space just were not good enough. I don’t know, we’ll see in a few years.


## Adoption of existing projects


Of course it can be said, and there again, I commend Microsoft for the move, that libraries such as jQuery, modernizr and now Newtonsoft.Json, are being used, supported by Microsoft and shipped alongside the product.

This is also a great departure from time immemorials. Makes no mistake however, Microsoft is being pushed by market pressure to integrate with those frameworks. The change is only that they’re abandoning slowly the idea that they’ll release until they gain marketshare, in those domains where Microsoft has historically been slow at releasing compared to alternative platforms.

This is only an opinion piece, but I’ll suggest that the move to gain web development share has pushed Microsoft towards dropping the projects they had and failed to make popular (the asp.net  AJAX stuff that got more or less killed when jQuery was adopted). And I think that’s great.

Pragmatism is also the reason why newtonsoft.json is being used by Web API. The current Json providers on .net are broken, there is no way to provide the customization people want, and fixing them cannot be done in the same release cycles as MVC, as some are part of the core framework (and may or may never be fixed, but certainly not in time for the next release).

It was not chosen because Microsoft wants to adopt more external OSS projects as their core vision. It was chosen because they couldn’t fix what was broken and rebuilding would have been silly.

_On a side-note, twitter conversations started going in the direction of why Newtonsoft.Json was chosen over other libraries. I made the assertion that provided it’s an internal implementation with no exposed surface, the choice of *any* json lib would’ve been fine. ScottHa said it was because the library was the most popular, and testing was done on their part. That lead me to the assertion that if the only library under consideration was chosen for popularity, **and** there is no exposed surface of that lib on public APIs, the choice is one of brand-surfing and gives extra marketing points to their OSS credentials. If some of the API is exposed, it was probably a reasonable choice. I don’t care which library you chose, I care the process you used to chose which library and the reasoning behind it. I question (and by question, I mean discuss) the motives, not the solution._

_[Edit: After looking for it (as the twiterverse didn’t reply to the specific of the discussion), one object from json.net *is* exposed on the [JsonMediaTypeFormatter](http://aspnetwebstack.codeplex.com/SourceControl/changeset/view/55f7dc693838#src%2fSystem.Net.Http.Formatting%2fFormatting%2fJsonMediaTypeFormatter.cs), so that is that and I’ll stick to my original analysis, it’s probably a reasonable choice.]_

There is no vision, because there is no systemic approach to deciding between building and joining communities.

Asp.net Web API could have quite happily join existing OSS projects that dealt with this problem area years ago, but it wasn’t to be. Nuget funding could have been used on top of existing projects, instead of a pure creation, but it wasn’t to be either. What is the decision process behind the rebuild or join decision?

And can anyone that has had their project get the oxygen sucked out of, with nothing given back, be blamed for distrusting the company?


## [![220px-Borg_Queen_2372](http://codebetter.com/sebastienlambla/files/2012/04/220px-Borg_Queen_2372_thumb.jpg)](http://codebetter.com/sebastienlambla/files/2012/04/220px-Borg_Queen_2372.jpg)The corporation


When the Web API project was being kicked off, [Glenn Block](http://codebetter.com/glennblock/) called me asking me if I thought he should take the job, and if he did, would I help. I told him what I’m telling you now: Yes, you can’t do as bad as the previous attempts, and I’ll happily help to make sure the architecture and model fits the reality of what developers want, we’ll all win. I helped because I was asked. Ideally I’d rather they had asked me to work on OpenRasta and create a new version with us, but it was not to be. In the end, the two frameworks may have very different code, but most of the concepts and conventions are exactly the same, so everyone will feel right at home on both platforms, and that’s in no small measure because the brilliant minds behind Web API respected HTTP as much as I and the other advisors did.

More recently, [Drew Miller](http://www.twitter.com/anglicangeek) from the NuGet team has been very active in opening communication channels with OpenWrap, something that has not existed ever, and he should be applauded for it: I can now have a discussion about our interop story with someone that wants to make things better. Again, I’d rather the NuGet team had joined OpenWrap rather than communicate to us their imminent release, way too late to get any positive outcome, but at least it’s a step in the right direction.

Those are individuals, not the company, and out of all the voices out there, they are a minority. You cannot judge the whole company on specific individuals, and teams cannot use the excuse _Microsoft is really many companies_. That is certainly true, but completely irrelevant to external agents when judging how the company deals with OSS.


## [![transparency](http://codebetter.com/sebastienlambla/files/2012/04/transparency_thumb.jpg)](http://codebetter.com/sebastienlambla/files/2012/04/transparency.jpg)How to fix this


Three words, transparency, transparency, transparency.

When you have an idea for a product, and there are existing Open-Source projects out there that have adoption and could really help the resources of a big vendor, try and justify the choice.

If you’re going to rebuild, take the phone, call the leader, explain your plans, and don’t be a douche about it (aka telling someone “we realize we are stepping on toes here but we’re big so it’ll happen” is not particularly a great way to deliver the news). Chances are, they’ll probably understand the reasoning. ISVs have had [that communication channel from Microsoft for years](http://www.ericsink.com/item_10169.html), and get to know about competing products way in advance, but it’s not the case for OSS projects.

Be open about the process afterwards too. The policy of not mentioning anyone, or pretending you cannot look at existing projects at all in public, would make anyone think you have something to hide. It probably is against some corporate policy somewhere, but make that change, you did do it about the no-OSS policy.

And finally, value the people on your platform, the loud mouths like me and the small guys that abandon their projects because you started yours. We are on your platform because we like it, and we want to make it better. And maybe if you’re going to step on people’s toes, try to find a band aid for them to sweeten the blow, and find a way to collaborate on something else with them. Don’t lose the people that have been developing the ideas you’re going to be building on, it’s not good business.

If these things had happened in the last few years, I wouldn’t distrust Microsoft-the-company as much as I do now. But the bridges that are being built by bright individuals inside the company do go in the right direction.

Is that going to be enough? I sincerely don’t know, but until we’re there, I’ll continue shouting at the top of my voice for Microsoft to become the business partner my OSS projects wants to be dealing with.

It’s called tough love, silly.

_[Edit: added an additional paragraph to project competition]_

_[Edit 2: added a bit on the json.net choice]_
