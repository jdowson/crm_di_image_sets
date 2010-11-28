crm_di_image_sets
================

** THIS IS UNDER DEVELOPMENT AND WILL NOT PRODUCE ANY USEFUL BEHAVIOUR IN AN UNMODIFIED FAT FREE CRM SYSTEM ** 

** NOTE: THE CURRENT VERSION REQUIRES VERSION 0.1.2 OR LATER OF THE crm_di_core MODULE **

Overview
--------

This module implements image set management functionality for [Fat Free CRM][2].


Prerequisites
-------------

This module depends on the [crm_di_core][4] plugin **version 0.1.2 or later** to implement standard drop-down list functionality.


Installation
------------

From the root of your Fat Free CRM installation run:

> `./script/plugin install [source]`

Where [source] can be, according to your needs, one of:

> SSH:
>    `git@github.com:jdowson/crm_di_image_sets.git`
>
> Git: 
>    `git://github.com/jdowson/crm_di_image_sets.git`
>
> HTTP:
>    `https://jdowson@github.com/jdowson/crm_di_image_sets.git`

The database migrations required for the plug can be installed with the following command:

> `rake db:migrate:plugin NAME=crm_di_image_sets`

...that can be run from the Fat Free CRM installation root.


Sample Data
-----------

Sample *image_set type* and *image_set subtype* lookup fields may be created using the following *rake* command:

> `rake crm:di:image_sets:setup`

These fields initially contain no lookup values. Sample values can be installed with the following *rake* command:

> `rake crm:di:image_sets:demo`

These commands respond to the usual rake environment options, such as `RAILS_ENV=test`.


Tests
-----

See the *readme* for the [crm_di_core][4] repository for general comments on tests.


Copyright (c) 2010 [Delta Indigo Ltd.][1], released under the MIT license

[1]: http://www.deltindigo.com/                 "Delta Indigo"
[2]: http://www.fatfreecrm.com/                 "Fat Free CRM"
[3]: http://www.github.com/                     "github"
[4]: https://github.com/jdowson/crm_di_core     "crm_di_core"

