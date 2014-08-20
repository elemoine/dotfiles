VIRTUALENV_BURRITO_SH = https://raw.github.com/brainsik/virtualenv-burrito/master/virtualenv-burrito.sh

SHELL := /bin/bash


.PHONY: all
all: puppet submodule venv dotfiles

.PHONY: puppet
puppet: init.pp
	puppet parser validate $< && \
	sudo FACTER_homedir=$(HOME) FACTER_cwd=$(shell pwd) FACTER_user=$(shell whoami) puppet apply $<

.PHONY: submodule
submodule:
	git submodule update --init

.PHONY: venv
venv: $(HOME)/.virtualenvs/main
	$(HOME)/.virtualenvs/main/bin/pip install -r requirements.txt

$(HOME)/.virtualenvs/main: $(HOME)/.venvburrito
	source $(HOME)/.venvburrito/startup.sh && mkvirtualenv main

$(HOME)/.venvburrito:
	curl -s $(VIRTUALENV_BURRITO_SH) | /bin/bash

.PHONY: dotfiles
dotfiles:
	python install-dotfiles.py

.PHONY: allclean
allclean:
	rm -rf $(HOME)/.venvburrito
	rm -rf $(HOME)/.virtualenvs/main


