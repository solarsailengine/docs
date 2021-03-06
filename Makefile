# Minimal makefile for Sphinx documentation
#

venv = venv/bin

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= $(venv)/sphinx-build
SOURCEDIR     = src/
BUILDDIR      = _build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

setup:
	@$(venv)/pip install sphinx
	@$(venv)/pip install sphinx-rtd-theme
	@$(venv)/pip install readthedocs-sphinx-ext

dist:
	@$(MAKE) html
	@rm -rf docs
	@mkdir docs
	@mv $(BUILDDIR)/html/* docs/
	@touch docs/.nojekyll
	@echo 'docs.solarsailengine.com' > docs/CNAME

serve:
	@$(MAKE) html
	@$(venv)/python3 -m http.server --directory _build/html

upload:
	# AWS_PROFILE=solarsail make upload
	@aws s3 sync _build/html/ s3://docs.solarsailengine.com --acl public-read --delete --cache-control public,max-age=300
