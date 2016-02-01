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

The shell is a bit like the command-line that you already know, be it `cmd.com` or `powershell.exe`. But not quite, so let's review just the basics to get you started.

Start the Terminal, or Terminal.app, and put it in full screen, which is the little green icon on the top left of the app bar. There you go, plenty of space to play with for now.

### Moving around

`cd` still works, but like most modern operating systems (and technically NT too, but we never use that), things are not in the same place, because everyting starts at `/`, which is the root.

Thankfully, you already know that, because when you go to a website, say, `http://serialseb.com`, it's actually `http://serialseb.com/`, so you should already be comfy with the idea of a root.

There is no place like __home__ however, and you'll probably end up in your home directory often. This is the equivalent of `C:\Users\yourusername\`, and we can navigate to it using `cd ~`.

To list things, no `dir` command, we replace it with `ls`. On it's own, it can be rather confusing, so the equivalent seems to be `ls -al`.

### The prompt

By default, the prompt shows you a bunch of things: the computer name, the current user, and where you are, followed by a `$` instead of `>`. After all, money beats greatness, right?

When I start my terminal, I see the following.

```
cherenkov:~ serialseb$
```

Cherenkov is my machine name, and like all my computers is named after anything to do with light. As an aside, it's named after the cherenkov effect, where protons and neutrons are thrown at close to the phase speed of light, but light is slowed down by heavy water, and so those particles travel faster than light in that medium, resulting in a lovely blue halo. You can't say you don't learn things on here!

### Install all the things

When you're in a shell, the last thing you wanna do is go download package files from a web site using clicks everywhere, cause let's face it, it takes using the trackpad, and the keyboard is your friend. So the first step in doing anything useful on a mac is to install [homebrew][homebrew].

Homebrew is a command-line package manager, not dissimilar to [chocolatey][chocolatey], but without the MSIs.

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

[homebrew]: <http://homebrew.sh>
[chocolatey]: <https://chocolatey.org>
