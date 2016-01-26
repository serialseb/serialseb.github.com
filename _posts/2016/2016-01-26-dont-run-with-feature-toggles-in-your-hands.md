---
layout: post
date: 2016-01-26 12:06
title: Dont run with Feature Toggles in your hands
comments: true
image:
  feature: scissors.jpg
  credit: FlutterSpeed
	creditlink: http://www.flutterspeed.com/2010/12/rusty-but-pretty.html
---
Feature toggles have been on my radar for a while, thanks to [Martin Fowler's introduction][fowler-toggles] from back when, where he argues for enabling or disabling certain features of an application dynamically, based on some sort of switch. For many years this fell on dead ears, for I never really encountered any reason to pursue this avenue on real systems.

Fast forward a bit in time, and I inherited a project in which those feature toggles were used everywhere. Having to deal with the downfall resulting from their spreading in code-bases has been, to put it mildly, emasculating, the kind of pain I imagine child birth must induce.

## The goals

The original intent of feature toggles is mighty fine. We'll build this new feature, and it will be nicely enclosed in `if` statements, and we will only show it when it's ready to be released. Maybe the feature will get enabled based on which user is an admin, and which user is a standard average Joe user. The promise to segregate development and prevent the release of a feature util it is complete is compelling, and the idea of activating or deactivating features is as well.

So what happend to make it so painful?

## The path to heaven is paved with zombies

Implementation-wise, the code-base I inherited was littered with if / else. Each feature toggle was created in an XML file, and each code impacted by the changes would be enclosed in conditionals.

As you can imagine, the first issue was a code-quality one. When you manually have to remember to if/else everything, people make mistakes. With feature toggles, they make even more. Not only do you have to conditional the code, and as such have an extremely thorough understanding of the dependencies involved with a feature, but you have to double your tests, for you need to check with or without each feature combination the expected result. If you have multiple features in flight, you have a cross product of such test configurations. As it's too hard to do, no one does, and your reliability goes down the drain.

Once a feature is released, developers, at release n+1, are expected to remove the feature toggle. This presents its own set of challenges: a feature toggle may  be forgotten somewhere, developers in charge of that feature have moved on to another feature and forgotten to remove it, and it's very hard to automate the detection that some toggle should not be there anymore. When people continuously make mistakes around a manual process, we automate it, and this automation is usually absent.

## Run, zombie, run!

That's just the development-time issues. I touched about the difficulties in understanding your dependency graph when you have code using conditionals to activate or deactivate things: the contract is poorly defined. Without strong contract and component boundaries, activating or deactivating things is too complicated for my head to reason about.

As for changing something at run-time that influences the way your software works, we reach the most unreliable and dangerous part of the idea. You *will corrupt systems*. Be it that you are using SQL, or event-sourcing, introducing data that is only understood by a new component can only be done if the old component is ready to ignore those things, and all those changes were made additionally. It's doable, and I'm a big supporter for such forward compatibility designs, but that is not without its costs, and those are usually not explained to the developers implementing those toggles.

And if corruption was not enough, one has to think about operation boundaries, a.k.a. what is the unit of work, and is it possible to activate and deactivate a feature half-way through that. Is your unit of work the adding of a line item in your basket, or is it the whole buying process? Can you change data in the ordering part and revert back the feature by the time you check-out?

The complexity graph is enormous, and anyone that says the contrary has not been exposed to the code bases I've seen. This stuff is dangerous, unreliable, hard to automate and just plain unusable.

## No if, no but?

From a functional perspective, we have to formalise the changes in data structures we pass around various systems for features that persist or message data to be able to be activated or deactivated independently. A good guideline is to ensure a system with a feature toggle only persist to its own datastore it does not share with any other system using a different version, aka keep storage private. For communicating with the other services in your systems, extensible and compatible messages with forward and backward compat still apply, be it that you're in ESB or ReST or whatever. Those constraints ought to be applied and understood first and foremost.

For  code quality, it's a bit simpler, and already has a name, and it's called **composition**. New components implementing new features using existing contracts (say, implementing an interface) can be developed in a copy-on-write way, keeping the old and the new components in your code-base, and switching at will between the two. Alternatives allow you to do this by branching code, but I tend to privilege the copy-on-write, as it forces you down the path of making component boundaries more explicit. The components get selected and wired-up together at startup time of an app, so if you want to enable or disable a feature, you'll have to restart the box, and it's a good thing: you make sure that no component ends up expecting a changed behaviour from another component that just reverted to an old version.

As for the UI, the sweet spot for me has always been to use an Eventing model for building UI areas dynamically. For example, the app emits an Init event, each module replies with a self-descriptive message containing the extension points it desires to add to the interface. Want a "kick/ban" button if you're an admin? Check the user credentials and add yourself by responding with a message describing buttons you want to provide.

## R.I.P.

If you build your software as a set of independent plugins, with messaging to communicate and composition as a feature toggle, you'll end up with cleaner and more reliable code. You can still litter your codebase with ifs, but be careful not to fall. 

[fowler-toggles]: <http://martinfowler.com/bliki/FeatureToggle.html>