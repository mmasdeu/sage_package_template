====================================
A Cookiecutter for SageMath projects
====================================

This Cookiecutter generates the basic structure to develop your own `SageMath <http://www.sagemath.org>`_ package, and includes the possibility of authomaticaly creating a `GitHub <https://github.com/>`_ repository and configurating it together with `Travis CI <https://travis-ci.org/>`_ for automatic testing and documentation deployment. We follow python recommendations and adapt them to the SageMath community. You can find more advanced documentation on python package creation on
`How To Package Your Python Code <https://packaging.python.org/>`_.

Initialitzation
---------------

Prerequisits
^^^^^^^^^^^^

For a smooth setup process you will need:

- a `GitHub`_ account,
- to authorize `Travis CI`_ to access your GitHub account by logging in once on the website,
- to have **git** and the python packages **cookiecutter** and **sagemath** ¿ssh, pip?

    To install cookiecutter run::

        $ pip install cookiecutter

    (add ``--user`` if you don't have enough privileges)
    
    To install sagemath run::

        $ sage -pip install --upgrade sagemath

    (add ``--user`` if you don't have enough privileges)

Usage
^^^^^

1) Shape your package:
   ::

      $ cookiecutter https://github.com/mmasdeu/sage_package_template

   (the ``cookiecutter`` binary may have been installed somewhere outside of your PATH, so you might need to `find` or `locate` for it)

2) Follow the instructions that come up on the terminal. 
   
   First you will be asked to define a set of variables that will inicialize your project:
    - ``full_name``: the author of the package.
    - ``email``: the email adress of the author.
    - ``github_username``: In order to configurate the GitHub repository.
    - ``project_name``: The title of the package. It will appear mainly on the documentation.
    - ``app_name``: The name of the package. It will be used to install and import the module.
    - ``project_short_description``: A short sentence to describe what the package does. Also, the short description on the GitHub repository.
    - ``project_version``: Version number.
    - ``travis_ubuntu_version``: The version of Ubuntu that you set Travis CI to use (for automatized documentation).
    - ``sage_required_version``: Minimum SageMath version needed for the package.
    - ``sage_mirror``: When doctesting with Travis CI, website to download the SageMath binaries.
    - ``keywords``: Keywords for the GitHub repository.
    - ``Select open_source_license``: License of distribution of the package. For more information see `Licenses&Standards <https://opensource.org/licenses>`_.
   
   Next, you will be asked to answer a series of questions in order to configure (or not) `GitHub`_ and `Travis CI`_. For more information on the setup process check the MANUAL_INSTALL.rst file inside your newly created package.

3) Now your package is shaped and ready for baking! Read the Developer's guide to see how to use and modify your newly created package.



Developer's guide
-----------------

Source code
^^^^^^^^^^^

All source code is stored in the folder using the same name as the
package. This is not mandatory but highly recommended for clarity. All source folder
must contain a ``__init__.py`` file with needed includes.

Tests
^^^^^

This package is configured for tests written in the documentation
strings, also known as ``doctests``. See
`SageMath's coding conventions and best practices document <http://doc.sagemath.org/html/en/developer/coding_basics.html#writing-testable-examples>`_.
With additional configuration, it would be possible to include unit
tests as well.

Once the package is installed, one can use the SageMath test system
configured in ``setup.py`` to run the tests::

    $ sage setup.py test

This is just calling ``sage -t`` with appropriate flags.

Shorthand::

    $ make test

Documentation
^^^^^^^^^^^^^

The documentation of the package can be generated using Sage's
``Sphinx`` installation::

    $ cd docs
    $ sage -sh -c "make html"

Shorthand::

    $ make doc
