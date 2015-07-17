---

comments: true
date: 2010-10-22 01:12:00+00:00
layout: post
slug: building-packages-with-openwrap
title: Building packages with OpenWrap
wordpress_id: 13
---

So, I was reading this [entry about how to build packages for NuPack](http://markkemper1.blogspot.com/2010/10/creating-nupack-package-using-build.html). That is something people need to know about for OpenWrap too, so this is the documentation of what you *can* do.




### Building, Out Of the Box




If you have built your first project, and followed the default conventions, you'll know already that building your package for OpenWrap takes a grand total of a one-liner.



    
    <div><strong>PS C:\src\wraps\Castle.Services.Transaction></strong><i> o build-wrap -quiet</i></div>
    # OpenWrap v1.0.0.0 ['C:\src\wraps\Castle.Services.Transaction\wraps\_cache\openwrap-1.0.0.19333731\bin-net35\OpenWrap.dll']
    Copying: bin-net35 - C:\src\wraps\Castle.Services.Transaction\wraps\_cache\log4net-1.2.10\bin-net20\log4net.xml
    Copying: bin-net35 - C:\src\wraps\Castle.Services.Transaction\src\Castle.Services.Transaction\obj\Debug\Castle.Services.Transaction.dll
    Copying: bin-net35 - C:\src\wraps\Castle.Services.Transaction\src\Castle.Services.Transaction\bin\Debug\Castle.Services.Transaction.XML
    Package built at 'C:\src\wraps\Castle.Services.Transaction\Castle.Services.Transaction-2.1.0.19335506.wrap'.




This is how we do things. Out of the box, you have nothing to do.




### Building, customized




Now, you may want to build your package in a different way.




By default, OpenWrap tries and compile any file that ends with .*proj. This is certainly enough for most of what we do, but there's always this edge case where you only want to build certain projects.




Fear not, it's dead simple. In your descriptor file (the one with the _.wrapdesc_ extension) you can override a lot of the default features. I won't talk about platform and profile support yet, that will be in a future blog entries. But what if you only want a specific project to be built?




You can do that easily by modifying your .wrapdesc file and add a build entry.



    
    build: msbuild;project=src\Castle.Services.Transaction\Castle.Services.Transaction-vs2010.csproj




This line states that msbuilld is how you want to build your package, and provides the path to the msbuild project you want to build. The result is as easy as that, only that project will be built.




### Targeting multiple versions of .net




In some projects, you may end up wanting to build your project once per version you support. The typical example would be to build it once for the Microsoft CLR, and a second time specifically for mono. We support that too.



    
    build: msbuild;profile=net20;profile=net35




By adding those parameters to the msbuild instruction, OpenWrap will call every project to be compiled with a different value for the OpenWrap-TargetProfile parameter. Each of the builds will impact what assemblies get included (by selecting the correct version of an assembly in each of the folders of all referenced packages), and will set the _OpenWrap-TargetProfile_ msbuild property with the version that was provided. If you need to conditionally compile code using #if instructions, you can set those in your msbuild file based on the msbuiild property.




### How does it work




OpenWrap tries to play dumb when it comes to parsing the result of your build. The only thing it's looking for are instructions you output in your build.




Each of those instructions should follow a simple template.




_[built(targetFolder, "pathToFile"]_




Whenever such an instruction is encountered in the output of your msbuild file, OpenWrap will package the file at _pathToFile_ in the package folder named _targetFolder_.




### Supporting nant, rake and other build tools




The beauty of such a system (allegedly inspired by how teamcity receives instructions from build outputs) is that it will be trivial to implement other build tools using the same mechanism.




In the very close future, another build provider will be created to let you run arbitrary command-lines, and provided you output the correct instructions (which, if your projects have been hooked up to OpenWrap with the _init-wrap -all_ command, comes for free), you'll be able to provide something along the lines of a generalized command-line tool. In this example, I use a typical pre-deployed (part of a lib folder) of nant.



    
    build: command;line=lib\nant\nant.exe build\nant-build




If you need those features, please add them to our github tracker and vote on them to prioritize them.




### Conclusion




Building doesn't have to be complicated. OpenWrap supports MSBuild, and will support external tools, as well as simple post-build file-copy (which is the only thing NuPack/NFetch/GodKnowsWhatItsCalledTheseDays does). As we are community driven, the more of you ask for one, the quicker it'll get in.




But if our featureset is anything to go by, chances are, we'll implement it before you have to ask for it. :)
