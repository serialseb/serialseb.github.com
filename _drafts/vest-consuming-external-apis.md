---
layout: post
comments: true
published: false
title: VeST Redux – Consuming External APIs
serial: vest-redux
---
When designing a system for VeST, one of the pain points is the implementation of external APIs.

One of the tenets of Vertical Slice Technology is that any system ought to ship with its in-memory replica, with an implementation functioning as closely as possible to the real system. In the case of existing APIs, especially from extgernal actors, that's just not there. Reality gets in the way of good things.

Usually, developers implement this locally using a mocking approach, one call at a time. Due to shipping a full in-memory implementation alongside your component, that is a solved problem for your own components, and you can do the same for the service you're trying to interact with. Doing it the VeST way allows you to implement your understanding of the API, and encode in code the documentation of the service.

But, because you're now in charge of implementing things that are implemented by the real API, you are encoding a bunch of expectations, and reality strikes again: the service doesn't quite work the way it's documented. Or maybe it has a bug. You have no way of knowing if your in-memory implementation works the way the service does if you only rely on documentation.

One way to validate your understanding is to implement a test suite against your in-memory implementation, which also run against the real one. That allows you to test the exact same specification against two systems and ensure they agree by testing the results.

To do so you can use a pattern that i call drivers, which I'm sure you've seen before.
```
public abstract class Movie_specification<T> where T:IMovieGallery, new() {
	IMovieGallery gallery;
	public Movie_specification() {
	  gallery = new T();
	}
	/* implementation left out for brevity */
}
public class Rent_a_movie<T> : Movie_specification<T> {
	public Rent_a_movie() {
	  given_a_movie_available_for_watching(Movies.StarwarsPart4);
	  given_a_user_account(UserPersonas.Bill, login: true);
	  when_renting_a_movie(Movies.StarwarsPart4);
	}
	[Test]
	public void movie_is_playing() {
	  ui.player.IsPlaying.IsTrue();
	}
}
```
And voila, your current codebase can now test your understanding of an API and it's actual implementation.

But what if it breaks? Is it your code that just broke or the API? The eternal "it's not you it's me" conversation will immediately creep up.

If you're working on longer release cycles, one of the way to address this is to run your specifications from the last known release at the same time as the current iteration of code. For example, in the GitHub flow,you would use your CI server to run tests from the current master HEAD, and from HEAD~1.

If both versions break, it's probably them, if HEAD~1 works and HEAD breaks, it's you. If HEAD~1 is broken and HEAD passes, you probably just fixed a bug, have a cookie.
