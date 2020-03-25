## -*- encoding: utf-8 -*-
import os
import sys
import re
from setuptools import setup
from codecs import open # To open the README file with proper encoding
from setuptools.command.test import test as TestCommand # for tests
from distutils.command import build as build_module

{%- set license_classifiers = {
    'MIT license': 'License :: OSI Approved :: MIT License',
    'BSD license': 'License :: OSI Approved :: BSD License',
    'ISC license': 'License :: OSI Approved :: ISC License (ISCL)',
    'Apache Software License 2.0': 'License :: OSI Approved :: Apache Software License',
    'GNU General Public License v3': 'License :: OSI Approved :: GNU General Public License v3 (GPLv3)'
} %}

# Get information from separate files (README, VERSION)
def readfile(filename):
    with open(filename,  encoding='utf-8') as f:
        return f.read()

# Check the right Sage version
class build(build_module.build):
    def run(self):
        from sagemath.check_version import check_version
        check_version(sage_required_version)
        build_module.build.run(self)


# For the tests
class SageTest(TestCommand):
    def run_tests(self):
        errno = os.system("sage -t --force-lib {{cookiecutter.app_name}} {{cookiecutter.app_name}}/*.pyx")
        if errno != 0:
            sys.exit(1)

if __name__ == "__main__":

    # The next block is needed if there are cython files
    from setuptools import Extension
    from Cython.Build import cythonize
    import Cython.Compiler.Options
    from sage.env import sage_include_directories

    # Cython modules
    ext_modules = [
             Extension('{{cookiecutter.app_name}}.one_cython_file',
             sources = [os.path.join('{{cookiecutter.app_name}}','one_cython_file.pyx')],
             include_dirs=sage_include_directories())
    ]

    # Specify the required Sage version
    sage_required_version = '{{cookiecutter.sage_required_version}}'
    sage_current_version = sage_version()
    py2 = bool('8.' in sage_current_version or '7.' in sage_current_version)

    REQUIREMENTS = [i.strip() for i in open("requirements.txt").readlines() if i[0] != '#']
    CLASSIFIERS = [i.strip() for i in open("classifiers.txt").readlines() if i[0] != '#']

    setup(
        name = "{{cookiecutter.app_name}}",
        version = readfile("VERSION"), # the VERSION file is shared with the documentation
        description='{{cookiecutter.project_short_description}}',
        long_description = readfile("README.rst"), # get the long description from the README
        url='https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}',
        author='{{cookiecutter.full_name}}',
        author_email='{{cookiecutter.email}}', # choose a main contact email
        {%- if cookiecutter.open_source_license in license_classifiers %}
        license="{{ cookiecutter.open_source_license }}",
        {%- endif %}
        classifiers = CLASSIFIERS,
        keywords = "{{cookiecutter.keywords}}",
        setup_requires = REQUIREMENTS, # currently useless, see https://www.python.org/dev/peps/pep-0518/
        install_requires = REQUIREMENTS, # This ensures that Sage is installed
        packages = ['{{cookiecutter.app_name}}'],
        ext_modules = cythonize(ext_modules) if py2 else cythonize(ext_modules, compiler_directives={'language_level' : "3"}),
        include_package_data = True,
        cmdclass = {'build': build, 'test': SageTest} # adding a special setup command for tests
    )
