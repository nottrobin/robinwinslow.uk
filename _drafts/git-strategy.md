---
title: 'Git strategy'
---

Workflow
===

Git branches are extremely easy and cheap to create and merge. This is a powerful tool for managing a code-base, but it can easily get messy if you're not careful. Therefore we need a branching strategy:

As we have a small team, a centralised workflow is probably best for our team, roughly as illustrated in the small private team example.

Branching
---

I think we should follow Nvie's branching model essential reading (Session Digital also use this strategy) with one modification:
Instead of one `develop` branch, we should have one for each environment - e.g. `dev`, `stage` etc.

### Important points

- Branch as often as possible. You should never be working directory on one of the infinite branches, always on a `feature-` or `hotfix-` branch.
- `feature-` branches should in most cases be linked to exactly one assembla ticket. The only exception to this would be if you are working on a personal experiment or proof-of-concept that doesn't link to an existing deliverable.

### Commit naming

Name commits with the ticket number: "Re #40: Tidy: Remove backup files"

As mentioned in the Git book, commits should ideally use the present imperative tense.

We could do with defining some tags for standard actions in commit messages:

- Format: Reformatted code but made no other changes - e.g. "Re #40: Format - Normalise to CRLF endings"
- Tidy: Actions to tidy up the repository - e.g. "Re #40: Tidy - Remove backup files"
- Config: Changed to web.config or app.config - e.g. "Re #40: Config - update DB connection string"
- Ignore: Updates to the `.gitignore` file - e.g. "Re #'40: Ignore - No longer include .orig files in repository"
- Attributes: Updates to the `.gitattributes` file - e.g. "Re: #40: Attributes: Git do nothing with line endings"

An example of the development process
---

``` bash
$ # “I want to work on ticket 456”
$ git checkout master # we will create the new branch from master
$ git checkout –b ticket-456-my-new-feature # create and switch to my new branch
$ # do some work
$ git commit –am ‘did something’
$ git commit –am ‘did something else’
$ # Finished, ready for staging
$ git checkout staging # The branch we want to merge into – staging
$ git pull
$ git merge ticket-456-my-new-feature –m ‘Re #456 – merging my new feature into staging’
$ git push
$ # Release to staging
$ # Get UAT sign-off – now we want to release
$ git checkout master # The branch we want to merge into – master
$ git pull
$ git merge ticket-456-my-new-feature –m ‘Re #456 – merging my new feature into master’
$ git push
$ # Go release onto production
```

Line endings
---

Git is capable of managing line endings. If you let Git manage line-endings it will:

- Store files in the repository with LF line endings
- Change line endings to LF when you checkout on a Unix environment
- Change line endings to CRLF when you checkout on a Windows environment

However so far this has caused me all sorts of problems. Certain files in Umbraco need to have LF line endings, and Visual Studio will always save others with CRLF endings.

So I decree that we should turn off all line endings management in Git - and just be very careful with line-ending management.
You can do this for your local Git installation as follows:

``` bash
$ git config --global autocrlf = false
Or you can override local settings for a repository by creating a `.gitattributes` file at the project root and adding the following:
* -text
```
