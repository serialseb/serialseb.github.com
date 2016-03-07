---
title: Agile Anarchy – Is Agile dead?
date: 2016-03-07 13:07:00 +0000
serial: agile-anarchy
tags: [agile]
comments: true
---
With a previous client, we started out in a traditional SCRUM environment. We had a wall with columns, estimations, there was some SCRUMs of SCRUMs, we had bimonthly retrospectives, we were pairing, we had all the traditional checkboxes of Agile checked. What could possibly go wrong?

## Pair programming

With all this in place, after one of the team members went on holidays, we realised that no one knew enough about the systems he built to manage to fix a production issue.

In that team, pairs rotated, this shouldn't have happened. In another team, pairs rotated all the time, and yet the codebase never achieved the level of uniformity you would expect from people working for months together.

## Retrospectives

Retrospectives were done everywhere, and some descended in general moaning sessions, with no positive proposals. If you ask people what is wrong, they will find something.

Reinforcing positively once every two weeks good behaviors or techniques very rarely resulted in that reinforcement happening.

## The daily stand-up

Oh, the stand-ups, the descending in endless conversations about bug 78, or the patient waiting while each developer discuss what was done yesterday when you have no idea of context and no understanding of how it impacts you, or anything else.

## The wall

We had walls, lots of them. The team had their wall, another team had a wall of things replicated, the PM had his own "wall" (a powerpoint slide). There was another wall we had no clue about that had our team name on, but wasn't maintained by anyone. In doubt it was left there.

The wall rarely highlighted anything beyond the next item to work on for each of the isolated columns: QA would take whatever card they had the time to do, and when QA had too much work, well, the column grew.

Statistics were irrelevant, because the columns were changed often enough to make statistics irrelevant. They were still calculated, in the JIRA copy of the wall, because you had to have that too, for performance reviews of POs or what not.

## XP

TDD was done sometimes, with infrastructure access, slow running tests, Selenium tests that kept on breaking and cost a fortune in maintenance.

We had plenty of unit-tests, and some even tested code that was real. The other code was either feature-switched, or had been dead but not removed.

We had code coverage, and of course those had to be reported monthly to a head of IT, in an excel spreadsheet. Of course it wasn't to compare teams to one another, it was for something else. We didn't use them, but if someone wanted them, we had them. For the part of the tests we could actually verify was under test.

## Estimations

We had poker planning, to judge on the size of each card. Many hours were debated to know if a card was a task, a story, an epic, or business-as-usual. Because, you know, the rest of what we do is not part of the business as usual.

We spent a good 4 hours, in a tense environment, drilling into why things are big or not, and debating with the BA why we said most things were difficult.

## Story writing

We had the three amigos, of course. People went to training with competent bdd practitioners. Stories were to be written a first time, as preparation, by the BA, talking to the PO. Then the three amigos would discuss those stories and maybe write some more.

Then it would go into dev, we would have to rewrite most of those in code, at that point things change, and the original stories were rarely still present. Except on the wall, and in JIRA, and in the head of the PO that wasn't very involved in anything past the discussions with the BA.

Mind you, the PO was sitting next to the BA which was sitting next to the devs. But you need all that proxying, or people would have way too much time on their hands!

## Iterations and quick dev?

Oh yes. Iterations were followed. You could release, twice a week, at 5am, as long as someone with the right rights clicked on the button, and was ready to manually rollback and pray in case of issue, of which there were many. So you'd release every two or three weeks, and as most features were incomplete, behind a feature switch. Oh the joy of continuous delivery on very long cycles. I hear they call them release trains now.

## What could possibly go wrong?

It's very clear that Agile has become an orthodoxy. People apply blindly certain processes, ignore improvements because they cannot argue that something had a positive impact or not, and discuss endlessly which gospel to follow and why.

With all this, you'll understand better the title of this serial. I claim that in most environments, the idea itself of agility, with a lowercase a, has died, has been buried under layer and layer of bricks. That tomb is Agile with a big A, and a big A looks a lot like a pyramid, which happens to be a mausoleum, and the picture illustrating this serial.

Clients are blinded by their belief that agile is a bunch of bricks you can use to suddenly get results, without changing fundamentally your core practices. It's Agile, it blinds them to the possibilities and the opportunities that an agile transformation could have brought them.

## Fixing stupid

We embarked on a journey to fix all this. In the rest of the serial, I'll be navigating you through the changes we made to become truly agile, why it was amazing, what worked and didn't. How did it turn out for that client? You'll have to wait for our journey along the Nile to know the conclusion. All aboard!
