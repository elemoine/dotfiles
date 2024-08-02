SHELL:=/bin/bash

DOCKER_COMPOSE_VERSION:=v2.11.1
DOCKER_COMPOSE_URL:=https://github.com/docker/compose/releases/download/$(DOCKER_COMPOSE_VERSION)/docker-compose-linux-x86_64

.PHONY: all
all: submodule dotfiles venv

.PHONY: submodule
submodule:
	git submodule update --init --recursive

.PHONY: dotfiles
dotfiles:
	python3 install-dotfiles.py

.PHONY: venv
venv: $(HOME)/.virtualenvs/main
	$(HOME)/.virtualenvs/main/bin/python -m pip install -r requirements.txt

$(HOME)/.virtualenvs/main:
	mkdir -p $(HOME)/.virtualenvs
	python3 -m venv $@

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

.PHONY: brewfile
brewfile:
	brew bundle dump -f

.PHONY: crontab
crontab:
	crontab crontab

.PHONY: clean
clean:
	rm -rf $(HOME)/.virtualenvs/main
