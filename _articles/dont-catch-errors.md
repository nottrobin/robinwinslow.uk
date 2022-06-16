---
date: 2022-06-14T13:26:03+01:00
updated: 2022-06-14T13:26:03+01:00
title: Don't catch errors without a reason
description: Catching errors without thinking carefully about the user experience is an antipattern and a debugging nightmare.
---

Earlier this week, when working on [my blogging pipeline scripts](https://robinwinslow.uk/testing-my-github-action) I had to delve into [the Mailchimp Marketing API docs](https://mailchimp.com/developer/marketing/api/root/). Each of the endpoints there provides a snippet of the following form (example for Python):

``` python3
import mailchimp_marketing as MailchimpMarketing
from mailchimp_marketing.api_client import ApiClientError

try:
  client = MailchimpMarketing.Client()
  client.set_config({
    "api_key": "YOUR_API_KEY",
    "server": "YOUR_SERVER_PREFIX"
  })

  response = client.accountExports.list_account_exports()
  print(response)
except ApiClientError as error:
  print("Error: {}".format(error.text))
```

In this 14 line snippet, 4 lines and 1 module import are purely for catching an error and turning it into a print statement. To be charitable *maybe* this is to try to illustrate the existence of that error *in case* you might want to use it, but in practice everyone just copies the whole `try: .. except: ..` block verbatim, as we can see from [a quick search of GitHub](https://github.com/search?q=%22import+mailchimp_marketing%22&type=code).

This is a pattern I see everywhere. Developers think that if you don't catch every error you're being sloppy, an amateur. In fact, the opposite is true. Let's consider a few scenarios with the above example.

### The least damaging case

In the least damaging case, probably the most immediate case, this will be copied directly into a Python interpreter or a quick hacky script while the developer tests out the API library to get used to it. In this case the damage of converting that error into a print statement is only minor. The dev *just wrote* the code and shouldn't have too much trouble locating the error, we would hope. However, you're still throwing away:

- The information of what line the error happened on
- Information about the other files and functions the code passes through to get the error

A seasoned Python developer will know how to read an exception stack trace. This will be much more familiar to them than a custom printed line of text. And the list of functions the interpreter passed through in getting the error could very likely give the developer a hint as to where the problem originated.

### Catching individual errors in application code is much more harmful

Imagine instead that this happens inside a view function in Flask, a popular web microframework. Flask is pretty barebones, but one thing is comes with out of the box is error handling. If the application throws an error in development, it will helpfully print out the stack trace in the browser. If it happens in production, it will show a basic`[server error](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/500)` page. 

What the above code will do is print the error to the server log, pass right over the broken code, and try to serve up a normal [success page](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/200) as if nothing was wrong. This is bad. Worse than bad. This is a debugging nightmare.

It's the same with any application framework. Error handling will be managed, sensibly, at the application level. Catching individual error and providing custom handling makes error impossible to track down.

### Don't catch errors willy nilly

So, in the basic case, the right thing to do is to *not catch an error*. This way, the layer above your code will do the right thing. If it's a script or a Python interpreter, it will show the full trace to the developer. If it's an application, it will pass the error to the standard application exception handling layer, which will almost certainly do a better job than some  naive `try: ... except: print()` block could ever do.

### When to catch errors

Having said all this, there are many many cases where application error catchers will do a bad job. For example, let's take our Flask view and Mailchimp API example from above. One possible error we could get here is an API timeout error. It's quite likely that the API works fine when developing the website locally, but when pushing the code to production, firewalls or other network configuration prevent the application from reaching the API. Or the API could have become slugging under high load long after the code was released.

In this case, it might be quite desirable to show this on the resulting web page, rather than a generic server error. So we might want to deliberately catch these types of errors and instruct Flask to display an error page with a particular "API timeout" message or similar.

The point is not that we should never catch errors, but that we need to understand why we're doing it. What is the user story here, why could catching the error provide a better experience than the default experience?

In other words:

> [everything should be as simple as possible, but no simpler.](https://www.nature.com/articles/d41586-018-05004-4)
