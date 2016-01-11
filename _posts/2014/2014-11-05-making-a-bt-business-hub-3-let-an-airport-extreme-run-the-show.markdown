---
comments: true
date: 2014-11-05 20:12:36+00:00
layout: post
slug: making-a-bt-business-hub-3-let-an-airport-extreme-run-the-show
title: Making a BT Business Hub 3 let an Airport Extreme run the show
wordpress_id: 178
---

This entry will be very localised to the British isles (see what I did there?).

I've been a BT customer for a long time, and their hub is an absolute nightmare, a piece of crap, a useless chunk of equipment full of bugs, overheating issues and impossibility to manage even UpnP, across modems and across phone lines, not to mention security issues and random hijacking of DNS to show you some static html page about unpaid bills.

So to try and enjoy the internet for a little while every night, I've put together a user story, after a year of shoddy service.

User story:
In order to enjoy the internet reliably,
As a BT Business Customer and an Apple customer
I want to be able to not use the BT Business Hub as a PPPoE modem
and use my Airport Extreme for everything

After hours of going through forums with ridiculous, inaccurate or plain unhelpful advice, I've cracked it.

First, plug your airport extreme and configure it's wifi as you want it. If you have an iOS device, this is dumb simple: Settings, Wifi, configure new airport. Set it to use PPPoE and use the network login username and password you received in a paper letter once upon a time. You're done, leave the Airport to restart and get ready.

Plug yourself to an ethernet port on the BT Hub. Configure your network adapter to use a static IP in the same netmask (192.168.1.42 sounds reasonable).

Go to the settings (http://192.168.1.254/  usually), and do the following, in order:




  1. Deactivate wireless. That access point has terrible coverage, you're better off without.


  2. Put the hub in Bridge mode (Settings > Broadband > Routing at the end of the page, Bridge mode enabled)


  3. At that point, you probably already tried that, and failed miserably to PPPoE. So instead go for the hidden page on the router, at http://192.168.1.254/thd_setup and set the encapsulation to LLC. Save


Now you're all ready, connect the WAN port on your Airport Extreme to an Ethernet port on the BT Business Hub, and see the connection being made.

I'll be making the same changes in my home flat. If all goes well, I shall finally manage to use the internet properly.

Enjoy!
