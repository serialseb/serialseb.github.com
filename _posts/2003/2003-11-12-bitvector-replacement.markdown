---
layout: post
title: BitVector Replacement
tags: [.net]
date: 2003-11-12T13:02:30+00:00
---

A long long time ago, there was a [discussion](http://www.aspzone.com/posts/179.aspx)  (and [here](http://dotnetjunkies.com/weblog/sudhakar/posts/559.aspx)) about the BitVector32 class being buggy. My main problem was that it was not feature complete, and I still had to rely on a lot of bit shifting, which is, for people like me, very error prone. Associated with a good code generator, this class is a perfect tool to build UNION like structures in .net without relying on the marshaling classes.

Roy mentions that I should mention the bug in the original implementation:

"the indexer always returns false for bit #31"

While this problem in itself would have been enough to rewrite the original code, you'll see that my API is really different. My main problem was to be able to deal with different types (a 3bits value, 3 bools as bits, and all the awful things C++ developers just writing their structs on a network pipe make us, poor .net people without a UNION thing, incapable of handling).

I developed this piece of code, so here it is for your pleasure. Notice that this piece of code is provided for your use for free as long as you pay me a beer (or a RedBull). Oh, and acknowledgments never hurts!

Enjoy.

Edit: Sorry about the previous entry, forgot that IIS doesn't want to serve .cs files whatever happens :)

BitVector32.zip (1.31 KB)
`link that has not made it http://thetechnologist.is-a-geek.com/blog/content/binary/BitVector32.zip`
