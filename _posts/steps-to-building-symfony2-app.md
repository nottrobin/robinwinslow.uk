Steps to building symfony2 app:

Create bundle (http://symfony.com/doc/2.0/book/page_creation.html):
$ php app/console generate:bundle --namespace=<Vendor>/<AppName> --format=yml

This does:
- Create directory structure: src/<Vendor>/<AppName>
- Create bundle object: <Vendor>/<AppName>/<VendorAppName>
- Add bundle object to "$bundles" array in AppKernel.php

A route needs to point to function to use as the controller. 

A controller can be any function, but it would usually be an object, and the convention is to extend Symfony\Bundle\FrameworkBundle\Controller\Controller


