---
title: "JavaScript closures &#58; Passing an Object context to a callback function"
layout: post
description: "A useful application for JavaScript Closures - passing object context."
tags:
  - JavaScript
  - dev
  - front-end
---
 
This is the first really useful application for [JavaScript closures](https://developer.mozilla.org/en/JavaScript/Guide/Closures) that I've found.

<a id="problem"></a>
The problem
===

(You can [skip straight to the solution](#solution) if you want).

There are many situations when you might use a callback function. For example, to be run after an [XMLHttpRequest](https://developer.mozilla.org/en/XMLHttpRequest) (or AJAX call), or on adding an [event listener](https://developer.mozilla.org/en/DOM/element.addEventListener).

It is not uncommon to want to create a callback from within an Object instance, and to want all of the methods and properties of that object to be available to the callback function.

For example (you can try this example out in your browsers JS console if it has one):

``` javascript
var myOb = function(aString) {
	this.aString = aString;
	
	// Callback for timer
	this.callback = function() {
		// We can't use "this" because it is just the window object
		// But we can access an instance of the object through the global variable
		console.log(globalString);
	}
	
	// Attempt to make the object available to the callback by creating a global variable
	globalString = this.aString;
	
	// Call the callback function after 1 second
	window.setTimeout(this.callback, 1000);
}

var obInstance = new myOb('hello'); // Sets "globalString" to "hello"
var anotherObInstance = new myOb('world'); // Sets "globalString" to "world"
```

This outputs the following in my Chrome 11 console:

	world
	world

This is because the global variable "globalString" is initially set to "hello", but it gets immediately overridden with "world" when the second instance of the object is called. Therefore, by the time the callbacks fire (a second after the page loads) the variable is "world", so they both return "world". This could very well be a problem.

<a id="solution"></a>
The solution
===

The solution is to set the context (i.e. 'this') of the callback function `this.callback` to be the current object instance, so that the function will inherently have access to all the object's properties.

The logic for this is a little complex and I won't fully explain it here, but in short it uses a [closure](https://developer.mozilla.org/en/JavaScript/Guide/Closures) to capture the object instance in the `caller` variable, and then the [apply](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Function/apply) method to set the context of the function to be `caller`.

Here it is (once again feel free to try this in your browser's console):

``` javascript
var myOb = function(aString) {
	this.aString = aString;
	
	// Callback for timer
	this.callback = function() {
		// The arguement passed to this particular instance of myOb
		console.log(this.aString);
	}
	
	// Call the callback function after 1 second
	window.setTimeout((function(caller) { return function() { caller.callback.apply(caller, arguments); } })(this), 1000);
}

var obInstance = new myOb('hello');
var anotherObInstance = new myOb('world');
```

This should successfully output:

	hello
	world

Problem solved. 
