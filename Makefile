.PHONY: all
all: submodule dotfiles venv

.PHONY: submodule
submodule:
	git submodule update --init

.PHONY: dotfiles
dotfiles:
	python install-dotfiles.py

.PHONY: pip
pip: get-pip.py
	sudo python get-pip.py

get-pip.py:
	curl -O https://bootstrap.pypa.io/get-pip.py

.PHONY: virtualenv
install-virtualenv:
	sudo pip install --upgrade virtualenv

.PHONY: virtualenvwrapper
install-virtualenvwrapper:
	sudo pip install --upgrade virtualenvwrapper

.PHONY: venv
venv: $(HOME)/.virtualenvs/main
	$(HOME)/.virtualenvs/main/bin/pip install -r requirements.txt

$(HOME)/.virtualenvs/main:
	virtualenv $@

.PHONY: puppet
puppet: init.pp
	puppet parser validate $< && \
	sudo FACTER_homedir=$(HOME) FACTER_cwd=$(shell pwd) FACTER_user=$(shell whoami) puppet apply $<

.PHONY: clean
clean:
	rm -rf $(HOME)/.virtualenvs/main
