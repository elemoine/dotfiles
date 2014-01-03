VIRTUALENV_BURRITO_SH = https://raw.github.com/brainsik/virtualenv-burrito/master/virtualenv-burrito.sh

SHELL := /bin/bash


.PHONY: all
all: submodule venv dotfiles

.PHONY: submodule
submodule:
	git submodule update --init

.PHONY: venv
venv: $(HOME)/.virtualenvs/main
	$(HOME)/.virtualenvs/main/bin/pip install -r requirements.txt

$(HOME)/.virtualenvs/main: $(HOME)/.venvburrito
	source $(HOME)/.venvburrito/startup.sh && mkvirtualenv main

$(HOME)/.venvburrito:
	curl -s $(VIRTUALENV_BURRITO_SH) | $(SHELL)

.PHONY: dotfiles
dotfiles:
	python install-dotfiles.py

.PHONY: allclean
allclean:
	rm -rf $(HOME)/.venvburrito
	rm -rf $(HOME)/.virtualenvs/main


