---
layout: post
comments: true
published: false
date: 2016-02-23 11:55:00+0000
title: VeST Redux – Test rigs and external APIs
serial: vest-redux
---

In my previous post, we touched on the concept of test rigs, reusable tests that can be ran against many implementations. When using VeST for your systems, you'd build all of those components alongside your mains.

Usually, developers implement this locally using a mocking approach or in-place stubs, one call at a time. When applying VeST, that is a solved problem for your own components, and you can do the same for the service you're trying to interact with. Doing it the VeST way allows you to implement your understanding of the API, and encode in **code** the documentation of the service.

But, because you're now in charge of implementing things that are implemented by the real API, you are encoding a bunch of expectations, and reality strikes again: the service doesn't quite work the way it's documented. Or maybe it has a bug. You have no way of knowing if your in-memory implementation works the way the service does if you only rely on documentation.

One way to validate your understanding is to implement a test suite against your in-memory implementation, which also run against the real one, which I call a *test rig*. That allows you to test the exact same specification against two systems and ensure they agree by testing the results.

To do so you can use a pattern using drivers, which I'm sure you've seen before.

```csharp
public abstract class Movie_specification<T> where T:IMovieGallery, new() {
	IMovieGallery gallery;
	public Movie_specification() {
	  gallery = new T();
	}
	/* implementation left out for brevity */
}

[TestFixture(typeof(MongoMovieGallery))]
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

As your tests start using more components, you can replace the T in those tests and contain all your dependencies in a driver class instead.


```csharp
// going to mongo by default
public class MovieRentalDependencies {
	public Func<IMovieGallery> MovieGallery = ()=> new MongoMovieGallery();
}
// going to in-memory bson implementation
public class InMemoryMovieRentalDependencies : MovieRentalDependencies {
	public InMemoryMovieRentalDependencies() {
		MovieGallery = ()=> new InMemoryMovieGallery(new BsonSerializer());
	}
}
// updated test context
public abstract class Movie_specification<T>
							  where T: MovieRentalDependencies, new() {
	/* as above */
}
```

To ship your test rigs, you package them in nuget, and your consumers can now write their own implementations of IMovieGallery with a simple one-liner in their test project.

```csharp
public class PlexMovieGallery : Rent_a_movie<PlexMovie> {
	// etc
}
```

There are other ways to shave that yak, but this is the simplest and fastest for a few test specifications.
