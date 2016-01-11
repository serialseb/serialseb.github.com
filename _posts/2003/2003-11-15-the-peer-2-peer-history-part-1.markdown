---
layout: post
title: The Peer 2 Peer History, Part 1
modified:
categories:
excerpt:
tags: []
image:
  feature:
date: 2003-11-15T12:07:38+00:00
---

Hello dear readers, as promised, the first part of my peer 2 peer history. I’ll try to remember what happened since I started being involved in this movement, and will go up to seeing what Microsoft is planning with Longhorn.

What exactly is peer2peer? To put it simply, a peer 2 peer technology enables communication between computers with nearly no intervention form a server. Another explanation would be that, in a perfect p2p world, there would be no client, and only servers. Basically, what the web was before dial-up ISP appeared. The internet was a p2p architecture at its heart. So, why the focus in 2000 on this “new” peer to peer architecture? Because…

A long time ago, Napster was released. I won’t go through why and how it appeared or why and how it got crushed. Napster was a so-called p2p application, that let people connect to a server to know what files other people are sharing, and download these files directly from these other people. Technically, napster had nothing interesting to talk about, so I won’t go through it.

A short while after the Napster, a new software, gnutella, was released by Nullsoft. The story of gnutella is quite interesting. To put it short, it was published, lasted for a few days on AOL servers before [disappearing](https://web.archive.org/web/20031119013643/http://thetechnologist.is-a-geek.com/blog/ct.ashx?id=e9cd246e-2141-4a54-8f16-c357667606a2&url=http://www.cnn.com/2000/TECH/ptech/03/15/gnutella/). The technology being gnutella is quite interesting. Instead of relying on a central server to advertise files the user is sharing, the connection to a gnutella network is quite different:

·         The first step is to connect to the network. Because there is no server, the client must find a new IP address to connect to. This is the bootstrap stage. In the first few days of gnutella, this meant going on IRC, asking for an IP, and try connecting. Later on, each software vendor established their own public IP to let people connect faster.

·         Once you’re connected, you send a search. Your search is just a string, and is sent to the computer you’re connected to. This computer sends you back the list of files containing the string, and forward your request to all the computers it’s connected to, which in turn reply and forward. This method is called a broadcast, and was the most common operation on the network, and the one taking up most of the bandwidth users had. Your search was forwarded to a maximum of 7 hops, which meant quite a lot of computers. The network data contained two counts, TTL for time to live, and HOPS for the number of computers already seen.

·         When you wanted to download a file, you connected out of band using HTTP to the other computer having the file.

The software used to connect to the gnutella network was named a servent, a contraction of server and client. The big deal here is that everything was running without a central server, without a central authority, and without any form of potential failure point. The network was bootstrapped, autonomous and living a life on its own.

When I joined the gnutella community, in late march 2000, I met a lot of people, mainly on IRC. These people were both very smart, dedicated, and willing to move things forward. Let’s face it, the first releases of the gnutella software from nullsoft was crap. Ugly, not working, had bugs, etc. And there was no reason to call it gnu as the source code was absolutely not open source.

The people I met started deciphering the gnutella network protocol, which was a fast and easy process considering the very low complexity of the data structures. I even wrote a client in VB at the time, just for fun.

After just a few weeks of dicussing mainly with Gene Khan, which took upon himself to be the contact point for anything gnutella related in the world, and with people such as Ben Houston, a few things were very apparent:

·         Information on the current gnutella protocol was sparse, developers were missing a place to discuss about the current technology to implement their own software.

·         People needed a place to ask questions such as “What is the IP address”, or “Where can I download a client”. Newbie’s questions.

·         The gnutella protocol sucked and badly needed to be replaced / extended.

So in April, we split the gnutella IRC forum and web site in three. One, gnutella, would be the PR group, and handling all the public (understand not developers) questions. The second, gnutella-dev, would help the developers’ community to implement the gnutella protocol and behavior recommendations, to help create more software using gnutella. The third one, gnutella-ng, was the place where we were supposed to create a new gnutella protocol, erasing what mistakes we did in the past, while reusing the concepts of gnutella, to create a better world. I was the main architect of all these changes, and only took gnutella-ng in hands. Gene was keeping gnutella, and gnutella-dev was to be very open to anyone. I’m afraid I don’t remember who was in charge of it.

All these web sites were handled on wego.com. http://gnutellang.wego.com won’t get you very far, but once upon a time, it was a very busy web site.

Continued in part 2, soon.
