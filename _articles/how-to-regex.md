---
date: 2021-02-17
layout: post
title: How the hell do I RegEx?
description: An introduction to the basics of RegEx, with appropriate warnings
---

In my team we  run "masterclasses" every couple of weeks, where someone in the team presents a topic to the rest of the team.

This article is basically the content of the class on regular expressions I gave recently.

It's an introduction to the basics of regular expressions. There [are](https://regular-expressions.mobi/quickstart.html?wlr=1) [many](https://regexone.com/) [like](https://www.aivosto.com/articles/regex.html) [it](https://medium.com/better-programming/introduction-to-regex-8c18abdd4f70), but this is mine.


# What is RegEx?

[Wikipedia](https://en.wikipedia.org/wiki/Regular_expression) defines regular expressions as:

> "a sequence of characters that define a search pattern"

They are available in basically every programming language, and you’ll probably most commonly encounter them used for string matches in conditionals that are too complicated for simple logical comparisons (like "or", "and", "in"). 

A couple of examples of RegEx to get started:

| `[ -~]` | Any ASCII character (ASCII characters fall between space and "~") |
| `^[a-z0-9_-]{3,15}$` | Usernames between 3 and 15 characters |


# When to use RegEx

Use RegEx with caution. The complexity of RegEx carries a cost.


## Avoid coding in RegEx if you can

> ‘Some people, when confronted with a problem, think "I know, I'll use regular expressions." [Now they have two problems](https://blog.codinghorror.com/regular-expressions-now-you-have-two-problems/).’ - Jamie Zawinski

In programming, only use RegEx as a last resort. Don’t solve important problems with RegEx.



*   [RegEx is expensive](https://www.loggly.com/blog/regexes-the-bad-better-best/) - RegEx is often the most CPU-intensive part of a program. And a non-matching RegEx can be even more expensive to check than a matching one.
*   [RegEx is greedy](https://github.com/canonical-web-and-design/ubuntu.com/issues/9028#issuecomment-760859952) - It’s extremely easy to match much more than intended, leading to bugs. We have multiple times had problems with RegExes being too greedy, causing issues in our sites.
*   [RegEx is opaque](https://blog.codinghorror.com/regular-expressions-now-you-have-two-problems/) - Even people who know RegEx well will take a while to pick apart a new RegEx string, and are still likely to make mistakes. This has a huge cost to project maintenance in the long run. (Check out this amazing [RegEx for RFC822 email addresses](https://blog.codinghorror.com/regex-use-vs-regex-abuse/))

Always try to be aware of all the language features at your disposal for operating on and checking strings, that could help you avoid regular expressions. [In Python](https://www.codecademy.com/learn/learn-python-3/modules/learn-python3-strings/cheatsheet), for example, the `in` keyword, the powerful `[]` indexing, and string methods like `contains` and `startswith` (which can be fed either strings of tuples for multiple values) can be combined very effectively.

Most importantly, RegExes should not be used for _parsing_ _strings_. You should instead use or write a [bespoke parser](https://medium.com/the-mighty-programmer/what-is-parsing-4012f997d265). For example, [you can't parse HTML with RegEx](https://stackoverflow.com/a/1732454) (in Python, use [BeautifulSoup](https://pypi.org/project/beautifulsoup4/); in JavaScript, use [the DOM](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction)).


## When to code in RegEx

Of course, there are times when RegEx can or should be used in programs:



*   When it already exist and you have to maintain it (although if you can remove it, you should)
*   String validation, where there's no other option
*   String manipulation (substitution), where there's no other option

If you are writing anything more than the most basic RegEx, any maintainers are unlikely to be able to understand your RegEx easily, so you might want to consider adding liberal comments. E.g. [this in Python](https://softwareengineering.stackexchange.com/questions/178355/commenting-regular-expressions):

``` python
>>> pattern = """
^                   # beginning of string
M{0,4}              # thousands - 0 to 4 M's
(CM|CD|D?C{0,3})    # hundreds - 900 (CM), 400 (CD), 0-300 (0 to 3 C's),
                    #            or 500-800 (D, followed by 0 to 3 C's)
(XC|XL|L?X{0,3})    # tens - 90 (XC), 40 (XL), 0-30 (0 to 3 X's),
                    #        or 50-80 (L, followed by 0 to 3 X's)
(IX|IV|V?I{0,3})    # ones - 9 (IX), 4 (IV), 0-3 (0 to 3 I's),
                    #        or 5-8 (V, followed by 0 to 3 I's)
$                   # end of string
"""
>>> re.search(pattern, 'M', re.VERBOSE) 
```

## Other great uses for RegEx

Regular expressions can be extremely powerful for quickly solving problems for yourself, where future maintenance is not a concern. E.g.:

*   [Grep](https://en.wikipedia.org/wiki/Grep) (or [Ripgrep](https://github.com/BurntSushi/ripgrep)), [Sed](https://en.wikipedia.org/wiki/Sed), [Less](https://en.wikipedia.org/wiki/Less_(Unix)) and other command line tools
*   In editors (e.g. [VSCode](https://docs.microsoft.com/en-us/visualstudio/ide/using-regular-expressions-in-visual-studio?view=vs-2019#capture-groups-and-replacement-patterns)), for quickly reformatting text

It's also worth taking advantage of opportunities to use RegEx in these ways to practice your RegEx skills. 

For example, I recently used the following RegEx substitution in VSCode to format a dump of text into a table format:


![RegEx replacement in VSCode](https://lh6.googleusercontent.com/dR5m7AyBayo8O9JFzjjfGlO-wdKSaIBxb_kxIfDGnJMGKmWI8Y2dDwmNAUlUjMlli6I5UtH3OheTGTmY9hEEluj6ieab68TbXG8oxk0QoSTV_SKQb1af95SXHoieMoOynVUqX44C)



# How to use RegEx?

Bear in mind that RegEx parsers come in a few varieties. Basically, [every language implements its own parser](https://en.m.wikipedia.org/wiki/Comparison_of_regular-expression_engines). However, Perl’s RegEx parser is the gold standard. If you have a choice, use [Perl Compatible Regular Expressions](https://www.pcre.org/).


## What they look like

The traditional way to write a regular expression is by surrounding it with slashes.


``` perl
/^he[l]{2}o\wworld$/
```

This is how they're written in Perl and JavaScript, and in many command-line tools like Less.

Many more modern languages (e.g. Python), however, have opted not to include a native RegEx type, and so regular expressions are simply written as strings:

``` python
r"^he[l]{2}o\wworld$"
```


## The most common special characters

| `.` | Matches any single character (except newlines, normally) |
| `\` | Escape a special character (e.g. `\.` matches a literal dot) |
| `?` | The preceding character may or may not be present (e.g. `/hell?o/` would match `hello` or `helo`) |
| `*` | Any number of the preceding character is allowed (e.g. `.*` will match any single-line string, including an empty string, and gets used a lot) |
| `+` | One or more of the preceding character (`.+` is the same as `.*` except that it won’t match an empty string) |
| `|` | "or", match the preceding section or the following section (e.g. `hello|mad` will match "hello" or "mad") |
| `()` | group a section together. This can be useful for conditionals (`(a|b)`), multipliers (`(hello)+`), or to create groups for substitutions (see below) |
| `{}` | Specify how many of the preceding character (e.g. `a{12}` matches 12 "a"s in a row) |
| `[]` | Match any character in this set. `-` defines ranges (e.g. `[a-z]` is any lowercase letter), `^` means "not" (e.g. `[^,]+` match any number of non-commas in a row) |
| `^` | Beginning of line |
| `$` | End of line |


## Character shortcuts

In most RegEx implementations, you can use backslash followed by a letter (`\x`) as a shortcut for a character set. Here’s a list of some common ones from [rexegg.com's RegEx cheat sheet](https://www.rexegg.com/regex-quickstart.html).


![RexEgg character table](https://lh5.googleusercontent.com/mLDT-nkK2WI62ovJy_t5GCadgA82pQ_W8FA_23Yvs0uPD0x4WPdq6mbgPj-GTHiePU5bLKiT7bStwgJzPq8boyreFekfcP21FFDVD9NDom1XXTPPAzw_2la0Fixbv6e2UPNlktPu)



## RegEx in conditionals

The simplest use-case for RegExes in programming is a string comparison. This looks different in different languages, e.g.:

``` perl
// Perl
if ( "hello world" =~ /^he[l]{2}o\sworld$/ ) {..}
```

``` javascript
// JavaScript
if( /^he[l]{2}o\sworld$/.test("hello world") ) {..}
```

``` python
# Python
Import re
If re.match(r"^he[l]{2}o\sworld$", "hello world"): ..
```

## RegEx in substitutions

You can also use RegEx to manipulate strings through substitution. In the following examples, "mad world" will be printed out:

``` perl
// Perl
$hw = "hello world"; $hw =~ s/^(he[l]{2}o)\s(world)$/mad \2/; print($hw)
```

``` javascript
// JavaScript
console.log("hello world".replace(/^(he[l]{2}o)\s(world)$/, "mad $2"))
```

``` python
# Python
Import re
print(re.replace(r"^(he[l]{2}o)\s(world)$", r"mad \2", "hello world"))
```

## Modifiers

You can alter how RegEx patterns behave based on a few [modifiers](https://www.rexegg.com/regex-modifiers.html). I’m just going to illustrate one here, which is the modifier to make RegEx case insensitive. In Perl, JavaScript and other more traditional RegEx contexts, the modifiers are added after the last `/`. More modern languages often user constants instead:

``` perl
// Perl
if ( "HeLlO wOrLd" =~ /^he[l]{2}o\sworld$/i ) {..}
```

``` javascript
// JavaScript
if( /^he[l]{2}o\sworld$/i.test("HeLlO wOrLd") ) {..}
```

``` python
# Python
Import re
If re.match(r"^he[l]{2}o\sworld$", "HeLlO wOrLd", flags=re.IGNORECASE): ..
```

## Lookahead and lookbehind

These are only supported in some implementations of RegEx, and give you the opportunity to match strings that precede or follow other strings, but without including the prefix or suffix in the match itself:

![RexEgg lookaround table](https://lh4.googleusercontent.com/WIc9KXTDsqV-j14f5aJwfDXPQTHjAG6ybL8RUR1d7cR-Px0gq4YpOBoPzI0e7Q5KzllNAB0AMw_3UU0UOT5gEWWawWDjlAwYEzhR6qnc6D20pEmoK4r759e3p0R-EFfjTYPwT5xE)


(Again, taken from [rexegg.com's RegEx cheat sheet](https://www.rexegg.com/regex-quickstart.html))


# Resources

That is all I have for now. If you want to learn more, there’s are a lot of useful resources out there:



*   [Rexegg.com](https://www.rexegg.com/) - Many great articles on most aspects of RegEx
*   [Regex101](https://regex101.com/) - A tester for your RegEx, offering a few different implementations
*   [iHateRegex](https://ihateregex.io/) - A collection of example RegEx patterns for matching some common types of strings (e.g. phone number, email address)
*   The official [Perl Compatible Regular Expressions documentation](https://www.pcre.org/current/doc/html/)