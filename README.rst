======
jira
======

Formulas to set up and configure Atlassian Jira.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``jira``
----------

Installs the jira standalone tarball and starts the service.  Configures
~jira/dbconfig.xml, but assumes database creation handled by another forumla
(e.g. postgres-formula).  

``jira.proxy``
------------------

Enables a basic Apache proxy for jira.


Known Issues
============
* some options (generally jira.lf.*) do not load properly from jira-config.properties  
  due to a bug in Jira.
  see: https://jira.atlassian.com/browse/JRA-29904


