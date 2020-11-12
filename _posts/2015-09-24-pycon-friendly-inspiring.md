---
title: Keynotes from my first PyCon - friendly and inspiring
date: 2015-09-24 00:00:00 Z
tags:
- personal
- dev
- politics
- canonical
description: A report on my experience of the keynote speeches at my first PyCon.
image_url: https://assets.ubuntu.com/v1/ba50be85-pycon+uk+crown.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

(Also published [on Canonical's design team blog][75548106])

Last weekend I went to my first [Pycon][0783455a], my [second conference
in a fortnight][simone-dconstruct].

The conference runs from
Friday to Monday, with 3 days of talks followed by one day of "sprints", which
is basically a hack day.

PyCon has a [code of conduct][37f3ad11] to discourage any form of othering:

> Happily, PyCon UK is a diverse community who maintain a reputation as a
> friendly, welcoming and dynamic group.
>
> We trust that attendees will treat each other in a way that reflects the
> widely held view that diversity and friendliness are strengths of our
> community to be celebrated and fostered.

And for me, the conference lived up to this, with a very friendly feel, and
a lot of diversity in its attendants. The friendly and informal atmosphere was
impressive for such a large event with more than 450 people.

Unfortunately, the Monday sprint day was cut short by the discovery of an
[unexploded bomb][500907c3].

## Many keynotes, without much Python

There were a lot of "keynote" talks, with 2 on Friday, and one each on
Saturday and Sunday. And interestingly none of them were really about Python,
instead covering future technology, space travel and the psychology of power
and impostor syndrome.

But of course there were plenty of Python talks throughout the rest of the day -
you can read about them on [my other post][0c34ba81].
And I think it was a good decision to have more abstract keynotes. It shows that
the Python community really is more of a general community than just a special
interest group.

### Van Lindberg on data economics, Marx and the Internet of Things

In [the opening keynote][1b264317] on Friday morning, the [PSF][3ac3cacb]
chairman showed that total computing power
[is almost doubling every year][3acd7e47], and that by 2020, the total
processing power in portable devices [will exceed that in PCs][05e278ba] and
servers.

He then used the fact that data can't travel faster than
[11.8 inches per nanosecond][a3bceee7] to argue that we will see a fundamental
shift in the economics of data processing.

The big-data models of [today's tech giants][838bc580] will be challenged as it
starts to be quicker and make more economic sense to process data at source,
rather than transfer it to distant servers to be processed. Centralised servers
will be relegated to mere aggregators of pre-processed data.

He [likened this to Marx][f25f3168] seizing the [means of production][7c154126]
in a movement which will empower users, as our [portable Things][3af17b2f]
start to hold the real information, and choose who to share it with.

I really hope he's right, and that the centralised data companies are
doomed to fail to be replaced by [the Internet of Autonomous Things][1aadf26b],
because the world of centralised data is not an equal world.

> Does Python have a future on small processors? Isn't it too inefficient?

In a world where all the interesting software is running on light-weight
portable devices, processing efficiency becomes important once again. Van
[used this to argue that][0c6a8560] efforts to run Python effectively on
low-powered devices, like [MicroPython][e97dbb7c], will be essential for Python
as a language to survive.

### Daniele Procida: All I really want is power

The [second keynote][bfaf6e80] was just after lunch on Friday,
[Daniele Procida][f81da4dc], organiser of [DjangoCon Europe][0e123baa] openly
admitted that what he really wanted out of life was power. He put
forward the somewhat controversial idea that power and usefulness are the same
thing, and that ideas without power are useless.

He made the very good point that power only comes to those who ask for it, or
fight for it. And that if we want power not to be abused, we really need to
talk about it a whole lot more, even though it makes people uncomfortable
(try asking someone their salary).
We should acknowledge who has the power, and what power we have, and watch
where the power goes.

He suggested that, while in politics or industry, power is very much a
[rivalled good][55917ec2], in open source it is entirely an
[unrivalled good][e96ba3ee]. The way you grab power in the open source
community is by doing good for the community, by helping out. And so by
weilding power you are actually increasing power for those around you.

I don't agree with him on this final point. I think power can be and is hoarded
and abused in the open source community as well. A lot of people use their power
in the community to edge out others, or make others feel small, or to
soak up influence through talks and presentations and then exert their will
over the will of others. I am certainly somewhat guilty of this. Which is why
we should definitely watch the power, especially our own power, to see what
effect it's having.

The takeaway maxim from this for me is that we should always make every effort
to *share* power, as opposed to jealously guarding it. It's not that sharing
power in the open source community is inevitable or necessarily comes naturally,
but at least in the open source community sharing power genuinely can help you
gain respect, where I fear the same isn't so true of politics or industry.

### Dr Simon Sheridan: Landing on a comet: From planning to reality

Simon Sheridan was an incredibly most humble and unassuming man, given his
towering achievements. He is a world-class space scientist who was part of the
European Space Agency team who helped to land [Rosetta][8af8bc3a] on comet 67P.

Most of what he mentioned was basically covered in [the news][f101f1bd], but it
was wonderful to hear it from his perspective.

### Naomi Ceder: Confessions of a True Impostor

When, a short way into [her Sunday morning keynote][9c9e9a3e],
Naomi Ceder [asked the room][92ee7b0b]:

> How many of you would say that you have in some way or another suffered from
> [imposter syndrome][1594e6aa] along with me?

Almost everybody put their hands up. This is why I think this was such an
important talk.

She didn't talk about this per se, but contributing to the open source community
is hard. No-one talks about it much, but I certainly feel there's a lot of
pressure. Because of its very nature, your contributions will be open, to be
seen by anyone, to be criticised by anyone. And let's face it, your
contributions are never going to be perfect. And the rules of the game aren't
written down anywhere, so the chance of being ridiculed seem pretty high. Open
source may be a benevolent idea, but it's damned scary to take part in.

I believe this is why [less than 2%][9568e5c5] of open source contributors are
female, compared with more like 25-30% women in software development in general.
And, as with impostor syndrome, the same trend is true
of [other marginalised groups][cadc7563].
It's not surprising to me that people who are
used to being criticised and discriminated against wouldn't subject
themselves to that willingly.

And, as Naomi's question showed, it is not just marginalised people who
feel this pressure, it's all of us. And it's a problem. As we know,
[confidence is no indicator of actual ability][4b195f87], meaning that many
many talented people may be too scared to contribute to open source.

As Naomi [pointed out][b9f66008], impostor syndrome is a socially created
condition - when people are expected to do badly, [they do badly][aa1d1a6a].
In fact I completely agree with [her suggestion][b2404f29] that the
[existing Wikipedia definition of impostor syndrome][9b221b02] (at the time
of writing) could be more sensitively phrased to define it as a
"social condition" rather than a "psychological phenomenon", as well as
avoiding singling out women.

While Naomi chose to focus in her talk on how we personally can copy try
to mitigate feelings of being an impostor, I think the really important message
here is one for the community. It's not our fault that open source is scary,
that's just the nature of openness. But we have to make it more welcoming.
The success of the open source movement really does depend on it being
diverse and accepting.

What I think is really interesting is that stereotype threat
[can be mitigated][1abc06b5] by reminding people of their values, of what's
important to them. And this is what I hope will save open source. The more we
express our principles and passion for open source, the more we express our
values, the easier it is to counter negative feelings, to be welcoming,
to stop feeling like impostors.

## A great conference

Overall, the conference was exhausting, but I'm very grateful that I got to
attend. It was inspiring and informative, and a great example of how to
maintain a great community.

If you want you can now go and [read about the other talks][0c34ba81].

  [aa1d1a6a]: https://en.wikipedia.org/wiki/Stereotype_threat "Wikipedia: Steriotype threat"
  [1594e6aa]: https://en.wikipedia.org/wiki/Impostor_syndrome "Wikipedia: Imposter syndrome"
  [f25f3168]: https://youtu.be/Kj3z4ehMxqY?t=33m35s "Returning to Marx"
  [e97dbb7c]: https://micropython.org/ "MicroPython: Python for microcontrollers"
  [3af17b2f]: https://en.wikipedia.org/wiki/Internet_of_Things "Wikipedia: Internet of Things"
  [0c6a8560]: https://youtu.be/Kj3z4ehMxqY?t=32m40s "Importance of Micropython"
  [3acd7e47]: https://youtu.be/Kj3z4ehMxqY?t=13m38s "Manufactured Computer Power"
  [05e278ba]: https://youtu.be/Kj3z4ehMxqY?t=15m51s "Extrapolated PC power"
  [3ac3cacb]: https://www.python.org/psf/ "Python Software Foundation"
  [1aadf26b]: http://www.locusmag.com/Perspectives/2015/09/cory-doctorow-what-if-people-were-sensors-not-things-to-be-sensed/ "Cory Doctorow: What if people were sensors, not things to be sensed?"
  [0783455a]: http://www.pyconuk.org/schedule/flat/ "PyCon UK 2015 schedule"
  [37f3ad11]: http://www.pyconuk.org/codeofconduct/ "PyCon UK code of conduct"
  [simone-dconstruct]: https://robinwinslow.uk/2015/09/12/simone-dconstruct-ramble/ "My blog about Nina Simone and dConstruct"
  [838bc580]: http://www.wired.com/2010/11/facebook-google-showdown/ "The big data battle"
  [a3bceee7]: https://www.youtube.com/watch?v=JEpsKnWZrJ8 "Admiral Grace Hopper: Nanonsecond"
  [1b264317]: https://www.youtube.com/watch?v=Kj3z4ehMxqY "PYCON UK 2015: Keynote, Van Lindberg, PSF Chair"
  [7c154126]: https://en.wikipedia.org/wiki/Means_of_production "Wikipedia: Means of production"
  [0e123baa]: http://2015.djangocon.eu/ "DjangoCon Europe 2015"
  [f81da4dc]: https://twitter.com/evildmp "@evildmp: Daniele Procida on Twitter"
  [bfaf6e80]: https://www.youtube.com/watch?v=kntVob0GhyE "Daniele Procida: All I really want is power"
  [55917ec2]: https://en.wikipedia.org/wiki/Rivalry_(economics) "Wikipedia: Rivalry (economics)"
  [e96ba3ee]: https://en.wikipedia.org/wiki/Public_good "Wikipedia: Public good"
  [8af8bc3a]: http://www.esa.int/Our_Activities/Space_Science/Rosetta "ESA: Rosetta"
  [f101f1bd]: https://news.google.com/news/section?q=rosetta "Google news: Rosetta"
  [500907c3]: http://www.coventrytelegraph.net/news/coventry-news/video-pictures-huge-world-war-10118277 "Huge world war 2 bomb in Coventry"
  [9568e5c5]: http://www.flosspols.org/deliverables/FLOSSPOLS-D16-Gender_Integrated_Report_of_Findings.pdf "FLOSSPOLS: Gender: Integrated Report of Findings"
  [cadc7563]: http://thevarguy.com/open-source-application-software-companies/072015/where-are-women-and-minority-open-source-programmers "Where are the women and minority open source programmers?"
  [9c9e9a3e]: https://www.youtube.com/watch?v=4KErxatqBcs "PYCON UK 2015: Keynote: Confessions of a True Impostor"
  [92ee7b0b]: https://youtu.be/4KErxatqBcs?t=5m40s "How many of you are imposters?"
  [4b195f87]: https://en.wikipedia.org/wiki/Dunning%E2%80%93Kruger_effect "Wikipedia: Dunning Kruger effect"
  [b9f66008]: https://youtu.be/4KErxatqBcs?t=24m07s "Steriotype threat"
  [9b221b02]: https://en.wikipedia.org/w/index.php?title=Impostor_syndrome&oldid=681534618 "Wikipedia: Imposter syndrome (at 23:00 BST, 2015-09-24)"
  [b2404f29]: https://youtu.be/4KErxatqBcs?t=14m40s "Let's go back to the Wikipedia definition"
  [1abc06b5]: https://en.wikipedia.org/wiki/Stereotype_threat#Mitigation "Wikipedia: Stereotype threat - mitigation"
  [0c34ba81]: /2015/09/29/pycon-python-learnings/ "Python learnings from PyCon"
  [75548106]: http://design.canonical.com/2015/10/keynotes-from-my-first-pycon-friendly-and-inspiring/ "design.canonical.com: Keynotes from my first PyCon – friendly and inspiring"