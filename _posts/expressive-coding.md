---
layout: post
title: 'Writing expressive ("self documenting") code'
tags:
	- development
---

As any coder gains experience, they inevitebly become more and more aware of all the different ways in which a logical problem can be solved.

The very first consideration is simplicity. We probably want to use as simple and direct a solution as possible - to avoid over-engineering.

But once we've found a simple solution, the very next consideration should be expressiveness. You should always be thinking about how deeply a new developer is going to have to delve into your code to understand what's going on.

The "self-documenting code" myth
===

This is sometimes called "self-documenting code" because in some simple cases if you write expressive enough code it may be immediately obvious what's going on without comments. Some comments are obviously a waste of time:

``` php
$user = new User(); // create a new user object
$user->loadFromSession(session); // update the user from the session
if ($user->isAuthenticated()) { ... } // If the user is authenticated...
```

However, as a recent discussion with [a friend of mine](http://twitter.com/karlwilliams) highlighted to me, *expressive code is no replacement for documentation*. Always write as expresively as you can, but *also* always document where it makes sense. Methods, functions and objects should always be summarised with a comment.

Wording
===



Encapsulation
===



Depth
===



Asking for dependencies
---


Trade-offs
===

There will always be a trade-off between expresiveness and succinctness. For example, in C#:

``` C#
var brownFish;

foreach (var fish in fishes) {
	if (fish.colour == "brown") {
		brownFish = fish;
		break;
	}
}
```

Can also be written:

``` C#
using System.Linq;

var brownFish = fishes.First(x => x.colour == "brown");
```

The latter one is clearly simpler, and hopefully not too difficult to understand, but its does require:

1. Knowledge of the Linq library
2. An understanding of lambda expressions work

I think that in this case the Linq solution is so much simpler and quite expressive enough that it should definitely be preferred - and hopefully if another developer doesn't know about Linq, it will be quite easy for them to pick up, and will expand their knowledge.
