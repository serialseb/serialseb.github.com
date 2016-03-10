---
title: Agile Anarchy – Null Design
date: 2016-03-07 17:53:00 +0000
serial: agile-anarchy
tags: [agile, vest, microservices]
comments: true
---

When agile practices are used just to be used, we've lost track of why processes and rules exist. Rules come with costs, and only when the benefits of having them surpasses their cost can they be justified.

To figure out how this new team could work together, and taking into account [Conway's law][conway-law] we started with what I call the _null design_.

To start with, you remove everything. Practices, code, knowledge, we start from 0. A greenfield team of newborns. This is chaos, as if you have nothing, no one has any idea of what they should do or how. If you let this happen, you end up with a bunch of babies crying all the time and soiling their underwear. Not a pretty sight.

While evolution took millions of years to evolve from single-cell organisms, and babies take about 30 years to become useful, we didn't have that much time on our hands, so we started with what we knew.

First, we started with the development practices we wanted, and a rough idea of how we would build components. We wanted a decoupled cloud-hosted infrastructure, with microservices, a quick development iteration turnaround, continuous delivery and use [VeSt][vest] to ensure we could build this and refactor it quickly.

What the software was to do, we knew. We were, after all, replacing an existing system. The existing system was a big fat mess of legacy code we had tried to massage into submission for many weeks before the reset, so everyone had some sort of understanding of what was needed.

And relying on this would have been a big mistake! Take an existing design, replicate it by not re-doing the analysis, and you'll end up with the exact same existing design. You need to separate required complexity and the accidental one. You also need to make sure everyone on the team had the same understanding of how things should work.

So we forgot everything, and started with one user story. By the virtue of VeST being BDD, we knew we started by writing our first user story and our first spec.

Mind you, temporary amnesia is hard to do: it's an iterative process by which each story leads to whiteboard conversations and a model being discovered. I annoyed my colleagues many times in such conversations by refusing to hear any discussion about "there is also...". Not that existing knowledge is not useful, it is. What is not is looking forward many stories ahead and altering our understanding of the required behaviour by including concepts only half of the people had an understanding of.

Instead of optimising up-front design, we optimise for the capacity to change the design later, cheaply. Developing software is a journey, in which learning is the hardest part. By being voluntarily naïve, we got from segregated knowledge to rebuilding a shared understanding, one story at a time. And like pyramid builders before us, we started work after choosing the sharpest and best tools for the job.

[conway-law]: <https://en.wikipedia.org/wiki/Conway%27s_law>
[vest]: <https://serialseb.com/serials/vest-redux/>
