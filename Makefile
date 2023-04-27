SHELL:=/bin/bash

DOCKER_COMPOSE_VERSION:=v2.11.1
DOCKER_COMPOSE_URL:=https://github.com/docker/compose/releases/download/$(DOCKER_COMPOSE_VERSION)/docker-compose-linux-x86_64

.PHONY: all
all: submodule dotfiles virtualenv vex poetry pipx pre-commit venv

.PHONY: submodule
submodule:
	git submodule update --init --recursive

.PHONY: dotfiles
dotfiles:
	python3 install-dotfiles.py

.PHONY: virtualenv
virtualenv:
	PIP_REQUIRE_VIRTUALENV=false python3 -m pip install --user --upgrade virtualenv

.PHONY: vex
vex:
	PIP_REQUIRE_VIRTUALENV=false python3 -m pip install --user --upgrade vex

.PHONY: poetry
poetry:
	PIP_REQUIRE_VIRTUALENV=false python3 -m pip install --user --upgrade poetry

.PHONY: pipx
pipx:
	PIP_REQUIRE_VIRTUALENV=false python3 -m pip install --user --upgrade pipx

.PHONY: pre-commit
pre-commit:
	PIP_REQUIRE_VIRTUALENV=false python3 -m pip install --user --upgrade pre-commit

.PHONY: tmuxp
tmuxp:
	PIP_REQUIRE_VIRTUALENV=false python3 -m pip install --user --upgrade tmuxp

.PHONY: venv
venv: $(HOME)/.virtualenvs/main
	$(HOME)/.virtualenvs/main/bin/python -m pip install -r requirements.txt

$(HOME)/.virtualenvs/main:
	$(HOME)/.local/bin/virtualenv $@

.PHONY: docker-compose
docker-compose: $(HOME)/.docker/cli-plugins/docker-compose

$(HOME)/.docker/cli-plugins/docker-compose:
	@mkdir -p $(dir $@)
	@curl -SL $(DOCKER_COMPOSE_URL) --output $@
	@chmod +x $@

.PHONY: fzf
fzf: $(HOME)/.fzf/bin/fzf

$(HOME)/.fzf/bin/fzf: $(HOME)/.fzf/install
	(cd $(dir $<) && ./install --bin)

$(HOME)/.fzf/install:
	rm -rf $(dir $@)
	git clone --depth 1 https://github.com/junegunn/fzf.git $(dir $@)

.PHONY: arch-packages
arch-packages:
	sudo pacman -S --needed $$(cat arch-packages.txt)

.PHONY: arch-packages-list
arch-packages-list:
	comm -23 <(pacman -Qqen | sort) <({ pacman -Qqg base-devel; expac -l '%E' base; } | sort | uniq) > arch-packages.txt

.PHONY: debian-packages
debian-packages:
	sudo dpkg --set-selections < debian-packages.txt
	sudo apt-get dselect-upgrade

.PHONY: debian-packages-list
debian-packages-list:
	dpkg --get-selections | grep -v deinstall | sort | uniq > debian-packages.txt

.PHONY: crontab
crontab:
	crontab crontab

.PHONY: clean
clean:
	rm -rf $(HOME)/.virtualenvs/main
