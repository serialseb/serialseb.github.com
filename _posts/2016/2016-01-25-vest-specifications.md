---
layout: post
comments: true
title: VeST Redux – Specification-driven development
serial: vest-redux
date: 2016-01-25 13:40
published: true
---
Building software is easy. Really, it's just a matter of writing a bunch of statements that do something, and _voilà_, you have a running program. Building the right software is where the complexity lies.

Too often, we fail at building the right thing, and in my experience this has always come from poorly communicating what the software ought to achieve.

On the technical side, test-driven design has made great progress in becoming a mainstream approach to delivering simpler systems, and that's great when you think back on where we were in the early 2000s. Yet, more often than not, the resulting test suites can become brittle, poorly maintained, hard to read and refactor-unfriendly.

So over the years I've refined a methodology to try and address, or at least minimize, both issues.

## User stories with feature Injection

There is a French saying, “Ce qui se conçoit bien s'énonce clairement”, which translates roughly to
“whatever is well conceived is clearly said”. When discussing something we want to build, how do we make it clear enough so it describes well what it does and why it is needed?

The first step, as we are in our first iteration, is to discover what our user is trying to do. To do so, i'll write my first user story, using [feature injection][feature-injection], which my good friend Liz Keogh has written about for quite a while now.

    In order to chose which movie to watch
    a user can browse all movies available on restflix

So there is our first feature. The fact that we talk first about the value it brings is essential to understanding and keeping in mind, all along our analysis and development, why we are building what we are building.

The first feature is as such a movie browser, and it exist for the sole reason that it allows someone to watch a movie. Time to drill down a bit into more details.

## Scenarios

The next step is to drill down into reproducible and understandable scenarios, which we provide using examples, as they are more palatable to humans.

    Given Anna has a valid account
     When Anna logs in
     Then she can see the list of all available movies

Is this clear enough? Can we assert that she sees all available movies? Probably not, for we don't know what "available movies" mean. Let's be a bit more specific in our example, so we can assert the correct thing.

    Given Anna has a valid account
      and "Star Wars Episode IV" is available
     When Anna logs in
     Then she can see the list of available movies
      and "Star Wars Episode IV" is in the list.

This example is now self-describing enough to be encoded straight away in tests.

## Specification-driven development

I've never been a big fan of spec tools, as I find that the code diverges more often than not from the intent of the original code-base, or sometimes even force most of the work to be about gluing things together rather than delivering value (*cough*fitnesse*cough*.)

I don't claim to have found anything new here, as this style of testing is a combination of many things I've seen and liked / disliked over the years. Nevertheless, here it is.

First we start with encoding the specification itself in code. _Please note the code may not compile, it's written from my iPad, it doesn't really matter if it does, as long as the example is understandable._

{% gist serialseb/49fc9d939d74b83ba02d movie_available.cs %}

You'll notice that there is a bit of variance from the original text, but it should still be readable by non-developers, provided you tell them to remove all the punctuation.

Secondly, you'll also notice the `Users` and `Movies` classes. Those are testing personas I always create in a project. I may leave that for another session.

The file name ought to be a reflection of the scenario you are testing, which I would describe as a summary of the preconditions in the test. As you evolve your specifications, the names may change to become more descriptive, or you may split them in sub-folders, as I'll describe a bit later.

You'll finally notice that I inherit from a “context” class, in which all the given/when methods are actually implemented.

{% gist serialseb/49fc9d939d74b83ba02d movie_browser_context.cs %}

The givens and whens are implemented in a base class so that our tests are easily readable. I usually start hacking all of them on the class, then introduce a base class and pull up the implementations in  the base abstract class.

{% gist serialseb/49fc9d939d74b83ba02d app.cs %}

The design of the App class evolves from the implementation of the context class, forcing you in designing the first cut of your object model, just enough to get the compiler happy and the tests implemented.

## A folder structure

From this code, the tests tend to be organised in a structure that mimics the logical structure I just described.

    /tests/component/feature/scenario.cs

In this example, it would be.

    /tests/app/browse_movies/movie_available.cs

As you add more and more scenarios, the payoff becomes obvious. Find a new combo of examples, a new initial state, and you get to failing tests in a matter of seconds.

You need to continuously re-evaluate the name of the tests as you discover more descriptive ways of talking about all the scenarios for which you provide examples. This is where sub-folders within each feature can help.

## Conclusion and thoughts

Your mileage may vary. Once upon a time one developer considered having one abstract context class to be too complicated to navigate to.

I find this way of modeling my specifications to be great for refactoring (only the base class to change, the language does not), the existing scenarios stay valid over iterations and focus on language and benefits, on what the software is supposed to deliver rather than the how it does it internally.

To be useful, this means language ought to be extracted from practices and discussed openly and continuously. I have seen architects that spend too much time in conferences argue for a company-wide ubiquitous language, going as far as specifying their own terms they pulled out of a hat, that were already in use over multiple domains, and enforce them with the authority bestowed upon them by their title to other development teams. The result: old and new terms, used continuously and erratically, and the idea that “people just need to...” will lead to a clear way to communication.

I disagree. By putting specifications, examples and conversations at the core of the discovery and development of an application, a language will naturally evolve. And when things are not easy to name, a dictionary is your best friend.

[feature-injection]: <http://lizkeogh.com/2008/09/10/feature-injection-and-handling-technical-stories/>
