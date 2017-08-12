---
layout: post
title: Code Beauty
date: 2003-11-12T00:22:30+00:00
---

Luke Hutteman's public virtual MemoryStream]

To answer [this](http://www.hanselman.com/blog/PermaLink.aspx?guid=33f50d62-4ff7-4750-b6bc-535621b8dca1) from Scott, let me tell you my story.

Any day at any new project coding session. Meeting for an hour or two with R&D to understand what they want. This is the moment I suffer the most in my work. I've worked as a contractor before, and the beauty of this job is that you really need to understand what the guy in front of you wants to accomplish. You have to understand what he needs, so you have to understand his work. Up to the point where you can do it instead of him (which most of the time is the case as, once your software is done, the guy just use it to do the job). But you know this is only the tip of the iceberg. You can start feeling the coldness of the diagrams flowing through your body.

Back to the desk. Pen, paper, Brahms in the ears, tell anyone not to disturb for an hour. You know you'll need more, but you also know it will be some kind of a stress relief when you'll tell them to go away in an hour. And start sketching.

No no, don't start with a very clear diagram. You know your head is not working like that. Graphically design the result data, and try to make some sense of it. Add a lot of boring stuff and design 100 SQL tables to comply with what you have in mind, your grand scheme. You know, that killer uber application that is supposed to be released 5 years ago.

Draw again, now talking in C#. This is thrilling, you get one class right. You can feel the pressure, because you know you have a beginning. And you start sketching more and more. You build carefully your whole system in your head, you see classes, runtime instances, planets, all turning around a big XML document being married to an XSD Schema by Don Box wearing a Yellow suit (don't ask me why).

And then, disaster. You missed a small piece. And this is the moment where you start being insane. You know you missed something so fundamental (in your eyes) that you're going to have to rewrite most of your code. But remember, at this point you have no code, which is even more frightening. You thought you were handling it quite close, and it went away. This is where the dilemma starts. Hack away a quick solution and think about it for the later release of the product? Or redesign everything again? Please note this only happens when :

The full binary is scheduled for last week
Your manager doesn't want to wait because a director promised the feature would be there without asking anyone before hand if it was even feasible
It's raining outside, you're cold, the heater in the office is off, you forgot to buy cigarettes and there's no coffee or Redbull near you
Don Box is wearing a yellow suit.
This is where most developers / architects enter an introspection phase. You stop shaving, you spend all your time drawing on a tabletPC or a drawing board. You talk to yourself while walking around the office, whispering things like "This class must not be responsible for that, because if it does, the other class doesn't have control of the execution graph".

This is when you get home. And this is when you hear : "Honey, you know, if they don't care, why do you? And if you don't shave that beard, you sleep on the sofa!".

This is what leads you to either of the following solution:

After this whole week / month / year / product cycle, you decide to cut off your requirements, hack something for the client and go to bed
This electric shock treatment hurts your brain, which starts drawing a full schema of the whole architecture in your head, as clear as a sun in the night. In that case, you don't go to bed, but you can make up for it the next day.
I'm in the middle of one of these phases. 2 happened tonight. Coding session ahead of me.
