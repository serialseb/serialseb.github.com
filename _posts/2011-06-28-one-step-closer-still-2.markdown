---

comments: true
date: 2011-06-28 21:59:39+00:00
layout: post
slug: one-step-closer-still-2
title: One step closer still
wordpress_id: 64
---

One of the things that OpenWrap 2.0 will feature is dynamic loading and unloading of “solution plugins”, components that load up when you start working on a solution, and unload cleanly when you move to another solution.

One of the side-effects of implementing this is a very cool feature for ReSharper I’m just not ready to announce yet, but that will make sharing ReSharper plugins with your team so easy you’ll wonder how you ever lived without it.

So now this is what happens when you update a package your solution depends on.
    
    Loading packages...
    Loading package C:\demos\soladd2\wraps\_cache\openwrap-1.1.0.71250693
    Loading package C:\demos\soladd2\wraps\_cache\SharpZipLib-0.86.0
    Loading package C:\demos\soladd2\wraps\_cache\openfilesystem-1.0.0.61263243
    Loading package C:\demos\soladd2\wraps\_cache\tdnet-framework-2.0.0.48555719
    Loading package C:\demos\soladd2\wraps\_cache\Mono.Cecil-0.9.4.1
    Solution plugins starting...
    Starting plugin AssemblyReferenceNotificationsPlugin.
    Starting plugin ReSharperLoaderPlugin.
    Resharper Plugin Manager loaded (99.99.0.13133).
    Solution opened ClassLibrary1
    All solution plugins started.
    ReSharper test runner starting.
    Solution plugins stopping...
    Stopping plugin AssemblyReferenceNotificationsPlugin.
    Stopping plugin ReSharperLoaderPlugin.
    Unloading Resharper Plugin Manager.
    All solution plugins stopped.
    Default scope change detected, restarting...
    Loading packages...
    Loading package C:\demos\soladd2\wraps\_cache\openwrap-1.1.0.71250880
    Loading package C:\demos\soladd2\wraps\_cache\SharpZipLib-0.86.0
    Loading package C:\demos\soladd2\wraps\_cache\openfilesystem-1.0.0.61263243
    Loading package C:\demos\soladd2\wraps\_cache\tdnet-framework-2.0.0.48555719
    Loading package C:\demos\soladd2\wraps\_cache\Mono.Cecil-0.9.4.1
    Solution plugins starting...
    Starting plugin AssemblyReferenceNotificationsPlugin.
    Starting plugin ReSharperLoaderPlugin.
    Resharper Plugin Manager loaded (99.99.0.13324).
    Solution opened ClassLibrary1
    All solution plugins started.
    ReSharper test runner starting.
    







There’s a lot going on in there and I’ll be blogging about it soon. If you ever wondered how to build Visual Studio add-ins and still support live updates, then you may just have your answer very soon.




More next week….







Technorati Tags: [openwrap](http://technorati.com/tags/openwrap)
