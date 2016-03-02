---
title: VeST Redux – Testing strategy for aggregates in DDD
comments: true
serial: vest-redux
date: 2016-03-01 17:57:00 +0000
tags: [cqrs, ddd, vest]
---
A main part of VeST is the belief that, while unit testing at the class level can be useful, testing at the scenario level provides the same benefits with less cost of maintenance. How does that apply to root aggregates and CQRS?

## Commands and events

If you're working in a CQRS system, and most of us are, sometimes without realising it, then the world is split between things users want to do and things that happened. We call those commands and events.

## The given/when split

One of my client, for better or worse, had spent years investing on an event-sourced infrastructure they did not need. The domain was too simple for it, but throwing everything away and arguing for a two weeks rewrite would have been irresponsible and disconnected from the realities of maintaining what was now a ball of mud.

A testing strategy was needed, to put the weeds under control and manage to make changes without everything breaking. We settled on a split between givens and whens.

## Landscaping

Our aggregates were classes, with public methods on them, generating events which projected current state in internal private fields.

Commands were responsible for de-duping, ensuring idempotency, and calling those methods.

Event streams collected the various results of the method calls triggered by the commands.

## Testing strategy

To keep the churn down as we evolved the system, we put in place the following rules.

Givens are only allowed to call methods on the aggregate. Then we wait for messages to propagate to any other part of the system, before going to the next when.

When's are only allowed to execute commands. By executing the command from a known state, whatever changes may happen, the command is the main execution point that's put under test.

Now how do we assert? Well, you cannot break encapsulation, so what do you do? We only test on projections.

## Sum()'ing it up

So we run entity methods as givens, commands as when's, and we test projections as then's. If you can't test your assertions through projections, then there is nothing to test.

That said, as event streams evolve over time, especially in poorly designed systems, things change and different rules apply. I shall cover this in a future post.
