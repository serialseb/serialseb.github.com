---
layout: post
comments: true
title: Now you 403 see it, now you 404 don‘t
date: 2016-01-29 16:18:00
image:
  feature: seedvault.jpg
  creditlink: https://commons.m.wikimedia.org/wiki/File:Svalbard_seed_vault_IMG_8750.JPG
  credit: Erlend Bjørtvedt
---
The next blog post in the “Public Speaking” serial is  being written, but I'll probably hold off from publishing it for a few days.

Thankfully, the stellar Hadi gave me a great excuse to write about something else.

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr">Let me use a 404 when I mean a 403.</p>&mdash; Hadi Hariri (@hhariri) <a href="https://twitter.com/hhariri/status/692938324273668096">January 29, 2016</a></blockquote>

In HTTP, URIs are identifiers. Well-behaved ReSTful systems expose all identifiers as URIs. And depending on a URI, the presence or absence of it may provide a lot of information to a potential attacker. I believe people call that information disclosure.

To prevent stuff from leaking, some people like [GitHub][github-403] and the [HTTP specification][rfc-404], can advise you to respond with a 404 NOT FOUND when in fact you are just not authorised to see a resource. In other words, I won't tell you if you have the rights or not, I'll just put that resource in my secret place where I hide my best cakes and tell you I couldn't find it.

## The good

A practical example of this is when trying to authenticate yourself when accessing a private repository. An attacker wanting to get access to your source code, say by finding a way to hack into github, would want to verify if the code for your web app is indeed on github, private repo or not.

One would think that they would have to find the correct repo name anyway, and that it does not matter. Unfortunately for One, stuff leaks all the time when exceptions get generated, as many sites will forget to turn on custom errors, and the path to each file used in compiling a site may reveal enough for the hacker to make an educated guess. It only needs to happen once.

## The bad

Unfortunately, because of this approach, if you try to clone a repository for which you are not permissioned, git will tell you that the repository doesn't exist. Usually ensues hours and hours of debugging for the poor developer trying to check code out, as I saw many times at one of my previous clients, until someone remembers that the guy was not added to the org, or to the repo.

This is a situation where security trumps usability, as giving any better notification to a user may well give better notification to hackers.

## The ugly

Now, that's the theory, and it's pretty compelling, because it's a conscious tradeoff. Unfortunately, if you apply this blindly, you're making a tradeoff you probably didn't consider fully. For if you want to prevent information disclosure, the status code is just an explicit one. Time is of the essence, and hacking your system can be done by simply looking at your watch. I'll give you two examples.

A lot of server applications are built by separating the HTTP-serving part of a request, and the application-part of the request. On windows boxes, IIS may respond to a 404, but so would asp.net. They are however different 404s, and windows leaks like a prepubescent guy on his first date. Custom Server headers, vanity response headers, you name it. From this, it's easy to know if an ASPX file exists or not, based on if IIS or asp.net responds. So that's the first thing you need to ensure is not leaking.

But even once you remove all those vanity processes, the timings are different. IIS will respond with a 404 substantially faster than your custom authentication code. By definition, something that is not there does not require processing the token / cookie / ticket the client is providing. The solution here is to always process auth information, before trying to see if a resource exist or not, and before doing any authorisation.

Once you do that, if you have your own password management, and you do it right, you'll have a salt, a hashed password and a number of iterations that is used to generate that hash, with some key padding in there. This stuff takes time, on purpose, as they prevent anyone that stole your DB from brute-forcing their way through the decoding, in theory. The higher the iterations, the longer it takes.

So even if you implement all these things, you still need to be aware that a user account not found will always respond faster than a user account with the wrong password. And if you think an attack of that kind cannot measure the timings from a laptop, sure, you'd be right, but it's trivial for me to get myself a server on the hosting platform you use for your system and run it on a high bandwidth environment where, statistically, i could find out if that user exists or not.

How do you prevent that kind of information disclosure is more complex. My best guess and proposed solutions before have been to always delay the 404 response by the average response time of users that do exist. It requires having good stats on that, but that way someone from the outside really cannot make any supposition.

## Security always trumps usability?

There you have it. I do believe that a public website should always privilege preventing information-disclosure to usability, but if you already leak a whole bunch of data, making your system more opaque doesn't protect you and confuses your users. Don't leak at all or be friendly. Then again, you always have the possibility of designing your URIs so they cannot be predicted from externally available information, and then you don't need to do any of this.


[github-403]: <https://developer.github.com/v3/troubleshooting/>
[rfc-404]: <https://tools.ietf.org/html/rfc7231#section-6.5.3>