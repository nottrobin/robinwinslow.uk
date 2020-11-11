---
title: Ease Magento development with bootstrapped scripts
date: 2013-05-29 00:00:00 Z
tags:
- dev
- magento
- back-end
description: Mini scripts are super-helpful in magento development. This will explain
  how to bootstrap them and give a simple example of how to select a category and
  get its children.
image_url: https://assets.ubuntu.com/v1/dc670197-Ease+Magento+development+with+bootstrapped+scripts.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

If you work in Magento a lot, you'll come to many many points when you need to manipulate the models in Magento programmatically.

This could help you inspect the raw data stored against the models (Magento's database structure is [hideously complex](http://www.magentocommerce.com/wiki/2_-_magento_concepts_and_architecture/magento_database_diagram)), or it could be because you need to edit existing models or create new ones.

## The bootstrap script

I suggest you create the bootstrap as its own script so you can include it in all your little scripts:

``` bash
# from magento project root
mkdir scripts
touch scripts/bootstrap.php
```

Bootstrapping Magento requires a few lines - you can tweak the individual settings if you like:

``` php
// scripts/bootstrap.php

<?php
ini_set('memory_limit', '1024M');
set_time_limit(0);

/* Includes */
require_once realpath(__DIR__) . '/../app/Mage.php';

/* Enable developer mode */
Mage::setIsDeveloperMode(true);

Mage::app('admin')->setUseSessionInUrl(false);

$userModel = Mage::getModel('admin/user');
$userModel->setUserId(0);
Mage::getSingleton('admin/session')->setUser($userModel);

Mage::app()->setCurrentStore(Mage_Core_Model_App::ADMIN_STORE_ID);

/* Undo Magento's hiding of errors */
error_reporting(-1);
ini_set('display_errors', 1);
?>
```

Once you've done this, you can use the `Mage` static to [do whatever you like](http://www.magentocommerce.com/knowledge-base/entry/magento-for-dev-part-1-introduction-to-magento).

## A use-case

Here's a simple example that just retrieves the child IDs of the default category.

Note how this script includes the bootstrap script that we just made at the top:

``` php
// scripts/default-category-children.php

<?php
// Bootstrap Magento
require_once(realpath(__DIR__) . '/bootstrap.php');

// Get default category model
$defaultCategory = Mage::getModel('catalog/category')->getCollection()->addAttributeToSelect('*')->addFieldToFilter('category_code','default')->getFirstItem();

// Show a list of IDs of its children
echo $defaultCategory->getChildren();
?>
```

And now you can run this directly from the command-line:

``` bash
$ php scripts/default-category-children.php
3,7,8
```

There are many useful things you can do with these scripts - not to mention writing them will increase your understanding of Magento like nothing else.

I will also post some good example scripts on this blog in the near future, and I'll try to remember to add the links to those posts below.