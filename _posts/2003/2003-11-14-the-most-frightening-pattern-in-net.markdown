---
layout: post
title: The Most Frightening Pattern in .net
tags: [patterns]
date: 2003-11-14T12:01:38+00:00
---
Am finishing my Task based MVC modifications to the excellent User Interface Process today, and here is one thing that comes over and over in my code. This pattern is absolutely frightening. Let’s go through it together:

```csharp
      public sealed class DumbFactory
      {
            // cache pattern and dual lock volatile pattern, all at the same time :)
            private static object SyncRoot = new Object();
            private static volatile NavigationTask tasks;
            private static NavigationTask Tasks
            {
                  get
                  {
                        if (tasks == null)
                              lock (SyncRoot)
                                    if (tasks == null)
                                          FetchTasks();
                      return tasks;

                  }
                }
          public static ITask Get(string name, Guid taskId)
          {
                ...
          }
          private static void FetchTasks()
          {
                 ...
          }
      }
```

 This, as you can see, is a bit of a departure from the original dual lock statement. A few notes:

The volatile statement prevents memory caching that would prevent the dual lock to succeed on some architectures
The lock is done on an object, not on typeof(type). Pretty simple, if you lock on a type, then in inheritance, if a type inherit from your class and call tasks, you end up locking two different objects, the type of the parent and the type of the child. But sealed is there you say. Well, sealed is only a hint, so whatever you do, you may still end up inheriting. And if you remove it and subclass your object, this problem will be forgotten until the bug hit you in the face.
Another way to implement that would be to do a Interlocked.ConpareExchange with a synchronization primitive. A bit too complex imo, so unless my app end up running on a 32 way box, I can live with that solution.
More reading on the subject

Chris Brumme on the .net Memory Model [here](http://blogs.gotdotnet.com/cbrumme/PermaLink.aspx/480d3a6d-1aa8-4694-96db-c69f01d7ff2b).
Victor on the implementation of the SR object in .net (anyone using reflector on the bits know what I’m talking about :-) ) [here](http://weblogs.asp.net/vga/posts/31688.aspx).
Enjoy! (I’ll do my p2p paper tonight if I can).
