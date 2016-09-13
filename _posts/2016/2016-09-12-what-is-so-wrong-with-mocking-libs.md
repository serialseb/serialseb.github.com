---
title:  VeST Redux – What’s so wrong with mocking frameworks?
comments: true
date: 2016-09-13 09:00:00 +0100
tags: [vest, mocking]
serial: vest-redux
---
While working on a project, on a nice summer day, and after many hours of
frustration and disbelief at my incapacity to make sense of some test code
using a mocking framework, I expressed an opinion I wanted to share with you.

**Mocking frameworks are actively harmful, and probably infringe on my human
rights.**

It's not just a matter of taste, there are fundamental issues that make it
harder to design good and maintainable software.

## They lead to code duplication

The code starts simple enough, you write a class, you mock the first interface's
method it implements, test pass, you move on to your next test.

After you write 50 tests, you end up with 50 implementations of the
same method, littered all over your testing code. Some will argue that it's just
a matter of reusing and refactoring your test code. If you're going to reuse
your mocking setup, then...

## They are a poor way to implement a class

I [already made that point a long time ago][mocking-sucks]: mocking frameworks
are a poor way to implement fakes. The code is noisy, with some frameworks it
does not refactor well, and let's face it, no amount of magic will compete with
writing classes in an actual language.

If you have a one-off method on one interface that has 50, and you are already
in hell, maybe a mocking framework will help you. Those cases are rare and
don't explain how often these things get used. Given the choice, I'd split
the interface into smaller chunks, and test that. It's easier and result in
cleaner and simple code, and seggregates functionality as you refactor.

## They often introduce incorrect contracts 

The author of a class or interface is the closest to knowing the contract.
Understanding when the code throws, what arguments can be null or not, and what
values will cause error is a matter for the contract author to define. This is
done in documentation, type systems and / or pre/post conditions.

When you fake an interface you don't own, you have to re-implement this
contract, and often you will not know enough to implement this correctly. In
a VeST library, the author would be the one providing the test double for you.
If you do not, then implementing a fake only once, by refactoring it
continuously with your new understanding of the contract will allow your whole
testing codebase to improve under those scenarios.

It's however very common for you to own the interface, the implementation and
the consumer, at which point you're in the best position to do the right thing,
and ship fast in-memory versions of the implementations you expect people to
use.

If you don't, you risk hitting the next issue.

## They break encapsulation

An object, in object-oriented development, is by definition encapsulating data
and behaviour. Each object is a black box, that you can tell to act, hence the
[“tell, don't ask” mantra][telldontask].

Because an object may use one or many dependencies, building the code by stubbing
each method of a dependency as you go along, you implement in your test a lot
of knowledge of the inside functioning of your class. This breaks encapsulation,
which makes your tests brittle, and refactorings harder.

## They introduce extra dependencies

Out of all the issues I've already discussed, this is probably the least visible
immediately, especially in a world of package managers.

Over time, frameworks and libraries are like fashion, they get in quick and
loud, and they get replaced by younger, slimmer next generations, and on and on.

Your test code, just like your applicationcode, suffers from this. The cost of
rewriting all test doubles using littered mocking frameworks is high, and you
hit the [pit of failure][pitoffailure]. It doesn't get done. You end up in
nonsensical situations, having 4 mocking frameworks in the same library, in
code that hasn't been refactored or touched in years. This code is, for all 
intent and puproses, dead. And mocking frameworks were probably an accessory to
murder.

## They lead to auto-mocking containers

This was a thing for a long time, and it is very unfortunate that people still
try to do this. The combination of containers, automocking and large dependency
trees result in many issues that make code more and more costly to keep.

Large amounts of dependency in a class is a tell-tale sign it's doing too much.
Stop feeding that class new responsabilities and split it.

Large dependency graphs often are because it's easy to take a dependency, and
results in overly-complicated levels of abstractions that serve no purpose. You
neither need a repository wrapping a data access class wrapping an actual vendor
library, nor do you need 3 levels of logging frameworks talking to one another.

And finally, the encapsulation breakage is worse than with a single class, it
now pans out to a whole object tree, making your tests even more brittle.
Friends don't let friends use auto-mocking containers.

## They allow for interaction testing too easily

I mention this only for the sake of completeness, because that's one part of
mocking that is not used as much anymore. Interaction testing wants to know
how and how often dependencies' methods are called. This is even more
non-sensical than the precedent breakages of encapsulation, you write a class
and write a test to verify exactly what the class ends up doing.

Interaction testing has a place, but it's very small, in a very limited number
of scenarios where it's not possible to test visible effects of the various
calls made to a system.

## Conclusion

Mocking frameworks are nearly always the wrong choice: they are not a good way
to write classes, they lead to the path of brittleness, badly factored code,
unwildly class hiearchies, and code duplication.

Do yourself a favour, write in-memory fakes and ship them alongside your code.

[mocking-sucks]: <https://serialseb.com/blog/2007/12/13/why-mock-frameworks-suck-and-how-to/>
[telldontask]: <http://martinfowler.com/bliki/TellDontAsk.html>
[pitoffailure]: <http://martinfowler.com/bliki/TellDontAsk.html>