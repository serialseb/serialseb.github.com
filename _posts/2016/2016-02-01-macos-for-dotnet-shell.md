---
layout: post
comments: true
date: 2016-02-01 22:30:00
title: macOS for the .net guy – Learning the Shell
---
I've been lazy. I switch to a mac a long long time ago, and my dream since then has been to finally stop using windows altogether.

I've not enjoyed Windows since nautilus, which never actually got a release, and we're talking 1996. But I love .net, amongst many other ecosystems I enjoy working with, and so I've had VMWare installed as a faithful companion for a long time. But the performance sucks, and VMWare just fired everyone on that team to send the work to China or what not, and with .net core getting a story on unix platforms, it's more than time that I accept that it's not him it's me, and move out.

This serial will be all the things I am doing to live my life away from Windows, both to force me to give the ring back, and to make sure I learn how to date again, in this instance, macOS (stil called OSX by some people for now, but meh.)

Early warning, I have no idea what I'm doing, so any comment / feedback / tips / cool tools to make the transition smooth, use the comments! Another warning, this entry is open to guys of all genders, shapes, colors, planet of origin, it's a play on words on a popular TV show I never saw.

## Shell, shell, shell

First step in my transition is the shell. I love shells, and I suck at them on unix, because powershell. So the first step in doing anything useful on a mac is to install [homebrew][homebrew].

Homebrew is a command-line package manager, not dissimilar to chocolatey, but without the msis.

Start the Terminal, or Terminal.app, and put it in full screen. There you go, plenty of space to play with now.

To install homebrew, we need a version of ruby that works. Thankfully, Apple provides us with a bunch of things in their _Command Line tools_, so let's go ahead and install that.

```
cherenkov:~ serialseb$ xcode-select --install
```

Agree to sell you first-born child, wait a short while, and you're ready. Now let's install Homebrew itself.

```
cherenkov:~ serialseb$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

You can now install tools from the command-line very easily. Everything else in this serial will require this basis, so tap yourself on the back, you took your first step to moving on.

It's not necessarily the destination that matters, but let's make the journey as fun as we can!

[brew]: <http://homebrew.sh>
