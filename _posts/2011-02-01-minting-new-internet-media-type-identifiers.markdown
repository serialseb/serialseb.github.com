---
author: sebastienlambla
comments: false
date: 2011-02-01 15:51:01+00:00
layout: post
slug: minting-new-internet-media-type-identifiers
title: Minting new Internet Media Type Identifiers
wordpress_id: 38
---

A lot of conversations have been had at #restunconf about minting a new media type, when you should do it and how. I’ll try to blog about it in the closer future, but a recent discussion on twitter is triggering a quick and dirty run-through of how, when you create a new Internet Media Type (sometimes inaccurately call content type or MIME type), you should create a media type identifier.

_Note: all I’m discussing here has been around since 1996, 15 Internet years ago. If you find vendors not following those rules, it is your responsibility as a user of the Internet to notify them that their knowledge is probably the same age as their youngest employees._

## Back to basis

A media type identifier is composed of three components: a content type, a content subtype and some parameters that can be specified.

For example, html is usually served as **text/html**, where the content type is text, and the content subtype is html. An example of a parameter you’ll encounter often is the **charset** parameter, as in **text/html;charset=utf-8**.

## Choosing the content type

The first step in minting your media type identifier is to decide in which content type it belongs. The list is [defined by the IANA](http://www.iana.org/assignments/media-types/), and contains such things as text, audio, video, model and the well-known application.

Each of the IANA-defined content types have certain requirements that your media type need to conform to, and there’s a good reason for that: generic processing fall-back. When a user-agent (a browser or whatever you use as a web client) encounters a media type identifier it doesn’t understand specifically (say text/vnd.openwrap.descriptor), it can fall-back to the processing rule for the content type (text) and display things as if the format was actually text/plain. 

Let’s review the two most contentious content types.

### text

If the content of your media type can be shown as is, in notepad, with no control characters for formatting, and still be readable to humans, then it should belong in the text content type. This allows you to specify the encoding of such text using the **charset** attribute defined for the content type.

This is why plain text uses **text/plain**, html uses **text/html** and word documents are not served in the text branch: you can’t open those in notepad.

So why is xml served as application/xml rather than text/xml? The latter is registered, but comes with a bunch of restrictions: the default character set if not specified is ascii (as opposed to application/xml, where the default is handled by the XML specification), utf-16 and utf-32 are not allowed in the text content type (except when served in HTTP, do remember that media type identifiers are used in more places than HTTP).

More importantly, some systems do transcoding of character sets dynamically when mediating a communication to a text content type. The problem with XML is that you can override this inside the xml document using a prolog, and that may render the transcoding invalid (trying to convert utf-32 to utf-8 when the processing instruction defines the encoding as being windows-1252).

For those reasons, most systems keep xml as application/xml, alleviating most of the compatibility issues you’d run into otherwise.

### application

The application content type is there for **application-specific** media types. This means that an application needs to handle that media type for it to be useful, and that the generic fall-back is to ask the user what to do with that stream of bytes (by defaulting to **application/octet-stream**).

This means that if you can put your media type in the **text** or **image** branches, you really should be doing that instead of using the application.

## Choosing a content subtype

The reason why IANA keeps a registry of media types is so that people can find out what kind of document they’re receiving. The subtype lets the user-agent know what to do with a specific subtype, while preserving the generic processing of the parent type.

What do you need to do to register your own subtype? The answer is defined in [[RFC4288]](http://www.ietf.org/rfc/rfc4288.txt?number=4288) and [[RFC4289]](http://www.ietf.org/rfc/rfc4289.txt?number=4289). To spare you a lengthy read, if you’re registering a subtype in the IETF branch (such as plain in **text/plain**), you’ll have to be going through a stringent standardization procedure that will question your registration and make it fit for purpose for the whole internet to use.

Not all media types, and certainly very few, if any, media type identifier you will mint for your own usage need to go through this long process, and that’s why the subtype itself is split into multiple trees.

The IETF (or stadnards) tree is the one we just discussed, and unless you want to invent the next ATOM format, you probably don’t need to care for it.

### The vendor tree

For vendors, the registration is much more simplified. The way to register a vendor-specific media type is by prefixing your subtype with **vnd._vendorname._**_ _For example, the descriptor format in OpenWrap will be registered as _text/vnd.openwrap.descriptor. _If you however have a very well-known application, you may wish to register without the vendor name, as in _text/vnd.msword_.

As an advice, registrations in the form _vnd.vendor.format_ are usually less contentious than _vnd.producername_, so choose the former if you can.

Once you have defined your media type identifier to use the vendor branch, you can either stop there (and be a bad, bad Internet citizen), or you can submit your registration to the IANA for inclusion in their list. It’s optional but it’s better for everyone if you do.

### The vanity tree

I just love the name _vanity_ tree, also called the _personal_ tree. It’s where you would put stuff you don’t really intend anyone but yourself to use, or where you put experiments in. As with the vendor tree, the registration is optional, and as with the vendor tree, you use a prefix, **prs**, as in **application/prs.serialseb.odatadoneright**.

### The x- or x. prefix

This is the main reason why I wrote this blog entry. The x- or x. prefixes are only to be used for _“unregistered, experimental, and for use only with the active agreement of the parties exchanging them”_. To go one further, because we already have the vendor and vanity trees, _“use of both "x-" and "x." forms is discouraged”_. 

Be aware that **I have no such agreement with anyone**, so any time you create one of those atrocities, you’re in breach of the standard and using something no one wants. You’re invading my personal space. You’re leaving poo all over the internet carpet and I have no clue as to what the heck your format is, as it’s not registered anywhere.

In other words, don’t **ever** use x- or x. unless you want to look really silly or admit you’ve not read about web standards in the last 15 years. No ifs, no buts. Just don’t.

## Subtype suffixes

This leaves us with suffixes. They were introduced with the XML specification to allow annotating subtypes that use the xml serialization, and are in the form **+xml**. The idea behind those is the same as with types and subtypes, allow for generic processing in case the specific one doesn’t work. It’s as such believed that if a user-agent doesn’t understand the **application/xhtml+xml** media type, then it should be able to fall-back on xml processing to display *something* to the client.

In practice, this is not implemented by many agents (although OpenRasta 3 will deal with those scenarios), but there you go: if you use XML for your custom media type, +xml is the way to go. There’s also some traction to registering the +json convention as well for those liking this format.

## Parameters

Finally, parameters can be registered too at the same time as your media type identifier. There is also a lot of confusion around those, so let’s clear up some air.

First, you inherit all the parameters defined on the content type, That means that **any** text content type will **always** have charset as a defined parameter, be it that you like it or not.

If you want your own, you **must** register any parameter at the same time as your media type identifier. You can’t add them randomly without specifying them. You can’t change the nature of a media type registration by adding a parameter afterwards, even if you re-register your media type. If you did, any processing that used to be done on a media type would now become broken.

What you can do, as you version your media type identifier registrations (aka submit a new one), is to add information about what the media type is. Let’s see a concrete example of what non-breaking additional parameters can be registered.

_Note that I wasn’t part of that standardization process, and didn’t actually read the conversations, but the rationale for what was done exposes my point, be it that the rationale is accurate or not._

When the application/atom+xml media type identifier was registered, there was no _entry_ parameter. The media type identifier was to identify something containing atom, which could be a feed or an item, and it was up to an Atom processor to know the difference.

When AtomPub was standardized, there was a need to make a distinction between feed and item, something the original spec didn’t account for. At that stage, the Atom people had two scenarios: either mint a new media type identifier for entries, or add a parameter to the existing registration.

In the first scenario, you would end up with application/atom+xml, which could be either a feed or an item, and application/atom-entry+xml, which would be an entry. All previous processors understanding application/atom+xml, which could read feeds or items, wouldn’t understand the new media type identifier, even though they would understand the content of the media type. Incompatibility ensues.

When defining the type parameter, the new processors can make a distinction between feed and item if the entry parameter is present. If the new registration was changing the meaning of the media type to make the parameter mandatory, you’d have the same scenario as using a new media type: incompatibilities. But the guys writing the spec are smart: they indicate that in the absence of the type parameter, it’s business as usual, it can be either: you preserved compatibility with the previous agents.

## Conclusion

Media type identifiers can look challenging, but they’re very powerful when used properly, and follow rules that are quite simple to understand. Registrations for vendors and users, when not going for standardization, is not mandatory but help the whole community. Adopt the correct identifier, let the IANA know and make the Internet a better place for everyone.
