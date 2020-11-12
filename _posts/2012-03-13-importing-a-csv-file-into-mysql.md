---
title: Importing a CSV file into MySQL
date: 2012-03-13 00:00:00 Z
tags:
- PHP
- dev
- back-end
- MySQL
description: A simple PHP command-line script for importing data from a CSV file into
  a MySQL database.
image_url: https://assets.ubuntu.com/v1/0f43c01e-Importing+a+CSV+file+into+MySQL.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

I just wrote this script, and it seems pretty generic so I'm going to share it with The Internet. This will import data from a [CSV](http://en.wikipedia.org/wiki/Comma-separated_values) into a MySQL database table. Two rules:

 1. The first line of the CSV must contain the column names
 2. These column names must be exactly the same as the column names in the database table

## Usage

The basic usage is as follows:

``` php
php import.php -f [filename.csv] --database=[db_name] --table=[table_name]
```

You also have the following extra options:

```
-q (Quiet; no output)
-v (Verbose; print out all database insert commands)
--host=[hostname] (The host the database is on
- defaults to 'localhost')
--username=[username] (The username for the database)
--password=[password] (The password for the database)
```

## Example

Let's say we have a database called "example_db" containing a table "example_table":

```
mysql> desc example_table;
+-------+--------------+------+-----+---------+-------+
| Field | Type         | Null | Key | Default | Extra |
+-------+--------------+------+-----+---------+-------+
| id    | int(11)      | YES  |     | NULL    |       |
| value | varchar(255) | YES  |     | NULL    |       |
+-------+--------------+------+-----+---------+-------+
2 rows in set (0.00 sec)
```

Now we create a CSV of data called "example_csv.csv":

```
id,value 1,hello world 2,this is god
```

Now we run the import script:

```
$ php import.php -f example_csv.csv --database=example_db --table=example_table
```

Resulting in the data being imported into the table:

```
mysql> select * from example_table;
+------+-------------+
| id   | value       |
+------+-------------+
| 1    | hello world |
| 2    | this is god |
+------+-------------+
2 rows in set (0.00 sec)
```

That wasn't too painful was it?

## Download

Download the [CSV import script](http://static.robinwinslow.co.uk/csvimport/import.zip) in .zip format.

## To export from MySQL

```
into outfile
```

or

```
mysql -e '...' &gt; filename
```

See: [this MySQL forum post](http://forums.mysql.com/read.php?79,150417,289518#msg-289518).