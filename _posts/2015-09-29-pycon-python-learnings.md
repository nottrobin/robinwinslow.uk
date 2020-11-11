---
title: Python learnings from PyCon
date: 2015-09-29 00:00:00 Z
tags:
- dev
- personal
- canonical
description: Interesting technical talks I heard at my first PyCon.
image_url: https://assets.ubuntu.com/v1/f3f649f4-Python+learnings+from+PyCon.jpg?h=160
layout: post
---

(Also published [on Canonical's design team blog][c0d53c6a])

The weekend before last, I went to [PyCon UK 2015][0783455a].

I already wrote about [the keynotes][f3697c15], which were more abstract. Here
I'm going to talk about the other talks I saw, which were generally more
technical or at least had more to do with Python.

## Summary

The talks I saw covered a whole range of topics - from testing through
documentation and ways to achieve simplicity to leadership. Here are some key
take-aways:

- [Technical leaders should][d3489c6e] take every opportunity practice various leadership styles
- Instead of answering questions about how to use software directly, [try pair documenting][1da5fc47]
- Ask users for as little of their data as possible, and be [permissive in your validation][2028d973]
- [Hypothesis is a useful library][8108d132] for generating test cases - keep it in mind
- "[Simplicity is about defaults][073d09b1]" - make the interfaces for your software as simple as possible
- [It's worthwhile][c156c3ca] practicing humility and patience in technical discussions
- [FIDO's U2F and UAF standards][24c62219] are just starting to gain support - keep an eye on them
- Python [has some good tools][145bb3cd] for managing data

## The talks

Following are slightly more in-depth summaries of the talks I thought
were interesting.

### Friday

#### 15:30: [Leadership of Technical Teams][254ea0dd] - Owen Campbell

There were two key points I took away from this talk. The first was Owen's
suggestion that leaders should take every opportunity to practice leading.
Find opportunities in your personal life to lead teams of all sorts.

The second point was more complex. He suggested that all leaders exist on two
spectra:

- Amount of control: *hand-off* to *dictatorial*
- Knowledge of the field: *novice* to *expert*

The less you know about a field the more hands-off you should
be. And conversely, if you're the only one who knows what you're talking about,
you should probably be more of a dictator.

Although he cautioned that people tend to mis-estimate their ability, and
particularly when it comes to process (e.g. agile), people think they know
more than they do. No-one is really an expert on process.

He suggested that leading technical teams is particularly challenging because
you slide up and down the knowledge scale on a minute-to-minute basis sometimes,
so you have to learn to be authoritative one moment and then permissive the
next, as appropriate.

#### 17:00: [Document all the things][35097b5d] - Kristian Glass

Kristian spoke about the importance, and difficulty, of good documentation.
Here are some particular points he made:

- Document *why* a step is necessary, as well as *what* it is
- Remember that error messages are documentation
- Try [*pair documentation*][d4cc6c0a] - novice sitting with expert
- Checklists are great
- Stop answering questions face-to-face. Always write it down instead.
- Github pages are better than wikis (PRs, better tracking)

One of Kristian's main points was that it goes against the grain to write
documentation, 'cos the person with the knowledge can't see why it's important,
and the novice can't write the documentation.

He suggested pair documentation as a solution, which sounds like a good idea,
but I was also wondering if a StackOverflow model might work, where users
submit questions, and the team treat them like bugs - need to stay on top of
answering them. This answer base would then become the documentation.

### Saturday

#### 11:00: [Asking About Gender - the Whats, Whys and Hows][0d841cba] - Claire Gowler

Claire spoke about how so many online forms expect people to be either
simply "male" or "female", when the truth can be much more complicated.

My main takeaway from this was the basic point that forms very often ask for
much more information than they need, and make too many assumptions about their
users. When it comes to asking someone's name, try radically reducing the
complexity by just having one text field called "name". Or better yet, don't
even ask their name if you don't need it.

I think this feeds into the whole field of simplicity very nicely. A very many
apps try to do much more than they need to, and ask for much more information
than they need. Thinking about how little you know about your user can help
you realise what you actually don't need to know about your user.

#### 11:30: [Finding more bugs with less work][88b14d3d] - David R. MacIver

David MacIver is the author of the [Hypothesis testing library][7b8a0da3].

> Hypothesis is a Python library for creating unit tests which are simpler to write and more powerful when run, finding edge cases in your code you wouldn’t have thought to look for. It is stable, powerful and easy to add to any existing test suite.

When we write tests normally, we choose the input cases, and we normally do this
and we often end up being really kind to our tests. E.g.:

``` python
def test_average():
  assert my_average([2, 4]) == 3
```

What Hypothesis does it help us test with a much wider and more challenging
range of values. E.g.:

``` python
from hypothesis.strategies import lists, floats

@given(lists(floats()))
def test_average(float_list):
  ave = reduce(lambda x, y: x + y, float_list) / len(float_list)
  assert average(float_list) == ave
```

There are many cases where Hypothesis won't be much use, but it's certainly
good to have in your toolkit.

### Sunday

#### 10:00: [Simplicity Is A Feature][1fb0f649] - Cory Benfield

Cory presented simplicity as the opposite of complexity - that is, the fewer
options something gives you, the more simple and straightforward it is.

> "Simplicity is about defaults"

To present as simple an interface as possible, the important thing is to have
many sensible defaults as possible, so the user has to make hardly any choices.

Cory was heavily involved in the [Python Requests library][7b950f1f], and presented it as
an example of how to achieve apparent simplicity in a complex tool.

> "Simple things should be simple, complex things should be possible"

He suggested thinking of an "onion model", where your application has layers,
so everything is customisable at one of the layers, but the outermost layer
is as simple as possible. He suggested that 3 layers is a good number:

- Layer 1: Low-level - everything is customisable, even things that are just
  for weird edge-cases.
- Layer 2: Features - a nicer, but still customisable interface for all the core
  features.
- Layer 3: Simplicity - hardly any mandatory options, sensible defaults
  - People should always find this first
  - Support 80% of users 80% of the time
  - In the face of ambiguity do the right thing

He also mentioned that he likes [README driven development][8b933d99], which seems like
is an interesting approach.

#### 11:00: [How (not) to argue - a recipe for more productive tech conversations][303ec758] - Harry Percival

I think this one could be particularly useful for me.

Harry spoke about how many people (including him) have a very strong need to
be right. Especially men. Especially those who went to boarding school.
And software development tends to be full of these people.

Collaboration is particularly important in open source, and strongly
disagreeing with people rarely leads to consensus, in fact it's more likely to
achieve the opposite. So it's important that we learn how to get along.

He suggests various strategies to try out, for getting along with people better:

- Try simply giving in, do it someone else's way once in a while (hard to do graciously)
- Socratic dialogue: Ask someone to explain their solution to you in simple terms
- Dogfooding - try out your idea before arguing for its strength
- Bide your time: Wait for the moment to see how it goes
- Expose yourself to other cultures, where arguments are less acceptable

All of this comes down to stepping back, waiting and exercising humility. All
of which are easier said than done, but all of which are very valuable if I
could only manage it.

#### 11:30: [FIDO - The dog ate my password][87848f51] - Alex Willmer

After covering fairly common ground of how and why passwords suck, Alex
introduced the [FIDO alliance][b0d55eaa].

The FIDO alliance's goal is to standardise authentication methods and hopefully
replace passwords. They have created two standards for device-based
authentication to try to replace passwords:

- UAF: First-factor passwordless biometric authentication
- U2F: Second-factor device authentication

Browsers are [just starting to support U2F][3fe25e7b], whereas support for
UAF is farther off. Keep an eye out.

#### 14:30: [Data Visualisation with Python and Javascript - crafting a data-visualisation for the web][cce07936] - Kyran Dale

Kyran demoed using Scrapy and Pandas to retrieve the Nobel laureatte data from
Wikipedia, using Flask to serve it as a RESTful API, and then using D3 to create
an interactive browser-based visualisation.

  [3fe25e7b]: http://caniuse.com/#search=u2f "Can I Use FIDO U2F API ?"
  [b0d55eaa]: https://fidoalliance.org/about/overview/ "About The FIDO Alliance"
  [7b950f1f]: http://www.python-requests.org/en/latest/ "Requests: HTTP for Humans"
  [8b933d99]: http://tom.preston-werner.com/2010/08/23/readme-driven-development.html "Tom Preston-Werner: Readme Driven Development"
  [87848f51]: http://www.pyconuk.org/talks/fido-the-dog-ate-my-password/ "PyCon UK: FIDO - The dog ate my password"
  [303ec758]: http://www.pyconuk.org/talks/how-not-to-argue-a-recipe-for-more-productive-tech-conversations/ "PyCon UK: How (not) to argue - a recipe for more productive tech conversations"
  [51fb0123]: http://www.pyconuk.org/talks/ship-data-science-products/ "PyCon U: Ship Data Science Products!"
  [1fb0f649]: http://www.pyconuk.org/talks/simplicity-is-a-feature/ "PyCon UK: Simplicity Is A Feature"
  [88b14d3d]: http://www.pyconuk.org/talks/finding-more-bugs-with-less-work/ "PyCon UK: Finding more bugs with less work"
  [0d841cba]: http://www.pyconuk.org/talks/asking-about-gender-the-whats-whys-and-hows/ "PyCon UK: Asking About Gender - the Whats, Whys and Hows"
  [254ea0dd]: http://www.pyconuk.org/talks/leadership-of-technical-teams/ "PyCon UK: Leadership of Technical Teams"
  [0783455a]: http://www.pyconuk.org/schedule/flat/ "PyCon UK 2015 schedule"
  [f3697c15]: /2015/09/24/pycon-friendly-inspiring/ "Keynotes from my first PyCon - friendly and inspiring"
  [7b8a0da3]: https://github.com/DRMacIver/hypothesis "Hypothesis is a library for testing your Python code against a much larger range of examples than you would ever want to write by hand."
  [35097b5d]: http://www.pyconuk.org/talks/document-all-the-things/ "PyCon UK: Document all the things"
  [cce07936]: http://www.pyconuk.org/talks/data-visualisation-with-python-and-javascript-crafting-a-data-visualisation-toolchain-for-the-web/ "PyCon UK: Data Visualisation with Python and Javascript - crafting a data-visualisation for the web"
  [d4cc6c0a]: http://brodzinski.com/2011/04/pair-document-writing.html "Pair Document Writing"
  [d3489c6e]: #15-30-leadership-of-technical-teams-owen-campbell "Leadership of Technical Teams - Owen Campbell"
  [1da5fc47]: #17-00-document-all-the-things-kristian-glass "Document all the things - Kristian Glass"
  [2028d973]: #11-00-asking-about-gender-the-whats-whys-and-hows-claire-gowler "Asking About Gender - the Whats, Whys and Hows - Claire Gowler"
  [8108d132]: #11-30-finding-more-bugs-with-less-work-david-r-maciver "Finding more bugs with less work - David R. MacIver"
  [073d09b1]: #10-00-simplicity-is-a-feature-cory-benfield "Simplicity Is A Feature - Cory Benfield"
  [c156c3ca]: #11-00-how-not-to-argue-a-recipe-for-more-productive-tech-conversations-harry-percival "How (not) to argue - a recipe for more productive tech conversations - Harry Percival"
  [24c62219]: #11-30-fido-the-dog-ate-my-password-alex-willmer "FIDO - The dog ate my password - Alex Willmer"
  [145bb3cd]: #14-30-data-visualisation-with-python-and-javascript-crafting-a-data-visualisation-for-the-web-kyran-dale "Data Visualisation with Python and Javascript - crafting a data-visualisation for the web - Kyran Dale"
  [c0d53c6a]: http://design.canonical.com/2015/10/python-learnings-from-pycon/ "design.canonical.com: Python learnings from PyCon"
