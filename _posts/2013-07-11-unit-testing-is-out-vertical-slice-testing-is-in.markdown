---
author: sebastienlambla
comments: true
date: 2013-07-11 08:54:32+00:00
layout: post
slug: unit-testing-is-out-vertical-slice-testing-is-in
title: Unit testing is out, Vertical Slice Testing is in
wordpress_id: 169
---

We have been doing testing for a long time. Some people are practicing TDD, but I think that’s only 46 people in the world and [they all follow my twitter feed](http://poll.pollcode.com/pdolm_result?v).

</attention-seeking-headlines>

We all know the common issues people have with writing large test harnesses around systems: it seems to take a long time, existing code is difficult to test, subsequent changes to code makes a lot of existing tests fail or become redundant, and the test harnesses often can become brittle, in no small part because of the abusive use of mocking.

As a recovering TDD addict, I used to tell people, like many others do, that the issue with their TDD was that they didn’t do it right. If TDD is too hard, do more TDD! In other words, if it hurts, just bang that leg with that baseball bat a bit harder, eventually you will not hurt anymore.

I will come straight out with it: this approach to unit, integration and tdd testing has, by far and large, failed. It’s over. It is time to move on. I have, and I now do **VE**rtical **S**lice **T**esting.


## A law of diminishing returns


Whatever your test coverage, there is a point where more tests don’t equate more quality. Actually, let me be entirely honest here, I do not believe that a good test harness leads to better perceived quality software for your **users**.

The people you are trying to please with a good test harness are the ones using your system that are not on a high bandwidth medium with you. Usually that would be your team. To reduce the risk of them experiencing issues, and to increase the chance of them liking your software, you write tests so that their experience is positive.

A long time ago, I realized that testing everything is not always feasible for me, and I practice TDD all the time. A quick mental review of the teams I worked with in the last 12 years I’ve been practicing TDD also tells me that this fact is rather general.


## Mocking considered evil


I’ve never been a big fan of mocking frameworks, for one simple reason. Simple stubbing relies on assumptions on the functioning of the mocked part of your system that rarely match reality, for no one is going to look at all the documentation of an API and decompile the code when writing a one-line stub.

As you progress in your implementation, you may learn about more scenarios you didn’t cover, and provided you are in that tiny little fraction of a percent of people refactoring your test harness as you progress your implementation, you may feedback some of that knowledge in previous tests you wrote and in your test doubles, while caressing your pet unicorn and enjoying a bit of sunshine on planet [Equestria](http://mlp.wikia.com/wiki/Equestria). Or if you’re like the rest of us, you probably won’t.


## Increasing returns for user interfaces


Admitting to myself that I could not fix those problems (_you cant fix stupid!)_, I started trying to understand how I could bring some of the TDD practices I enjoyed (fast feedback, repeatable tests, etc) while increasing the perception of quality, leaving any theoretical or coverage notions behind me. Instead of starting from the components I want to put under test, I start with what my users, hum, **use**.

If I provide users with an API, I will start by the API that I decide to publish, and consider everything else implementation details. I will only document and polish, a.k.a. test, what **other people** may use.

All the same, if my user interface is not an API, but some sort of UI, there is very little reason to care about all the scenarios a component may face that **cannot** be triggered from that user interface.

The process of discovering your user interface has an added advantage. The answer to most _but what if_ questions about such a top-down approach usually unveils an additional user interface you didn’t quite know you had (looking at you, JSON SPA AJAX _<insert buzz word of the day>_ Frankenstein “web” apps).

This is already an understood concept, and is usually referred to as acceptance testing.


## At warp speed, everything is relative


A common issue arises from using existing acceptance-driven tools. Automating the browser is slow, automating a DB is as well, so is the file system. Each of those may also fail for reasons that have nothing to do with your code.

That would make your tests brittle and slow, which inexorably will lead to longer feedback cycles, harder to run tests, which would get us straight back to my introduction and why traditional approaches to TDD have failed.

Acceptance testing recommends, to avoid such a problem, the creation of an alternative interface allowing you to remove the browser from the equation. This is no longer necessary. With tools such as [zombie](http://zombie.labnotes.org/) being available for free, you can run an in-memory browser that behaves like a browser, runs in-memory and is increadibly fast. No more Selenium issues on running your automated test suite, no interaction with your operating system’s UI library, it’s all fast and beautiful. And if your user interface is an API, unit testing frameworks and test runners have provided those advantages for many, many years.

**External-facing** components are now in-memory, making executing our tests fast and reliable by not triggering external systems.

I now apply the same concept to **internal facing components.** Instead of mocking out the inner-most elements, such as the file system, the network or a database, of my system on a per-method or per-component basis, I use libraries that give me, out of the box, an in-memory version of their system that is **functionally equivalent** to the real one.

It means an in-memory file system would implement the same locking primitives as the real systems, the same rules around reading, writing or seeking data, and be as close as the author of the library can make it to the real system.

In other words, a VEST-friendly library turns the unit tests of that library on it’s head. The component accessing external systems is developed alongside it’s test-double variant, and both are built to react, error-out and validate calls in the same way. The **test double can be shipped**. I don’t write the mocks, they come as part of the package.

There are many advantages to such an approach. The author of the library knows intimately the contract he provided you as part of his API. The act of providing an in-memory version means this knowledge is now expressed explicitly, forcing error conditions (which are very much part of a user interface in an API) to be accounted for.

A VEST-friendly library will usually end up testing explicit contracts in their test harness, so we go one step further. A library author can ship the test harnesses that exercise the contract they expose for all the conditions that are known to potentially exist, and once again, we turn test code into shipping code: if the author has written a test harness, and the author builds two components implementing an interface, the **test harness for the explicit public interfaces can be shipped**, as it’s probably already written.

I believe this process to be recursive and leading to the pit of success, as any library built using VEST in mind will naturally feed the VEST approach.


## Vertical Slice Testing


The VEST approach replaces all external system calls by functionally equivalent stable and controlled ones, both at the outer-most layer (whatever exercises the user interface) and the inner-most one (whatever touches the low-level IO APIs).

By using VEST, I can focus on delivering web pages or components that focus on user-interaction, I can run the whole system on every test, and do it very quickly. I can change a lot of inside internal code without breaking existing testing scenarios. And should I wish to implement components replacing the ones in my libraries, I can do that without writing tests, because the test harness is already there, testing the contract for me.

_Note: As I’m abroad and not available that much, don’t expect quick answers in the comments section but I’ll try my best. Subjects not covered but not forgotten: my team as a user, availability of VEST libraries, code samples, library author burden, brown field projects, generic crazy-talk, unicorns not being ponies, "you never worked in a team!", "in an ideal world...", etc._
