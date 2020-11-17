---
redirect_from: /2013/11/07/how-to-secure-your-site-against-the-nsa/
date: 2013-11-07
layout: post
title: "How to secure your site against the NSA and GCHQ"
description: "There has been some misinformation going around about the state of our cryptographic technology following certain revelations about the NSA. I'm here to clear that up."
tags:
  - politics
  - technology
  - nsa
  - canonical
---

In the last couple of months I've had a number of discussions with people who were under the impression that _encryption has been cracked_ by the NSA.

If you like, jump straight to [what you can do about it](#what-you-can-do).

## The story

The story started in September, in the Guardian:

> NSA and GCHQ unlock encryption used to protect emails, banking and medical records

<small>([Guardian - Revealed: how US and UK spy agencies defeat internet privacy and security][guardian-defeat-privacy], James Ball, Julian Borger and Glenn Greenwald, 5th September 2013)</small>

This came up again today, because [Sir Tim Berners-Lee](http://en.wikipedia.org/wiki/Tim_berners_lee) made a statement:

> In an interview with the Guardian, he expressed particular outrage that GCHQ and the NSA had weakened online security by cracking much of the online encryption on which hundreds of millions of users rely to guard data privacy.

<small>([Guardian - Tim Berners-Lee condemns spy agencies as heads face MPs][guardian-berners-lee], Ed Pilkington, 7th November 2013)</small>

And something very similar to this was stated in the Radio 4 news program I was listening to this morning.

## The worry

On the face of it this sounds like the NSA's geniuses have reverse-engineered some core cryptographic principles - e.g. worked out how to quickly deduce prime factors from a public key ([read an explanation of RSA][cryp-explained-prime-factors]).

This would be very serious. I was sceptical though, because I believe that if there were key vulnerabilities in public algorithms, the public would have found them long before the NSA. They don't have a monopoly on good mathematicians. This is, after all, why open-source code and public algorithms are inherently more secure.

## The truth

Helpfully, Massachusetts Institute of Technology published an article 4 days later clarifying what the NSA had likely achieved:

> New details of the NSA’s capabilities suggest encryption can still be trusted. But more effort is needed to fix problems with how it is used.

<small>([NSA Leak Leaves Crypto-Math Intact but Highlights Known Workarounds][mit-crypto-math], Tom Simonite, 9th September 2013)</small>

This shows that (still as far as we know) **the NSA have done nothing unprecedented**. They have, however, gone to huge lengths to exploit every known vulnerability in security systems, regardless of legality. Mostly, these vulnerabilities are with the end-point systems, not the cryptography itself.

### What the NSA and GCHQ have done

I've tried to list these in order of severity:

- Intercepted huge amounts of encrypted and unencrypted internet traffic
- [Used network taps][ind-network-taps] to get hold of Google and Yahoo's (and probably others') unencrypted private data as it's transferred between their servers
- Acquired private-keys wherever they can, presumably through traditional hacking methods like brute-forcing passwords, social engineering, or inside contacts.
- Built back doors into certain commercial encryption software products (most notably, [Microsoft](http://www.wired.co.uk/news/archive/2013-07/12/microsoft-nsa-collusion))
- Used brute-force attacks to find weaker (1024-bit) RSA private keys
- Used court orders to force companies to give up personal information

### A word about RSA brute-forcing

We have [known for a while][se-rsa-length] that 1024-bit RSA keys could feasibly be brute-forced by anyone with enough resources - and many assumed that the U.S security agencies would almost certainly be doing it. So for the more paranoid among us, this should be no surprise.

> “RSA 1024 is entirely too weak to be used anywhere with any confidence in its security” says Tom Ritter

However, MIT also claim that these weaker keys are:

> used by most websites that offer secure SSL connections

This surprises me, as I know that [GoDaddy](http://uk.godaddy.com/) at least won't sell you a certificate for a key shorter than 2048-bit - and I would assume other certificate vendors would follow suit. But maybe this is fairly recent.

However, even if "most websites" use RSA-1024, it _doesn't mean_ that the NSA is decrypting all of this encrypted traffic, because it still requires a huge amount of resources (and time) to do, and the sheer number of such keys being used will also be huge. This means the NSA can _only_ be decrypting data from _specifically targeted_ sites. They won't have decrypted all of it.

<span id="what-you-can-do"></span>

## What you can do

Now that we know this is going on, it only means that we should be more stringent about the security best-practices that already existed:

- Use only public, open-source, tried and tested programs and algorithms
- Use 2048-bit or longer RSA keys
- [Configure secure servers to prefer "perfect forward secrecy" cyphers][se-https-pfs]
- Avoid the mainstream service providers (Google, Yahoo, Microsoft) where you can
- Secure your end-points: disable your root login; use secure passwords; know who has access to your private keys

[se-rsa-length]: http://stackoverflow.com/questions/589834/what-rsa-key-length-should-i-use-for-my-ssl-certificates
[se-https-pfs]: http://crypto.stackexchange.com/questions/8933/how-can-i-use-ssl-tls-with-perfect-forward-secrecy
[cryp-explained-prime-factors]: http://www.informit.com/articles/article.aspx?p=102212&seqNum=4
[mit-crypto-math]: http://www.technologyreview.com/news/519171/nsa-leak-leaves-crypto-math-intact-but-highlights-known-workarounds/
[guardian-defeat-privacy]: http://www.theguardian.com/world/2013/sep/05/nsa-gchq-encryption-codes-security
[guardian-berners-lee]: http://www.theguardian.com/world/2013/nov/06/tim-berners-lee-encryption-spy-agencies
[ind-network-taps]: http://www.independent.co.uk/news/world/americas/nsa-hacked-google-and-yahoos-data-centre-links-snowden-documents-say-8913998.html
