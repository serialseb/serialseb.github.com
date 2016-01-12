---

comments: false
date: 2011-03-15 06:15:10+00:00
layout: post
slug: opening-a-solution-from-the-command-line-in-powershell
title: Opening a solution from the command line in PowerShell
wordpress_id: 40
---

As you probably have realized by now, I love the command line. It’s the most productive tool we can have. And as I’ve not blogged very much lately, with me being busy building OpenHttp, OpenRasta 3, OpenWrap and other lovely Open things, I thought I’d share a quick snippet I use on a daily basis with powershell.
    
    ls -in *.sln -r | select -first 1 | %{ ii $_.FullName }







What this little script does is find the first solution file under your current path and open it in Visual Studio. Trivial but a time saver over and over again.
