# This Makefile is for convenience as a reminder and shortcut for the most used commands

# Package folder
PACKAGE = {{cookiecutter.app_name}}

# change to your sage command if needed
SAGE = sage

all: install test

build:
	$(SAGE) -python setup.py build_ext

install:
	$(SAGE) -python setup.py install

sdist:
	$(SAGE) -python setup.py sdist

test:
	$(SAGE) -python setup.py test

pip-install:
	$(SAGE) -pip install --upgrade --no-index -v .

pip-uninstall:
	$(SAGE) -pip uninstall .

pip-develop:
	$(SAGE) -pip install --upgrade -e .

coverage:
	$(SAGE) -coverage $(PACKAGE)/*

doc:
	cd docs && $(SAGE) -sh -c "make html"

doc-pdf:
	cd docs && $(SAGE) -sh -c "make latexpdf"

clean: clean-doc
	rm -rf build dist *.egg-info
	rm -rf $(PACKAGE)/*.c

clean-doc:
	cd docs && $(SAGE) -sh -c "make clean"

.PHONY: all build install test coverage sdist pip-install pip-uninstall pip-develop clean clean-doc doc doc-pdf
