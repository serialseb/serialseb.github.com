---
layout: post
title: Best C# 2.0 Feature
tags: [csharp]
date: 2003-11-27T11:26:08+00:00
---

Everybody just constantly brags about how cool templates are. I have this very very strong feeling that I love them and that they’re going to render any code as complex as C++ is today. As a side note, the only way to be a guru in any language is to be there when it’s created, so you can cope with the changes: Incremental instead of frontal. Whatever, the best feature of c# 2.0 is this one:

```csharp
            public string Name
            {
                        get { return name; }
                        internal set { name = value; isDirty = true; }
            }
```


No more having to declare internal void SetInternalVar() when you have a huge number of very tightly coupled classes. This is going to make a big change. I’m happy.
