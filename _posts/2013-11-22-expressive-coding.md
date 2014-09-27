---
layout: post
title: "Writing expressive code"
description: "Reading some legacy code today reminded me of some general principles that programmers could follow to make code easier to manage for future developers. I may have got a bit carried away..."
tags: 
  - dev
  - canonical
published: true
---

As any coder gains experience, they inevitebly learn more and more ways to solve the same problem.

The very first consideration is simplicity. We probably want to use as simple and direct a solution as possible - to avoid over-engineering. But the *simplest* solution is not necessarily the *shortest* solution.

After simplicity, the very next consideration should be *expressiveness*. You should always be thinking about how deeply a new developer is going to have to delve into your code to understand what's going on.

```
Code is poetry
```

Writing expressive code may help future coders to understand what's going on. It may even help you in the future. But it may also help you simply to understand the problem. Thinking carefully about how to define and encapsulate the components of your solution will often help you to understand the problem better, leading to a more logical solution.

"Self-documenting code"
===

["Self-documenting code"](http://en.wikipedia.org/wiki/Self-documenting_code) is about structuring your code and choosing your method and variable names so that your code will be largely self-describing. This is a great practice, and can make some comments redundant:

``` php
$user = new User(); // create a new user object
$user->loadFromSession(session); // update the user from the session
if ($user->isAuthenticated()) { ... } // If the user is authenticated...
```

However, as a recent discussion with [a friend of mine](http://twitter.com/karlwilliams) highlighted to me, expressive code is not a *replacement* for comments - no code is *entirely* "self-documenting". Always write as expresively as you can, but *also* always document where it makes sense. Methods, functions and classes should always be summarised with a comment - as mentioned in the [Python coding conventions](/2014/01/05/summary-of-python-code-style-conventions/#toc_3).

Wording
===

It's worth thinking carefully about how you name your variables and methods.

Don't abbreviate
---

``` javascript
var uid = 10; // I am unlikely to know what uid stands for without context
var userIdentifier = 10; // Better
```

Be specific
---

Use as concrete and specific nouns as you can to describe methods and functions:

``` javascript
var event; // bad - generic
var newsLinkClickEvent; // good - specific
```

Encapsulation
===

No-one likes to read a really long procedural program. It's very difficult to follow. It's much easier to read a shorter set of well-encapsulated method calls. If you need to delve deeper, simply look in the relevant method:

``` javascript
// Instead of showing you all the details of how we update the user
// We encapsulate that in the updateDetails method
// allowing you to quickly see the top-level processes
function saveUserDetails(userStore, userDetails) {
	var user = new User();
    user.updateDetails(userDetails); // sets a whole bunch of details on the user
    userStore.save(user); // Converts user data into the correct format, and then saves it in the user store
}
```

Do you need an `else`?
---

The use of many `if .. else` conditionals make programs confusing. In many cases, the `else` part can be encapsulated in a separate method or function call, making the program easier to read:

``` javascript
// With the else
if (user.permissionGroup == 'administrator') {
    article.delete();
} else {
    page.showError("Sorry you don't have permission to delete this article");
}
```

``` javascript
// Without the else
if (!user.deleteArticle(article)) {
    page.showError("Sorry you don't have permission to delete this article");
}
```

In cases where a `switch` is used, or multiple `if .. else if` statements, you could consider [using different types](http://haacked.com/archive/2013/11/08/death-to-the-if-statement.aspx/) instead:

``` php
class User {
    function deleteArticle($article) {
        $success = false;
        
        if (
            user->permissionGroup == 'administrator'
            || user->permissionGroup == 'editor'
        ) {
            $success = $article->delete();
        }
        
        return $success;
    }
}
```

You can remove the need for this `if`, by making special types:

``` php
trait ArticleDeletion {
    function deleteArticle($article) {
        return $article->delete();
    }
}

class Editor implements User { use ArticleDeletion; }
class Administrator implements User { use ArticleDeletion; }
```

Notice that I've deliberately opted *not* to make `Administrator` inherit from `Editor`, but instead compose them separately. This keeps my structure more flat and flexible. This is an example of [composition over inheritence](http://en.wikipedia.org/wiki/Composition_over_inheritance).

Depth
===

While encapsulation is often a good thing, to make programs easier to understand at the higher level, it's important to preserve the [single responsibility principle](http://en.wikipedia.org/wiki/Single_responsibility_principle) by not encapsulating [separate concerns](http://en.wikipedia.org/wiki/Separation_of_concerns) together.

For example, one could write:

``` csharp
var user = new User();
user.UpdateFromForm(); // Imports user data from the page form
user.SaveToDatabase();
```

While this is both short and fairly clear, it suffers from two other problems:

- The user has to delve further into the code to find basic information, like the name of the Database class, or which form the details are stored in
- If we want to use a different instance of the `Database`, we have to edit the `User` class, which doesn't make a whole lot of sense.

In general you should always pass objects around, rather than instantiating them inside each other:

``` csharp
var user = new User();
var userData = Request.Form;
var database = new DatabaseManager();

user.ImportData(userData);
database.Save(user);
```

This is more lines, but it is nonetheless clearer what is actually happening, and it's more versatile.

Tidiness
===

Always try to format your code so that it is easily readable. Don't be afraid of white space, and use indentation sensibly to highlight the structure of your code.

Where there is an accepted code style guide, you should try to follow it. For example, PHP has the [FIG standards](https://github.com/php-fig/fig-standards/tree/master/accepted).

However, I don't think it's worthwhile being overly anal about code standards (my thinking has evolved on this somewhat) because you'll never be able to get everybody to code exactly the same way. So if (like me) you're a coder who feels the need to reformat code whenever you see it to make it fit in with anal standards, you could probably so with training yourself out of that habit. As long as you can read it, leave it be.

Delete commented out code
---

If you're using a version control system (like [Git](http://git-scm.com/)) there really is no need to keep large blocks of commented-out or unused code. You should just delete it, to keep your codebase tidier. If you really need it again, you can just got and find it in the version control history. 

Trade-offs
===

There will always be a trade-off between expresiveness and succinctness.

Depth vs. encapsulation
---

It is desirible to keep as flat a structure as possible in your objects, so that programmers don't have to delve through parent class after parent class to find the relevant bit of code. But it is also important to keep code encapsulated in logical units.

Both the goals are often achievable by doing [composition over inheritence](http://en.wikipedia.org/wiki/Composition_over_inheritance) using [dependency injection](http://en.wikipedia.org/wiki/Dependency_injection) or traits / multiple inheritence.

Special syntax
---

In many languages there are often slightly obscure constructs that can nonetheless save time. With many of these there is a readability vs. simplicity trade-off.

### Ternary operators and null coalescing

Both C# and PHP have null coalescing operators:

```
var userType = user.Type ?? defaultType; // C#
$userType = $user->Type ?: $defaultType; // PHP
```

And almost all languages support the [ternary operator](http://en.wikipedia.org/wiki/%3F:):

``` javascript
var userType = user.Type != null ? user.Type : defaultType;
```

Both of these constructs are much more succinct than a full `if .. else` construct, but they are less semantically clear, hence the trade-off. Personally, I think it's fine to use the ternary operator in simple conditionals like this, but if it gets any more complicated then you should always use a full `if .. else` statement.

### Plugins / libraries

For example, in C#:

``` csharp
var brownFish;

foreach (var fish in fishes) {
	if (fish.colour == "brown") {
		brownFish = fish;
		break;
	}
}
```

Can be simplified with the Linq library:

``` csharp
using System.Linq;

var brownFish = fishes.First(fish => fish.colour == "brown");
```

The latter is clearly simpler, and hopefully not too difficult to understand, but its does require:

1. Knowledge of the Linq library
2. An understanding of lambda expressions work

I think that in this case the Linq solution is so much simpler and quite expressive enough that it should definitely be preferred - and hopefully if another developer doesn't know about Linq, it will be quite easy for them to pick up, and will expand their knowledge.

Single-use variables
---

While the following variable is pointless:

``` javascript
var arrayLength = myArray.length;

for (var arrayIterator; arrayIterator < arrayLength; arrayIterator++) { ... }
```

There are some cases where variables can be used to add useful semantic meaning:

``` javascript
var slideshowContainer = jQuery('main>.show');

slideshowContainer.startSlideshow();
```
