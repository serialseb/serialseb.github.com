---
date: 2016-02-29 17:21:00 +0000
comments: true
title: Rebuilding SerialSeb.com – Talks
serial: rebuilding-serialseb-com
tags: [jekyll, liquid, conferences, user-groups]
---
I've been recovering from man-flu, and today is the first day where my brain has cleared enough to start coding again.

As I couldn't focus on doing development, and I was bored in bed and running out of Netflix stuff to watch, I finally revamped the [talks section](/speaker/) of this site.

This has involved finding out about all the talks I gave since the first one, and each and every delivery of it since I started speaking in 2007.

You can now find descriptions, slides and videos for any of the 33 talks and workshops I've given, check any of the 89 times I've delivered them, marvel at the 36 cities and 12 countries I have covered.

The numbers were very fun to generate. How it's done is pretty simple.

Each talk is part of a custom collection, as you'd expect, and I created a little yaml language that maps the information I found useful. This was already partly done in the old site, using one page per talk, but collections made it all easier.

The stats themselves, due to having poor support for maps, was calculated using arrays and nested loops, whcih reminded me of how we used to code in the 90s.

```liquid

{%raw%}
{%
assign totalEvents = 0                                                      %}{%
assign cities = '' | split: ''                                              %}{%
assign countries = '' | split: ''                                           %}{%
assign all = site.talks | map: "deliveries"                                 %}{%
for deliveries in all                                                       %}{%
  assign totalEvents = totalEvents | plus: deliveries.size                  %}{%
  for delivery in deliveries                                                %}{%
    if delivery.location                                                    %}{%
      assign city = delivery.location | split: ',' | first | trim           %}{%
      assign country = delivery.location | split: ',' | last | trim         %}{%
      unless cities contains city                                           %}{%
        assign cities = cities | push: city                                 %}{%
      endunless                                                             %}{%
      unless countries contains country                                     %}{%
        assign countries = countries | push: country                        %}{%
      endunless                                                             %}{%
    endif                                                                   %}{%
  endfor                                                                    %}{%
endfor                                                                       %}
{%endraw%}

```

A few points of interest: first, the declarations at the top are the only way I know of initializing an array; second, the self-assignment with push is how i add things, because there is no uniq filter; and finally, the end-of-line kisses is the only way I can make the code readable and more maintainable. I call them kisses because it looks like two people kissing, isn't that cute? And that's thanks to the [recently updated github pages](https://github.com/blog/2100-github-pages-now-faster-and-simpler-with-jekyll-3-0), now with liquid 3.
