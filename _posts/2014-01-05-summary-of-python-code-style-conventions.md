---
layout: post
title: "A summary of python code style conventions"
description: "Recently I've been learning Python. I just found out about PEP 8 and PEP 257, which are guidelines for how to write python code. To solidify them in my mind, I'm going to summarise them here."
tags:
    - back-end
    - dev
---

["PEP 8: Style Guide for Python Code"](http://www.python.org/dev/peps/pep-0008/) and ["PEP 257: Docstring Conventions"](http://www.python.org/dev/peps/pep-0257/) aren't exactly long, but they're also not easily skimmable.

As I've just started to learn python, I should make an effort to internalise these best-practice conventions. To help me do that, I'm going to summarise PEP 8 and 257 here, as a quick reference for myself and anyone else who might find it useful.

This is not quite an exhaustive summary: I have omitted the really obvious stuff, and in some cases I've picked one approach where PEP8 allows a few.

These standards can hopefully help in every coders' ongoing mission to write [readable and expressive code](/2013/11/22/expressive-coding/).

Indentation, line-length & code wrapping
===

- Always use *4 spaces* for indentation (don't use tabs)
- Write in ASCII in Python 2 and UTF-8 in Python 3
- Max line-length: 72 characters (especially in comments)
- Always indent wrapped code for readablility

``` python
# Good:
result = some_function_that_takes_arguments(
    'argument one,
    'argument two',
    'argument three'
)

# Bad:
result = some_function_that_takes_arguments(
'argument one,
'argument two', 'argument three')
result2 = some_function_that_takes_arguments('argument one', 'argument two', 'argument three')
```

Imports
===

- Don't use wildcards
- Try to use absolute imports over relative ones
- When using relative imports, be explicit (with .)
- Don't import multiple packages per line

``` python
# Good:
import os
import sys
from mypkg.sibling import example
from subprocess import Popen, PIPE # Acceptable
from .sibling import example # Acceptable

# Bad:
import os, sys # multiple packages
import sibling # local module without "."
from mypkg import * # wildcards
```

Whitespace and newlines
===

- 2 blank lines before top-level function and class definitions
- 1 blank line before class method definitions
- Use blank lines in functions sparingly
- Avoid extraneous whitespace
- Don't use whitespace to line  up assignment operators (`=`, `:`)
- Spaces around `=` for assignment
- No spaces around `=` for default parameter values
- Spaces around mathematical operators, but group them sensibly
- Multiple statements on the same line are discouraged

``` python
# Good:
spam(ham[1], {eggs: 2})
if x == 4:
    print x, y
    x, y = y, x
dict['key'] = list[index]
y = 2
long_variable = 3
hypot2 = x*x + y*y
c = (a+b) * (a-b)
def complex(real, imag=0.0):
    return magic(r=real, i=imag)
do_one()
do_two()

# Bad
spam ( ham[ 1 ], { eggs: 2 } ) # spaces inside brackets
if x == 4 : print x , y ; x , y = y , x # inline statements, space before commas
dict ['key'] = list [index] # space before dictionary key
y             = 2 # Using spaces to line up assignment operators
long_variable = 3
hypot2 = x * x + y * y # Too much space around operators
c = (a + b) * (a - b) # Too much space around operators
def complex(real, imag = 0.0):
    return magic(r = real, i = imag) # Spaces in default values
```

Comments
===

- Keep comments up to date - incorrect comments are worse than no comments
- Write in whole sentences
- Try to write in ["Strunk & White"](http://en.wikipedia.org/wiki/The_elements_of_style) English
- Use inline comments sparingly & avoid obvious comments
- Each line of block comments should start with "# "
- Paragraphs in block comments should be separated by a line with a single "#"
- All public functions, classes and methods should have docstrings
- Docstrings should start and end with `"""`
- Docstring one-liners can be all on the same line
- In docstrings, list each argument on a separate line
- Docstrings should have a blank line before the final `"""`

``` python
def my_function():
    """ A one-line docstring """

def my_other_function(parameter=False):
    """
    A multiline docstring.

    Keyword arguments:
    parameter -- an example parameter (default False) 

    """
```

Naming conventions
===

- Class names in `CapWords`
- Method, function and variables names in `lowercase_with_underscores`
- Private methods and properties start with `__double_underscore`
- "Protected" methods and properties start with `_single_underscore`
- If you need to use a reserved word, add a `_` to the end (e.g. `class_`)
- Always use `self` for the first argument to instance methods
- Always use `cls` for the first argument to class methods
- Never declare functions using `lambda` (`f = lambda x: 2*x`)

``` python
class MyClass:
    """ A purely illustrative class """
    
    __property = None
    
    def __init__(self, property_value):
        self.__property = property_value
    
    def get_property(self):
        """ A simple getter for "property" """
        
        return self.__property
    
    @classmethod
    def default(cls):
        instance = MyClass("default value")
        return instance
```
