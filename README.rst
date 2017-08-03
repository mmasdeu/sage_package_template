================================
A Cookiecutter for Sage projects
================================

This Cookiecutter generates a simple `SageMath <http://www.sagemath.org>`_ package
example to serve as a good practice reference for package developers. We follow
python recommendations and adapt them to the SageMath community. You can find more
advanced documentation on python package creation on
`How To Package Your Python Code <https://packaging.python.org/>`_.

Installation
------------

1) Install cookiecutter::

     $ pip install cookiecutter

(add ``--user`` if you don't have enough privileges)

2) Bake your package::

     $ cookiecutter https://github.com/mmasdeu/sage_package_template

(the ``cookiecutter`` binary may have been installed somewhere outside of your PATH, so you might need to `find` or `locate` for it)

3) Follow the instructions that you will find in the INSTALL.rst file inside your newly created package.
