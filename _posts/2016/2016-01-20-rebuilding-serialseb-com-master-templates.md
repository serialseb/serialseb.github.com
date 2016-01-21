---
layout: post
comments: true
date: 2016-01-20 17:44:00
title: Rebuilding SerialSeb.com – Master templates
serial: rebuilding-serialseb-com
---

GitHub Pages uses Jekyll, which then uses liquid as it's templating mechanism.

I didn't want to maintain various html templates all replicating the content from one another, as it makes large changes much harder.

But I learnt a cool trick from the first iteration of SerialSeb.com, which allows you to replicate master templates from asp.net in Liquid.

Say you want to reuse the same html content, but allow each layout to define its own footer.

Given a blog post, the layout is selected in the front matter, with the layout instruction.

{% gist serialseb/064b4bab7cf5ae70106a 2016-01-20-my-post.md %}

We then include a file in the `_layouts` folder called `post.html`.

{% gist serialseb/064b4bab7cf5ae70106a post.html %}

We use the `capture` element to capture the string output we want in a variable called footer. As those variables are global to the currently-rendered page, we now have the footer content.

Finally, we include a `_master.html` file from the `_layouts` folder, which simply makes use of the variable.

{% gist serialseb/064b4bab7cf5ae70106a _master.html %}

And voila, master pages on liquid. There are other tricks you can use, as the `include` instruction takes in variable parameters and string parameters, so you can parameterise this string without relying on global variables. I'm lazy today so implementation is left as an excercise to the reader.
