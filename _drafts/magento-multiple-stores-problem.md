On http://www.web-blinds.com we've setup three store views:
- uk
- ireland
- europe

The stores have different product categories enabled (as well as other settings different) which means that they show different content on the front-end - e.g. they have different items in the top navigation.

We use Geoip to try to put users in the correct store when they first visit the site.

We've run into multiple problems to do with caching, where users are served the content for a different store than the one they should be in. I've added custom fixes to try to fix some of these issues - ranging from forcing the page to reload if it detects an inconsistency, to updating the content on the front-end through Ajax.

However, I've now run into a rather insurmountable problem that the homepage when the user first visits the site seems to be an entirely cached version - sometimes from one store, sometimes from another. Even the HTTP headers have been cached so we can't set the users' store at all. This completely breaks our Geoip solution.

My proposed solution is to change our approach to use unique URLs for the different stores. It seems to me that this is a more "correct" version in terms of HTTP - one HTTP resource should ideally always contain the same content - and it should categorically fix any caching issues.

So I'm using different TLDs for the different stores:
web-blinds.com
web-blinds.ie
web-blinds.eu
and the "method 2" technique from http://docs.nexcess.net/multiplestorefronts to serve the correct store for each domain.

Does this approach make sense? Am I approaching this entirely the wrong way? Could you just let me know what you think of my problem?

Ta
Robin