---
layout: post
title: WinFS Interop
tags: [longhorn, winfs]
date: 2003-11-10T14:32:25+00:00
---

Ken ask a [question](http://dotnetjunkies.com/weblog/kenbrubaker/posts/3398.aspx) on winFS interop. From what we got from the newsgroups (you should really come and see them), WinFS has two ways of copying file and metadata.

The first way is to preserve the content by serailizing everything, the object, the relations, in a big binary blob that will be deserialized when copied over winFS again (used for contacts for example).

The second way is the Type handler fetching the metadata back into the file (less than optimal solution, but can be supported in most file formats by using extensibility headers in jpeg, tags in MP3, etc...).

To be absolutely accurate, a quote from Ward Beattie from MSFT:

 > There are really two kinds of copy operations out of WinFS. Toby is
 > referring to the lossless export supported by the WinFS API. If the item is
 > backed by a Win32 file (e.g. a jpeg file), then you can also copy the file
 > stream only using the Win32 API. In this case, the file stream will contain
 > the modified metadata PROVIDED that the system has a demoter which can push
 > the metadata properties into the file (not all file formats can support
 > this). Sanjay's presentation for session CLI326 includes an overview of this
 > mechanism.
