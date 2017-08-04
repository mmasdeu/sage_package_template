=======================================================================================
Welcome to the {{cookiecutter.app_name}}'s documentation!
=======================================================================================

{{cookiecutter.app_name}} is a package that {{cookiecutter.project_short_description}}.

Installation
============

**Local install from source**


Download the source from the git repository::

    $ git clone https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}.git

Change to the root directory and run::

    $ sage -pip install --upgrade --no-index -v .

For convenience this package contains a [makefile](makefile) with this
and other often used commands. Should you wish too, you can use the
shorthand::

    $ make install
    
**Usage**


Once the package is installed, you can use it in Sage. To do so you have to import it with::

    sage: from {{cookiecutter.app_name}} import *
    sage: answer_to_ultimate_question()
    42


{{cookiecutter.project_name}}
=======================================================================================

.. toctree::
   :maxdepth: 2

   ultimate_question


Indices and Tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
