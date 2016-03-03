---
title: VeST Redux – Semantic persistence
comments: true
serial: vest-redux
date: 2016-03-03 17:59:00 +0000
tags: [cqrs, ddd, vest, event-sourcing]
---
In a VeST system, we always implement at least two persistence mechanisms: the simulator and the main, one in-memory and one going to the real system, and they must have the same visible behaviour.

We didn't want to go down the route of event-sourcing again for our model, it was too simple for what this provided. At the same time, an audit log of all things that happened was invaluable from the get go, both for diagnostics to fit with the developer self-service constraint (which I'll blog about in the future), and for customer service.

Maintaining separately an audit log, an entity state and messages would have been a mess, so our system evolved into an alternative, which is not dissimilar to models [Udi Dahan blogged about in 2009][udi-events].

## An entity

For the purpose of demonstration, we'll define an entity as being a domain model that can make decisions on executing things.

Let's take a trivial example. The object model is iffy, but it's for demo purposes, and it probably doesn't compile.

```csharp
public class Customer {
  decimal _balance;
  ICollection<Movie> _rentedMovies;
  public void RentMovie(Movie movie) {
    return _balance < movie.RentalCost
      ? InsufficientFunds()
      : MovieRented(movie);

  }
  public void InsufficientFunds() {
    // we throw because the command should
    // not have called RentMovie if it knew the customer needed to refill money.
    throw new InsufficientFundsException();
  }
  public void MovieRented(Movie movie) {
    _balance -= movie.RentalCost;
    _rentedMovies.Add(movie);
  }
}
```

## Logging

One approach to keeping logs of things is to add an `ILog` somewhere, and spit out lots of strings, and hope someone somewhere will have a use for it.

Many a tool have been created to revert from that text format to stuff you can actually understand, all the way to structured log entries.

This requires you to maintain two different domain definitions of what happened, and mixes the responsibility of writing to a log and of the actual work an entity ought to be doing. As you can imagine, I'm not a fan at all.

## Persistence

Most systems tend to try and retrieve the state of an object, project whatever happened into the variables, and ask the persistence to track what changed and optimise the generic case. This approach has two main flaws: the persistence layer is so generic that it can only optimise state changes, but without enough context to leverage the persistence storage specificities. This prevents the persistence layer from making the best possible decision about how to do concurrency; and the simulator becomes extremely complex to write, as it would try and replicate the full feature-set of your persistence medium, be it an entity framework thing or an `ISession` in nhibernate.

## Adding events to our entity

We ended up with a model not dissimilar to what exists in NEventStore. We rewrite our entity slighlty to split the decision and the projection in two methods.


```csharp
public class Customer {
  decimal _balance;
  ICollection<Movie> _rentedMovies;
  public ICollection<object> Events = new List<object>();
  public void RentMovie(Movie movie) {
    if (_balance >= movie.RentalCost)
      Raise(new MovieRentedEvent(movie));
    else
      Raise(new InsufficientFundsEvent())
  }
  void Raise<T>(T @event) {
    Events.Add(@event);
    Apply(@event);
  }
  public void Apply(InsufficientFundsEvent @event) {
    // nowt
  }
  public void Apply(MovieRentedEvent @event) {
    _balance -= movie.RentalCost;
    _rentedMovies.Add(movie);
  }
}
```

## Implementing persistence

Now, our persistence layer can be as simple as persisting the existing type as-is, as we already did the projection.

```csharp
public class CustomerPersister : IPersist<Customer> {
  public void Persist(Customer customer) {
    _db.SaveOrUpdate(customer);
    customer.Events.Clear();
  }
}
```

If you wanted for example to update documents without concurrency, you could then optimise your document database driver implementation to only implement the field that you want. It allows you to decide on the best strategy for concurrency inside your persister, by implementing each event independently.

## Composition to the rescue

Once you have such implementation, it becomes trivial to use the [Russian doll model][russian-doll] to do additional things.

Say you want to publish all those events to a messaging library, it becomes easy.

```csharp
public class MessagingPersister : IPersist<Customer> {
  IPersist<Customer> _inner;
  ISend<object> _eventPublisher;
  public void Persist(Customer customer) {
    var evts = customer.Events.ToList(); // get a copy
    inner.Persist(customer);
    // everything went well, publish
    foreach(var @event in evts) _eventPublisher.Publish(@event);
  }
}
```

All the same, you can now keep an audit log of everything that happened for an entity, by adding another level of composition that writes to a log file.

## Semantic persistence

The advantage of semantic persistence over more traditional approaches is that, by providing the actual events describing what happened to the driver, it can make smarter decisions without trying to reverse-engineer the context of an operation from state changes.

In our project, we used this very efficiently to let the mongo driver do concurrency-free updates to parts of documents we didn't care to have concurrency on, and to reimplement the same in our in-memory simulator, through a retry of the operation by reapplying the bson stream as a value in a concurrent dictionary, until it won. The two implementations couldn't be different, and yet for consumers and our test rig, they were behaving the same.


[udi-events]: <http://udidahan.com/2009/06/14/domain-events-salvation/>
[russian-doll]: <http://codebetter.com/jeremymiller/2011/01/09/fubumvcs-internal-runtime-the-russian-doll-model-and-how-it-compares-to-asp-net-mvc-and-openrasta/>
