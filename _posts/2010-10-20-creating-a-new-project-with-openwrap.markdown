---
author: sebastienlambla
comments: true
date: 2010-10-20 11:36:00+00:00
layout: post
slug: creating-a-new-project-with-openwrap
title: Creating a new project with OpenWrap
wordpress_id: 12
---

With all this discussion of OpenWrap stuff, we've not covered yet how easy it is to create a new project in OpenWrap and get it off the ground.




For OpenWrap to function, you don't need much. You need a /wraps folder at the root of your code, a descriptor file, and optionally a version file.




### Creating a new package




The easiest way to create a new project is to use the _init-wrap _command with a name for your new package or project. As I use git, I'll also ask it to generate the .gitignore files for me.



    
    <div><strong>PS C:\src></strong><i> o init-wrap newProject -git</i></div>
    # OpenWrap v1.0.0.0 ['C:\Users\sebastien.lambla\AppData\Local\OpenWrap\wraps\_cache\openwrap-1.0.0.19240580\bin-net35\OpenWrap.dll']
    Specify either the path to the projects you want updated or -all to find all projects automatically.
    Copying 'openwrap-1.0.0.19240580' from 'System repository' to 'Project repository'
    Copying 'openfilesystem-1.0.0.19074013' from 'System repository' to 'Project repository'
    Copying 'sharpziplib-0.85.5.452' from 'System repository' to 'Project repository'
    Package 'newProject' initialized. Start adding packages by using the 'add-wrap' command.




Your project structure is now going to be fully created, together with ignore files and the first couple of packages you need.




### Adding a new project




[![image](http://s3.amazonaws.com:80/CodeBetter/CommunityServer.Blogs.Components.WeblogFiles/sebastien_lambla/image_thumb_7B552FB0.png?AWSAccessKeyId=0KMA35HT86EVXB99Z302&Expires=1919787627&Signature=aWpe0g3jFrModXtWObTXZ3f%2bxu8%3d)](/cfs-file.ashx/__key/CommunityServer.Blogs.Components.WeblogFiles/sebastien_5F00_lambla/image_5F00_57104B2E.png)Now you can go and open Visual Studio, and create a new project in the /newProject/src folder that was created earlier. Any will do, I'll add a new bog standard "Class Library" project and name it _NewProject.Core_.




Note that you can use any C# project type, OpenWrap doesn't care much. VB and other languages can be supported, as soon as someone ask for them we'll add that.




One of the things that makes OpenWrap different is also that you can create a Visual Studio 2008 or Visual Studio 2010 project, it doesn't matter either. And you can choose a .net 2, .net 3.5 or .net 4 project type, it will all still work.




### OpenWrap, meet Project, Project, meet OpenWrap




Next, we need to inject OpenWrap in the build process of that project. Again, not much to do there, it's a one-liner. Go into the folder you created earlier, and execute the init-wrap command with the -all parameter. This instructs OpenWrap to find all '.csproj' files and update them.



    
    <div><strong>PS C:\src></strong><i> cd newProject</i></div>
    <div><strong>PS C:\src\newProject></strong><i> o init-wrap -all</i></div>
    # OpenWrap v1.0.0.0 ['C:\src\newProject\wraps\_cache\openwrap-1.0.0.19240887\bin-net35\OpenWrap.dll']
    Package descriptor found.
    Project 'C:\src\newProject\src\NewProject.Core\NewProject.Core.csproj' updated to use OpenWrap.




If you return to Visual Studio, you'll be greeted by a dialog box letting you know the project was modified. Reload it, and you'll be ready to go.




### Writing some code




We'll write a log4net class in our newly-created project.















  1. namespace NewProject.Core


  2. {


  3. public class Appender : log4net.Appender.TextWriterAppender


  4. {


  5. 

  6. }


  7. }













As you can see, ReSharper tells us it doesn't recognize that class. Let's add the package for log4net.



    
    <div><strong>PS C:\src\newProject></strong><i> o add-wrap log4net</i></div>
    # OpenWrap v1.0.0.0 ['C:\src\newProject\wraps\_cache\openwrap-1.0.0.19240887\bin-net35\OpenWrap.dll']
    Wrap descriptor found.
    Project repository present.
    Dependency added to descriptor.
    Copying 'log4net-1.2.10' from 'nu' to 'System repository'
    Copying 'log4net-1.2.10' from 'nu' to 'Project repository'
    Making sure the cache is up-to-date...




If you now go back to your solution, you'll notice that the red lining is now gone, and you can build your code as if you had added the reference yourself. If you don't use Resharper, rebuild your project as normal and see that the code compiles.




### Packaging a package




You now have functional code you're happy with, and you want to share your package. Fear not, for again, it's a one-liner.



    
    <div><strong>PS C:\src\newProject></strong><i> o build-wrap -quiet</i></div>
    # OpenWrap v1.0.0.0 ['C:\src\newProject\wraps\_cache\openwrap-1.0.0.19240887\bin-net35\OpenWrap.dll']
    Output found - bin-net40: 'C:\src\newProject\wraps\_cache\log4net-1.2.10\bin-net20\log4net.xml'
    Output found - bin-net40: 'C:\src\newProject\src\NewProject.Core\obj\Debug\NewProject.Core.dll'
    Copying: bin-net40 - C:\src\newProject\wraps\_cache\log4net-1.2.10\bin-net20\log4net.xml
    Copying: bin-net40 - C:\src\newProject\src\NewProject.Core\obj\Debug\NewProject.Core.dll
    Package built at 'C:\src\newProject\newProject-0.0.1.19243541.wrap'.




Note that I've used the -quiet parameter to silence the MSBuild output. You can of course see the whole output by simply removing that parameter.




### Publishing a package




Only thing left to do to start sharing your code is to publish it. I use the Network Share feature for publishing my packages, so it's dead easy.



    
    <div><strong>PS C:\src\newProject></strong><i> o publish-wrap netshare .\newProject-0.0.1.19243541.wrap</i></div>
    # OpenWrap v1.0.0.0 ['C:\src\newProject\wraps\_cache\openwrap-1.0.0.19240887\bin-net35\OpenWrap.dll']
    Publishing package 'newProject-0.0.1.19243541.wrap' to 'netshare'





And I can verify that the package was indeed published properly by listing the packages in the remote.




    
    <div><strong>PS C:\src\newProject></strong><i> o list-wrap -remote netshare</i></div>
    # OpenWrap v1.0.0.0 ['C:\src\newProject\wraps\_cache\openwrap-1.0.0.19240887\bin-net35\OpenWrap.dll']
     - newProject (versions: 0.0.1.19243541)




As always, don't forget you can get help on each of those commands by using the _get-help_ command.
