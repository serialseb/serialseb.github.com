---

comments: true
date: 2010-12-13 18:45:02+00:00
layout: post
slug: nuget-feed-has-changed-again-and-broken-openwrap-again
title: NuGet feed has changed again, and broken OpenWrap again.
wordpress_id: 28
---

Just a quick note that the NuGet feed has had some more changes that have broken OpenWrap once more. As usual, this wasn’t quite documented anywhere nor did we get told about it in time for their release.



We are waiting on Microsoft to clarify what the changes are, to make sure we don’t implement it wrong. It’s very important, as while OpenWrap supports dependency levelling, NuGet doesn’t, and differences in behaviour between the two managers have to be levelled out somehow.



In the meantime, a new version of OpenWrap is available that should continue functioning with the yet again new format.



The URI to add to your remotes is now [nuget://feed.nuget.org/rtm/odata/v1/Packages](//feed.nuget.org/rtm/odata/v1/Packages)



We are sorry that we cannot provide guarantees to how long integration with NuGet will stay up-and-running, but as the effort is all on our side, it’s a game of cat and mouse. On the bright side, we still support all the other previous formats NuGet ever had, so by using OpenWrap today you won’t be broken by the multiple incompatibilities introduced by NuGet.



Note that the NuSpec functionality has changed again too, and we don’t support it yet, moving from a simple min/max to the more complex and unreadable maven format. We’ll be adding those back in the conversion process soon.
