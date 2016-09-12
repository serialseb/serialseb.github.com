# Versioning APIs

Systems change over time. New requirements come in, old requirements go out,
new technologies and processes make computing systems evolving beasts.

This change leads to changes in the contracts that we already know well: public
classes, their interfaces, function signatures, data structures, you name it.

In the 1960s, computing developed to the point networks made it possible to not
only deal with data structures locally, but to also exchange messages on the
network. What if, engineers of the day must've asked themselves, what if we took
the data structures and procedures we call, and called them remotely, on
a completely different computer. And thus RPC, or remote procedure call, was
born, with iterations such as DCE, DCOM, CORBA, ICE and many others.

From there on, HTTP slowly but surely took over the world. From then on,
we've had to deal with change in APIs over HTTP.

## Change management and good business

Any business owner will tell you, if you have customers, you have contracts. 
They describe what you and your consumers agree on, and you keep on working
for as long as that contract is valid. Break it and the customer goes, and you
no longer get paid.

This is what _change management_ is about: how does one evolve a contract 
between providers and consumers?

## RPC over HTTP

Executing a remote procedure call requires three things: the _name_ of a 
procedure, a network location where the procedure may exist, and a data
structure it expects.

This has been implemented over HTTP in many ways, so we'll start wiht a simple
example: posting a tweet. It has a _name_, `PostTweet`, a _data structure_,
the text of the tweet, and a network location, encoded in a URL.

```HTTP
> POST /PostTweet
> Content-Type: text/plain
>
> RPC ain't that bad!
>
< 200 OK
< Content-Type: text/plain
< 
< Thank you
<
```

The data format of our procedure is not extensible, it can only contain text,
and so far it's OK, we don't have any requirements for anything else. Ship it!
