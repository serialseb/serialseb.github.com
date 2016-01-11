---

comments: true
date: 2010-10-15 08:43:01+00:00
layout: post
slug: building-polyglot-packages-for-openwrap-and-nupack
title: Building polyglot packages for OpenWrap and NuPack
wordpress_id: 6
---

As we approach a first full-featured OpenWrap release, it’s time to provide package builders some guidance in how to build good packages.

 

For a week now, the OpenWrap client has supported the NuPack package and feed format for assemblies. We don’t support powershell scripts so far, as OpenWrap doesn’t have a dependency on it, but assemblies in the /lib folder are fully supported.

 

### Test your packages

 

The easiest way to test a nupack package is to use the convert-nupack command available in OpenWrap.

 
    
    <div><b>PS C:\tmp></b><i> o convert-nupack .\Castle.Core.1.1.0.nupkg.zip Castle.Core.1.1.0.wrap</i></div>
    # OpenWrap v1.0.0.0 ['C:\Users\sebastien.lambla\AppData\Local\OpenWrap\wraps\_cache\openwrap-1.0.0.18826071\bin-net35\OpenWrap.dll']
    Package successfully converted.





This will convert the NuPack into an OpenWrap package. You can then add this package to your system repository or to any other project as usual.





### Understand framework profiles





The resolution logic between NuPack and OpenWrap is slightly different.





NuPack will add references to the dlls it finds in a folder called /lib/[Framework][Version], and only in that package.





OpenWrap, because it focuses on solving dependency resolution at run-time too, supports dynamically swapping assemblies by name, and will process any compatible assembly in the package. An example will make it clearer.





The Newtonsoft.Json package contains a .net 2.0 specific dll in /lib/20 called Newtonsoft.Json.Net20.dll, and a 3.5 version in /lib/35. Only one of those references should be included.





NuPack will only add the /20 or the /35 libraries to your project. OpenWrap however will find two assemblies named differently, and provided you are resolving those assemblies in a .net 3.5 environment, will import both.





The correct way to package your assembly is to name the same assembly targeting different frameworks the same, and put them in the correct folder.





To sum up, here’s the structure that should be used to package your assemblies targeting different versions.





NuPack






  
  * /lib 
    
      
    * /20 
        
          
      * Newtonsoft.Json.dll (formerly /lib/20/Newtonsoft.Json.Net20.dll) 

        
      


      
    * /35 
        
          
      * Newtonsoft.Json.dll (formerly /lib/35/Newtonsoft.Json.dll) 

        
      

    
  





OpenWrap






  
  * /bin-net20 
    
      
    * Newtonsoft.Json.dll (formerly /lib/20/Newtonsoft.Json.Net20.dll) 

    
  


  
  * /bin-net35 
    
      
    * Newtonsoft.Json.dll (formerly /lib/35/Newtonsoft.Json.dll) 

    
  





### Version your packages





Versioning of packages is vital for good package management. I’m not entirely sure what the versioning behaviour for NuPack is, but OpenWrap is quite opiniated. Each package can and should be versioned using the _Major_._Minor_._Build.Revision _format.





When you take a dependency on a package version however, OpenWrap will **ignore** the Revision component, and automatically import any new revision of a package next time you update.





The reason for this is to enable hot patching packages to correct issues without users having to change the dependency they declared.





Let’s take an example. Let’s push a package to a remote repository.




    
    <div><b>PS C:\tmp></b><i> o publish-wrap server .\castle.core-2.5.1.0.wrap -debug</i></div>
    # OpenWrap v1.0.0.0 ['C:\Users\sebastien.lambla\AppData\Local\OpenWrap\wraps\_cache\openwrap-1.0.0.18839165\bin-net35\OpenWrap.dll']
    Publishing package 'castle.core-2.5.1.0.wrap' to 'server'





I now add a dependency to my project (you would do the same using xml in your .nuspec if you build for NuPack).





depends: castle.core = 2.5.1.0





And I ask OpenWrap to fetch the latest packages.




    
    <div><b>PS C:\tmp\castle.user></b><i> o update-wrap</i></div>
    # OpenWrap v1.0.0.0 ['C:\tmp\castle.user\wraps\_cache\openwrap-1.0.0.18839165\bin-net35\OpenWrap.dll']
    'Project repository' up-to-date as 'openwrap-1.0.0.18839165' <= 'openwrap-1.0.0.18839165'.
    'System repository' up-to-date as 'Castle.Core-2.5.1' <= 'Castle.Core-2.5.1'.
    Copying 'Castle.Core-2.5.1.0' from 'server' to 'Project repository'
    'Project repository' up-to-date as 'openfilesystem-1.0.0.18676829' <= 'openfilesystem-1.0.0.18676829'.
    'Project repository' up-to-date as 'sharpziplib-0.85.5.452' <= 'sharpziplib-0.85.5.452'.
    Making sure the cache is up-to-date...





Of course, you would’ve had the same result by simply asking OpenWrap to add the pacakge with the add-wrap command.





If I now push a new version of castle.core, say 2.5.1.1, and execute an update, the package will be automatically updated to the latest version, no question asked.





To recap:






  
  * Do change the revision part to deploy hot fixes to your package so people don’t have to update their dependency files 


  
  * Do change the build, minor or major components when you want to let people depend on a different version of your API**.** 

    
      
    * Update the build component when you **add** new classes or method 


      
    * Update the minor component when you **rename**, **remove** or **change the signature** on your API. 


      
    * Update the major as you wish. 

    
  





### Don’t sign your assemblies





One of the features OpenWrap provides is dynamic swapping of assemblies based on your framework version and platform (x86, MSIL, etc). This can only work if you don’t depend on signed assemblies, and if you don’t sign yours.





If you have signed assemblies in your workflow, you will have to create publisher policy redirections, a lot of xml that goes in your .config files. We may automate this process in the future, but if you’re going to automatically add those entries to enable new versions of an assembly to be used, you may as well _Keep it Simple Stupid_ and not sign them.





There is no reason to use assembly versioning when package versioning is in place. Contrary to what some may think, it doesn’t provide identification of assemblies (anyone can generate a key), it doesn’t protect your assembly from decompilation, it is only used for ensuring that software compiled against a certain version of an assembly **doesn’t** get updated without a recompile, which is exactly what we’re trying to avoid.





### Understand your dependencies





If you follow the versioning model I mentioned above, you will know which range of versions your assemblies depend on.





Problem is, at a very minimum, it’s unlikely that version 3 of NHibernate will have exactly the same API surface as version 2. Don’t take an unversioned dependency!





Always try to provide at the very least a Major.Minor dependency in your descriptor. If you’re worried about the future and people being broken, this is exactly the reason for the Revision auto-update behaviour we’ve discussed earlier.





If a new version of a package comes out and doesn’t break your package, you can simply edit the package with a modified revision range, and people will get automatically updated next time they issue an _update-wrap_ command.





### Conclusion





Building packages is not an easy thing to do, and supporting multiple uncoordinated package managers is not easy either. If you follow these guidelines, you should however manage to build your packages correctly.
