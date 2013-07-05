Sap documentation:

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

More in-depth:

Order logging is done here:
code/local/Hillarys/Sap/Model/Client/Abstract.php:235

Customer logging is done here:
code/local/Hillarys/Sap/Model/Client/Customer.php:158
