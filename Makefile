SHELL:=/bin/bash

.PHONY: all
all: submodule dotfiles pip virtualenv vex venv

.PHONY: submodule
submodule:
	git submodule update --init

.PHONY: dotfiles
dotfiles:
	/usr/bin/python3 install-dotfiles.py

.PHONY: pip
pip: get-pip.py
	PIP_REQUIRE_VIRTUALENV=false /usr/bin/python3 get-pip.py --user -I

get-pip.py:
	curl -O https://bootstrap.pypa.io/get-pip.py

.PHONY: virtualenv
virtualenv:
	PIP_REQUIRE_VIRTUALENV=false $(HOME)/.local/bin/pip install --user --upgrade virtualenv

.PHONY: vex
vex:
	PIP_REQUIRE_VIRTUALENV=false $(HOME)/.local/bin/pip install --user --upgrade vex

.PHONY: venv
venv: $(HOME)/.virtualenvs/main
	$(HOME)/.virtualenvs/main/bin/pip install -r requirements.txt

$(HOME)/.virtualenvs/main:
	$(HOME)/.local/bin/virtualenv $@

.PHONY: fzf
fzf: $(HOME)/.fzf/bin/fzf

$(HOME)/.fzf/bin/fzf: $(HOME)/.fzf/install
	(cd $(dir $<) && ./install --bin)

$(HOME)/.fzf/install:
	rm -rf $(dir $@)
	git clone --depth 1 https://github.com/junegunn/fzf.git $(dir $@)

.PHONY: packages
packages:
	sudo pacman -S --needed $$(cat packages.txt)

.PHONY: packages-list
packages-list:
	comm -23 <(pacman -Qqen | sort) <({ pacman -Qqg base-devel; expac -l '%E' base; } | sort | uniq) > packages.txt

.PHONY: crontab
crontab:
	crontab crontab

.PHONY: clean
clean:
	rm -rf $(HOME)/.virtualenvs/main
