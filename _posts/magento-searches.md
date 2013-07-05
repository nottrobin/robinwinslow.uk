---
title: "Magento searches"
---

- magento check rewrites
- magento change config settings
- magento dump config values
- magento collection to array
- magento change shipping rates programatically
- magento indexer.php reindex price tables

Magento admin configuration
===

(write a document about how to handle config - including how to dump all config values and then get them or set them by store)

Mention ->getCollection()->toArray()

Magento indexer
===

php indexer.php help
php indexer.php info

http://www.atwix.com/magento/process-magento-indexes-from-command-line/#
http://stackoverflow.com/questions/4085681/stopping-the-magento-indexing-process

Magento queries
===

http://stackoverflow.com/questions/11792762/how-to-do-custom-query-in-magento

Mention that $installer->run is a proxy for $installer->getConnection()->query()
and that you can get select results with $connection->fetchAll();

Magento managing update scripts
===

- Use symlinks like I do
- Add if statements around them so that you can run either from command-line or as update script
- Note -> getConfig()->reinit(), and $connection.

Magento in the shell
===

If you're a dev, do these on the command-line to speed up development:
- Reindex
- Clear cache

Magento developer mode
===

http://alanstorm.com/magento_exception_handling_developer_mode
http://www.blog.magepsycho.com/configuring-magento-for-development-debug-mode/

Hillarys Magento - how to edit SAP
===

Templates for Customer and Order creation:
---
public/app/code/local/Hillarys/Sap/templates/customer_create.phtml
public/app/code/local/Hillarys/Sap/templates/order_create.phtml

Where the data is built
---
public/app/code/local/Hillarys/Sap/Model/Client/Customer.php

Where the output is saved on order creation (in local environment)
---
public/var/log/sap_requests_xml.log



