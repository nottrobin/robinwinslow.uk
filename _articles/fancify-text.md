---
title: New fancify-text Python module
description: I made a module from from code I found on the  internets
date: 2022-08-10
tags: ["python", "cli", "showdev", "devjournal"]
---

I just made a new Python module and CLI tool called [fancify-text](https://pypi.org/project/fancify-text/) for transforming text into fancy unicode representations:

```
$ fancify-bold "hello world"
𝗵𝗲𝗹𝗹𝗼 𝘄𝗼𝗿𝗹𝗱
$ fancify-bolditalics "hello world"
𝙝𝙚𝙡𝙡𝙤 𝙬𝙤𝙧𝙡𝙙
$ fancify-upsidedown "hello world"
plɹoʍ ollǝɥ
```

I'm hoping to use it in an automatic tool for turning blog posts into twitter threads that I'm working on.

## I stole the code

I can't say I wrote it - I basically stole it [from @Secret-chest](https://github.com/Secret-chest/fancy-text), and repackaged their code. They did all the hard work of finding the appropriate unicode characters was done by them.

I don't know if they mind. There's no license on the code so I'm treating it as public domain, but I [contacted them](https://github.com/Secret-chest/fancy-text/issues/5) to ask if they want control of the module. They're welcome to it if they want.

I just made it into a class, wrote a lot of boilerplate code around it for different function names and CLI entrypoints. And now you can use it.

## Try it out

On the command-line:

``` bash
$ pip3 install fancify-text
$ fancify-script "hello world"
𝒽𝑒𝓁𝓁𝓅 𝓍𝓅𝓈𝓁𝒹
```

Or in Python:

``` python
In [1]: from fancify_text import blue

In [2]: print(blue("hello world"))
🇭 🇪 🇱 🇱 🇴    🇼 🇴 🇷 🇱 🇩 
```
