---
title: Agile Anarchy – Null Design
date: 2016-03-08 21:30:00 +0000
serial: agile-anarchy
tags: [agile, mobprogramming]
comments: true
---

It is rare these days that I see developers working alone. Pairing has broken into the mainstream, and yet it is rare to find a pair you're comfortable pairing with, and we still don't quite know what is going on in other pair's work.

So we have two problems, knowledge sharing is slow when you divide work into pairs, and it can become uncomfortable to pair with some people due to a skill difference, a coding speed difference, or a different way of thinking.

You can try to fix the first problem by rotating pairs often. Too often and no one ever finishes anything, too little and little pockets of styling and knowledge get created. As we all suffer from the inevitable churn rate of high-flying consultants, we also have to contend with changing that rotation speed often as the team evolves. In my experience, it is an extremely challenging problem.

Knowledge sharing, and it's extension, norming of a coding style and practice in a team, is also very slow with pairs. You have to continuously re-argue, re-discuss, show again, and again, for each pair, for each concept, what you'd like to see happen, or what you know. By definition, if you rotate every other day in a team of 6, a simple idea will take 10 days to get around the team. Wow.

We decided instead to try mobprogramming. In this scenario, all of us sit together, with one keyboard and one mouse (for those developers that cannot get over the point and click...)

A big projector or a large screen displays the current coding session, and the guy with the keyboard does the coding, as we discuss our first specification to implement. Group discussion is involved at each step, going back and forth to the whiteboard.

One of the highest costs in development is not having known the simple way of doing something. How often have you had hours and hours on a problem, and while chatting with someone realised that all could be done in a few lines of that piece of code you did not know exist. By having everyone discuss the development of the current story, all brains are involved, and more often than not a better design evolves from the continuous mind stream we share.

Another very high cost is the continuous synchronisation teams that work in sub-groups have to do. Call them daily standup, code reviews, coding standard enforcement, these synchronisation primitives are expensive and wasteful. Because we all work together in one group, it becomes easier to norm, adapt each of our styles and ideas to one another until we become much more similar in the way we develop the code base.

As such, we save a lot of time. Synchronisation is no longer necessary, norming happens pretty quickly, we rarely chose the wrong design, and the code base has a nice unity to it that makes it more maintainable and reduces technical debt quite a bit.

Of course, mobprogramming is no silver bullet. You need a sense of decorum very specific to long-running conversations in groups. From notifying others that you are not participating due to emails, to letting people know where you are and for how long, to deciding who attends meetings, many little problems can come up. As we applied the null design idea, we started with no rules, and slowly added a few as problems were felt by the team.

Let's not kid ourselves, even months of mobprogramming will not turn the less senior people in a team into replacements for the most skilled people in your team. But I would argue that the level of learning across a team is higher in a mob than it is in a traditional orgranisation. There's no miracle but there's a clear improvement.

We mobbed all the time. What did we do with those long hours of boring code that needed to be worked on? The answer is quite shocking, those never materialised, because we never wrote that code. Configuration was nearly non-existent, build scripts were written once and worked across all projects by convention, and so were deployments were as well. Each small task that felt like it needed a procedural, hard to maintain script and manual process would be automated,applying simple conventions, and just not boring. And for the little things that were left, you could do them in flight while the rest of the mob kept on going.

A couple of months in, I asked the team if they wanted to spend a little less time mobprogramming so they could practice coding on their own as well. There was an overwhelming feedback that this was not needed and not welcome. A surprising result that certainly confirms my belief that mobprogramming may well be the biggest advance in development since the original XP.