---
title: Rebuilding SerialSeb.com – CV
serial: rebuilding-serialseb-com
date: 2016-03-02
tags: [css, html]
comments: true
---

One of the most difficult times in the life of a contractor is having to prepare his CV, linked.in profile and all the other things that you need to do to hope getting your next interview. I've only recently had to start doing that, as I'm looking for my next contract, and realised my existing CV needed a full rebuild.

## The what

I decided to get my CV in YAML form, to contain all the information recruiters, clients and recruitment agents may need. I came up with the following requirements for a good CV.
  - A simple introduction of who I am
  - The list of technologies and practices I've used over the years and for which clients, in a form that can be absorbed by most recruiter's databases, and answer automatically the sacrosanct question of how long I've used each of those
  - A highlight of previous clients, with a start date and a length for each contract, with a way to get the whole thing should the user of the CV want that
  - One HTML page that could be viewed traditionally, or in a timeline, or printed
  - Brush off on my SASS/CSS and grids system by making it no-javascript

The first iteration is [now live](https://serialseb.com/about/cv/). There is still a bunch of tweaking I want to do, and maybe clarify the text in each of the projects. Role titles are specifically omitted, as it is just easier to have that conversation over the phone, I hope. But if you have tips on how to write this stuff down without started everything with "designed, developed and deployed" that'd be great :)

## CSS frenzy

I wanted something as pure from the markup point of view as possible. One notable thing I did was the timeline view, which is not active by default (thanks to early feedback from people). It is all without javascript, by using the magic of CSS.

We start by creating a hidden checkbox, and a label for it that we will use to allow the checking and unchecking to happen by mouse and keyboard without the checkbox itself being visible.

```html
<input type="checkbox" id="enableTimeline" />
<label for="enableTimeline">Timeline</label>
```

We then add the styling using a combination of `inline-block` displays for each job, but only when the timeline checkbox is checked.

```css
#enableTimeline:checked ~ .timeline .job {
  display: inline-block;
  width: 200px;
}
```

If you want to check out the original, it's on [GitHub](https://github.com/serialseb/serialseb.github.com/blob/master/_sass/cv.scss)