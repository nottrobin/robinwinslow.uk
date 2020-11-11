---
title: Best-practice tips for programmers
date: 2014-01-08 00:00:00 Z
tags:
- dev
- back-end
- canonical
description: A bunch of useful tips for programming well (written in 2012)
image_url: https://assets.ubuntu.com/v1/57d7e9cf-Best+practice+tips+for+programmers.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

I wrote this set of programming principles for my team to follow back in 2012. I'm sure there are many like it, but this one is mine. May you find it useful.

## Writing code

Try to write [expressive code](http://en.wikipedia.org/wiki/Self-documenting).

Beware [code bloat](http://en.wikipedia.org/wiki/Code_bloat) - adhere to the [YAGNI](http://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it) principle

Practicing [Behaviour-Driven Development](http://en.wikipedia.org/wiki/Behaviour-driven_development) can help with both of these aims.

[Do less](https://www.gov.uk/designprinciples#second): Before writing a new piece of functionality, go and look for similary solutions that already exist and extend them.

### Code architecture

[Namespace](http://en.wikipedia.org/wiki/Namespace_(computer_science)) your classes, and [code to an interface](http://stackoverflow.com/questions/383947/what-does-it-mean-to-program-to-an-interface) (this is an implementation of the [Design by Contract](http://en.wikipedia.org/wiki/Design_by_contract) principle), and make your interfaces (both programming interfaces and user-interfaces) [as simple as possible](https://www.gov.uk/designprinciples#fourth).

Try to learn and comply with all 5 principles of [SOLID](http://en.wikipedia.org/wiki/SOLID_(object-oriented_design)) (watch [this great video](http://vimeo.com/12350535#at=0)).

Learn as many [Design Patterns](http://en.wikipedia.org/wiki/Design_patterns) as you can to inform your coding, [but beware of implementing them blindly](http://discuss.joelonsoftware.com/default.asp?joel.3.219431). Developers can be over-zealous in their use of Design Patterns and may [end up over-engineering](http://loosely-coupled.blogspot.co.uk/2009/03/over-engineering-and-design-patterns.html) a solution.

Some useful design patterns:

- [MVC](http://en.wikipedia.org/wiki/MVC_Pattern) (obviously)
- [The observer pattern](http://en.wikipedia.org/wiki/Observer_pattern) (events)
- [The adapter pattern](http://en.wikipedia.org/wiki/Adapter_pattern) (for useful abstraction of layers - like the data layer)
- [The factory method pattern](http://en.wikipedia.org/wiki/Factory_pattern) (although be careful: Creating multiple factory classes is often [overengineering](http://en.wikipedia.org/wiki/Overengineering))

## Tools

Try to learn an [IDE](http://en.wikipedia.org/wiki/Integrated_development_environment) with advanced features. These can really save you a lot of time:

- Syntax highlighting
- Auto-complete for function, class and method names
- Auto-formatting
- Code navigation help - e.g. jump to class declaration
- Collapsing of code blocks
- Overviews of code, e.g. a list of all methods within a class
- Debugging tools like break points

Some suggestions:

- [Sublime](http://www.eclipse.org/projects/project.php?id=tools.pdt)
- [Visual Studio](http://www.microsoft.com/visualstudio/en-us)
- [Eclipse](http://www.eclipse.org/projects/project.php?id=tools.pdt)
- [Netbeans](http://www.eclipse.org/projects/project.php?id=tools.pdt)