---
title: Architecture in code
date: 2016-08-18 19:38:00 +0100
comments: true
tags: [architecture]
image:
  feature: architecture.jpg
---

When we build systems, we model the world around us: models, commands, events,
resources, they're all intellectual spectres of reality that help us reason. 
Yet, most of the code we build tends to focus on implementation. From the code,
you would have no way of knowing what models you used.

Messaging is a good example. I've been working on distributed messaging systems
for eons now, and I see the same implementation over and over again.

```csharp
// not an actual library
MyAwesomeQueueSystem
  .ListenOn(MyFabTopicNameBuilder("home"))
  .IntoQueue("reaction")
  .Handle(message => new MyHandler().Handle(message));

class MyHandler : IHandle<Event> {
  void Handle(Event) {
    if (Event is Spider)
      me.Jump();
  }
}
```

If you look at this code as-is, you can only know that a thing happens that
causes a message to be posted and a "handler" to "handle" said message.

In reality, external stimulii often trigger certain actions from us, which 
themselves cause other events. An enormous spider next to me may make me jump
which may well result into me breaking glasses. I have external stimulii that
I know, like spiders crawling, which are events. I have commands, like jumping. I have breaking
glasses, which are other events.

Now that explanation makes sense, but the code is not giving you that. The code
gives you a very different explanation. The sun, through thermonuclear reaction
causes photons to travel at the speed of light all the way through my windows to
my sofa, which get scattered by a calcium-based molecular structure, hitting my
retina. Through a set of neurons interconnected through electrochemical
 connections, triggers a flight response, releasing a high dose
of adrenaline, causing an automatic muscular response...

The description is now too detailed, and it becomes very hard to know why I
broke the glass. It would also become increasingly difficult to explain to you
various other reactions that would lead me to break the glass. Without a model,
I can't explain clearly that a divorce and a zombie would also cause me to break
glass.

In terms of code, the fact that we focus on the low level of event subscription
doesn't allow us to do anything but what the procedural code dictates,
introducing systematic variance, not due to need but due to having no model.

It also prevents us from reflecting on the model. I used to have panic attacks
when boarding plane, which for a conference hopper is a rather problematic
condition. It's only once I managed to model my triggers, and model my commands,
that I managed to get rid of it. All the same, in code, without a model that
can be introspected on, I have no way of reflecting on what my software does, 
be it that I want to understand it, or like [Simon Brown][simonbrown] does,
document, graph and represent it.

Instead of going for pure messaging, model your messaging patterns to encode
in your code what concepts they implement. For example, instead of the 
`IHandle<T>`, why not model what you do?

```csharp
public interface IHandleComponentCommand<T> {
}
public interface IListenToExternalEvent<T> {
}
```

Going one step further, both OpenRasta and FubuMvc used to favour the idea of
a configuration mdoel, where all information about your system are pulled into
before you actually spin up the system. This allows any further component to
have enough information to configure queues, add http handlers, and everything
else you may need to spin up the software.

If your model is not rich enough to generate all the plumbing from it, then
your model is insufficient to document what your software does. And when you
need something that your model can't cope with, update your model.

[simonbrown]: <http://www.codingthearchitecture.com/blogentries/1.html>