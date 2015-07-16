---
author: sebastienlambla
comments: true
date: 2011-09-14 17:17:11+00:00
layout: post
slug: extending-configuration-in-openrasta-2-1
title: Extending configuration in OpenRasta 2.1
wordpress_id: 79
---

_[Updated to clarify what the configuration meta-model actually is.]_

The latest OpenRasta 2.1 code contains some changes that make extending the fluent API easier, and provide a supported way for you to write those extensions in a way that won’t break with OpenRasta 3.0.

## OpenRasta configuration meta-model

The one thing everyone knows about OpenRasta is it’s resource-oriented fluent configuration API. What few people know is how it works behind the scene.

Whenever you configure a resource, the fluent API creates a ResourceModel instance and stores it. Once all the configurations are done, a set of objects process those registrations to initialize OpenRasta itself, such as registering types in the container, mapping URIs or creating a list of codecs.

Each of the configuration elements of OpenRasta is represented by one configuration object, and the set of all those configuration bits is what we call the configuration meta-model, and is stored in the IMetaModelRepository service.

The astute reader will have noticed that in practice this means that the use of the fluent API is optional, and indeed the astute reader would be absolutely right.

One of the things that was not easily doable in 2.0 was extending that meta-model by extending the existing fluent configuration API. Why would we want to do this? Let’s take an example that will expose the whole stack of extension points in OpenRasta and add support for authentication at the configuration level.

## Understanding the new extension points

A typical 2.x era configuration for a resource contains multiple chained methods, one per thing you want to configure for a resource.

            using (OpenRastaConfiguration.Manual)  
            {  
                ResourceSpace.Has                       // IHas  
                    .ResourcesOfType<UserDocument>()    // IResource  
                    .AtUri("/public/{filename}")        // IUri  
                    .HandledBy<UserDocumentHandler>()   // IHandler  
                    .AsXmlDataContract();               // ICodec  
            }

The interfaces that you see on the right are new to 2.1 and are where the magic happens.

Let’s say we want to require authentication for any UserDocument resource. The recommended way to do this is to attach an extension method in your namespace and attach it to IResource.

To prevent intellisense from showing a lot of rubbish on those interfaces, to gain access to the extensibility points of the configuration API you need to cast the instance you get to IXxxTarget. In our example, let’s create a RequiresAuthentication method and add some metadata to that resource registration.

    public static class AuthenticationConfiguration  
    {  
        public static T RequiresAuthentication<T>(this T root) where T:IResourceDefinition  
        {  
            var target = root as IResourceTarget;  
  
            target.Resource.Properties["caffeineit.demos.fluentauth.enabled"] = true;  
            return root;  
        }  
    }

The IResourceTarget interface contains about everything you need to add anything you want to the configuration model: the meta-model repository, the current resource registration and its list of URIs, Handlers and Codecs.

Here we’ve added some additional data to enable authentication that we need to process from somewhere else.

## Platform-wide operation interceptors

The second extension point we’ll use is the support for operation interceptors, which are small components that can interact and make decisions before your handler code gets called.

You may have seen them being used in OpenRasta on a per-method basis, usually together with an attribute that creates them, such as [RequiresAuthentication] or [RequiresRole]

Whenver a URI is matched by OpenRasta, it is associated with a **resource key**. This is the cornerstone of the OpenRasta model, as with a resource key we can find all handlers, URIs, codecs and anything else associated with the resource we have. We’re going to be using this to get the information we’ve added in our configuration.

 

    public class FluentAuthenticationInterceptor : IOperationInterceptor  
    {  
        IMetaModelRepository _configuration;  
        ICommunicationContext _env;  
  
        public FluentAuthenticationInterceptor(IMetaModelRepository configuration, ICommunicationContext env)  
        {  
            _configuration = configuration;  
            _env = env;  
        }  
  
        public bool BeforeExecute(IOperation operation)  
        {  
            var currentResource = _env.PipelineData.ResourceKey;  
            var registration = _configuration.ResourceRegistrations.FirstOrDefault(x => x.ResourceKey == currentResource);  
  
            object authEnabled;  
            if (registration != null &&  
                registration.Properties.TryGetValue("caffeineit.demos.fluentauth.enabled", out authEnabled) &&  
                (bool)authEnabled)  
            {  
                if (_env.User.Identity.IsAuthenticated == false)  
                {  
                    _env.OperationResult = new OperationResult.Unauthorized();  
                    return false;  
                }  
            }  
            return true;  
        }  
  
        public Func<IEnumerable<OutputMember>> RewriteOperation(Func<IEnumerable<OutputMember>> operationBuilder)  
        {  
            return operationBuilder;  
        }  
  
        public bool AfterExecute(IOperation operation, IEnumerable<OutputMember> outputMembers)  
        {  
            return true;  
        }  
    }

 

A few things are happening here. Of course we use **dependency injection** to take a dependency on the meta-model repository, where our configuration is stored, and on the ICommunicationContext, which gives us the principal of the current user, and which we need to know if someone has authenticated. On a side-note, that property is populated based on your hosting environment, so if you run on asp.net and have Forms authentication enabled, that will flow automatically with no work on your part.

We do the work in BeforeExecute so we can stop execution before any other code runs, be it other interceptors or our handler. Finally, if a user is not authenticated, we override the OperationResult for the current connection and return **false**, which instructs OpenRasta to stop processing anything and start writing the response back to the client.

## Hooking up the interceptor

The last bit we have to do is to give the interceptor to OpenRasta, and like everything else, it is handled by the IoC container. We can register custom dependencies in a unified fashion using the fluent configuration API.

ResourceSpace.Uses.CustomDependency<  
                    IOperationInterceptor,   
                    FluentAuthenticationInterceptor>  
                    (DependencyLifetime.Transient);

## Cleaning up and ready for packaging

Finally, like most plugins in OpenRasta, you should do all your configuration work as an extension on IUses, so we wrap the work that was done in the last bit into a nice extension method.

public static void FluentAuthentication(this IUses uses)  
        {  
            var target = (IFluentTarget)uses;  
            target.Repository.CustomRegistrations.Add(  
                new DependencyRegistrationModel(  
                    typeof(IOperationInterceptor),  
                    typeof(FluentAuthenticationInterceptor),  
                    DependencyLifetime.Transient)  
                );  
        }

And now our configuration looks nice and understandable.

            using (OpenRastaConfiguration.Manual)  
            {  
                ResourceSpace.Uses.FluentAuthentication();  
  
                ResourceSpace.Has                      
                    .ResourcesOfType<UserDocument>()   
                    .RequiresAuthentication()  
                    .AtUri("/public/{filename}")       
                    .HandledBy<UserDocumentHandler>()  
                    .AsXmlDataContract();              
            }

## Conclusion

The same extension points are available for URIs, for handlers, codecs, media type definitions and any other configuration model that exists. If you hang off those interfaces, your extensions will still work for the new compact configuration API and the convention-based configuration API that will be part of OpenRasta 3.0.
