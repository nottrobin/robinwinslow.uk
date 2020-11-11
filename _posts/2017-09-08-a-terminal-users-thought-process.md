---
title: 'Command-line usability: A terminal user''s thought process'
date: 2017-09-08 00:00:00 Z
description: As a terminal user with a keen interest in usability, I explored my thought
  process when learning a new CLI tool, and made some basic UX recommendations.
image_url: https://assets.ubuntu.com/v1/74c7c7f7-cli.jpg?h=160
layout: post
---

I've been thinking about the usability of command-line terminals a lot recently.

Command-line interfaces remain mystifying to many people. Usability hobbyists seem as inclined to ask [why the terminal exists][why-cli], as how to optimise it. I've also had it suggested to me that the discipline of User Experience (UX) has little to offer the Command-Line Interface (CLI), because the habits of terminal users are too inherent or instinctive to be defined and optimised by usability experts.

As an experienced terminal user with a keen interest in usability, I disagree that usability has little to offer the CLI experience. I believe that the experience can be improved through the application of usability principles just as much as for more graphical domains.

## Steps to learn a new CLI tool

To help demystify the command-line experience, I'm going to lay out some of the patterns of thinking and behaviour that define my use of the CLI.

New CLI tools I've learned recently include [`snap`][snap], [`kubectl`][kube] and [`nghttp2`][nh2], and I've also [dabbled][runscript] in writing command-line tools myself.

Below I'll map out an example of the steps I might go through when discovering a new command-line tool, as a basis for exploring how these tools could be optimised for CLI users.

1. Install the tool
    - First, I might try `apt install {tool}` (or `brew install {tool}` on a mac)
    - If that fails, I'll probably search the internet for "Install {tool}" and hope to find the official documentation
2. Check it is installed, and if [tab-complete][tab] works
    - Type the first few characters of the command name (`sna` for `snap`) followed by `<tab> <tab>`, to see if the command name auto-completes, signifying that the system is aware of its existence
    - Hit space, and then `<tab> <tab>` again, to see if it shows me a list of available sub-commands, indicating that tab completion is set up correctly for the tool
3.  Try my first command
    - I'm probably following some documentation at this point, which will be telling me the first command to run (e.g. `snap install {something}`), so I'll try that out and expect prompt succinct feedback to show me that it's working
    - For basic tools, this may complete my initial interaction with the tool. For more complex tools like `kubectl` or `git` I may continue playing with it
4. Try to do something more complex
    - Now I'm likely no longer following a tutorial, instead I'm experimenting on my own, trying to discover more about the tool
    - If what I want to do seems complex, I'll straight away search the internet for how to do it
    - If it seems more simple, I'll start looking for a list of subcommands to achieve my goal
    - I start with `{tool} <tab> <tab>` to see if it gives me a list of subcommands, in case it will be obvious what to do next from that list
    - If that fails I'll try, in order, `{tool} <enter>`, `{tool} -h`, `{tool} --help`, `{tool} help` or `{tool} /?`
    - If none of those work then I'll try `man {tool}`, looking for a Unix manual entry
    - If that fails then I'll fall back to searching the internet again

## UX recommendations

Considering my own experience of CLI tools, I am reasonably confident the following recommendations make good general practice guidelines:

- Always implement a `--help` option on the main command and all subcommands, and if appropriate print out some help when no options are provided (`{tool} <enter>`)
- Provide both short- (e.g. `-h`) and long- (e.g. `--help`) form options, and make them guessable
- Carefully consider the naming of all subcommands and options, use familiar words where possible (e.g. `help`, `clean`, `create`)
- Be consistent with your naming - have a clear philosophy behind your use of subcommands vs options, verbs vs nouns etc.
- Provide helpful, readable output at all times - especially when there's an error (`npm` I'm looking at you)
- Use long-form options in documentation, to make commands more self-explanatory
- Make the tool easy to install with common software management systems ([snap][usnap], [apt][apt], [Homebrew][brew], or sometimes [NPM][npm] or [pip][pip])
- Provide [tab-completion][tab]. If it can't be installed with the tool, make it easy to install and document how to set it up in your installation guide
- Command outputs should use the appropriate [output streams (STDOUT and STDERR)][streams] and should be as user-friendly and succinct as possible, and ideally make use of [terminal colours][colour]

Some of these recommendations are easier to implement than others. Ideally every command should consider their subcommands and options carefully, and implement `--help`. But writing [auto-complete scripts][writeauto] is a significant undertaking.

Similarly, [packaging your tool as a snap][createsnap] is significantly easier than, for example, adding software to the [official Ubuntu software sources][aptofficial].

Although I believe all of the above to be good general advice, I would very much welcome research to highlight the relative importance of addressing each concern.

### Outstanding questions

There are a number of further questions for which the answers don't seem obvious to me, but I'd love to somehow find out the answers:

- Once users have learned the short-form options (e.g. `-h`) do they ever use the long-form (e.g. `--help`)?
- Do users prefer subcommands (`mytool create {something}`) or options (`mytool --create {something}`)?
- For multi-level commands, do users prefer `{tool} {object} {verb}` (e.g. `git remote add {remote_name}`), or `{tool} {verb} {object}` (e.g. `kubectl get pod {pod_name}`), or perhaps `{tool} {verb}-{object}` (e.g. `juju remove-application {app_name}`)?
- What patterns exist for formatting command output? What's the optimal length for users to read, and what types of formatting do users find easiest to understand?

If you know of either authoritative recommendations or existing research on these topics, please let me know in the comments below.

I'll try to write a more in-depth follow-up to this post when I've explored a bit further on some of these topics.

[aptofficial]: https://help.ubuntu.com/stable/ubuntu-help/addremove-sources.html "Add remove sources"
[createsnap]: https://snapcraft.io/docs/build-snaps/your-first-snap "Snapcraft: Build your first snap"
[writeauto]: https://askubuntu.com/questions/68175/how-to-create-script-with-auto-complete "AskUbuntu: How to create script with auto-complete?"
[streams]: https://en.wikipedia.org/wiki/Standard_streams "Wikipedia: Standard streams"
[why-cli]: https://ux.stackexchange.com/questions/101990/why-are-terminal-consoles-still-used "UX StackExchange: Why are terminal consoles still being used?"
[tab]: https://www.howtogeek.com/195207/use-tab-completion-to-type-commands-faster-on-any-operating-system/ "How To Geek: Use Tab Completion"
[snap]: https://snapcraft.io/docs/core/usage "Snapcraft: Use the snap command"
[usnap]: https://www.ubuntu.com/snappy "Ubuntu: A ‘snap’ is a universal Linux package"
[apt]: https://wiki.debian.org/Apt "Apt: Debian package manager"
[brew]: https://brew.sh/ "Homebrew: MacOS's missing package manager"
[npm]: https://www.npmjs.com/ "NPM: the package manager for javascript"
[pip]: https://en.wikipedia.org/wiki/Pip_(package_manager) "Wikipedia: pip (package manager)"
[kube]: https://kubernetes.io/docs/user-guide/kubectl-overview/ "Kubernetes: Kubectl overview"
[nh2]: https://nghttp2.org/ "Nghttp2: HTTP/2 C Library"
[colour]: https://unix.stackexchange.com/questions/148/colorizing-your-terminal-and-shell-environment "Unix StackExchange: Colorizing your terminal and shell environment?"
[runscript]: https://github.com/canonical-webteam/practices/blob/master/local-development/the-run-script.md "Canonical webteam practices: The ./run script interface"
[notusable]: http://gandre.ws/blog/blog/2015/04/07/why-the-command-line-is-not-usable/comment-page-1/
[patterns]: https://stackoverflow.com/questions/762724/cli-patterns-antipatterns-for-usability
[alive]: https://uxmag.com/articles/command-lines-alive-kicking
[programming]: http://blog.opalang.org/2012/03/programming-tools-ux-experience-how-we.html
[design]: https://trevorsullivan.net/2016/07/11/designing-command-line-tools/
[hacker]: https://news.ycombinator.com/item?id=3771000
[cliux]: https://ayende.com/blog/177762/command-line-usability
[skinning]: http://www.mi.fu-berlin.de/wiki/pub/SE/ThesisCommandLine/Skinning_the_Command_Line.pdf
