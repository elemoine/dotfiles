.PHONY: all
all: submodule dotfiles pip virtualenv virtualenvwrapper venv

.PHONY: submodule
submodule:
	git submodule update --init

.PHONY: dotfiles
dotfiles:
	/usr/bin/python install-dotfiles.py

.PHONY: pip
pip: get-pip.py
	/usr/bin/python get-pip.py --user

get-pip.py:
	curl -O https://bootstrap.pypa.io/get-pip.py

.PHONY: virtualenv
virtualenv:
	$(HOME)/.local/bin/pip install --user --upgrade virtualenv

.PHONY: virtualenvwrapper
virtualenvwrapper:
	$(HOME)/.local/bin/pip install --user --upgrade virtualenvwrapper

.PHONY: venv
venv: $(HOME)/.virtualenvs/main
	$(HOME)/.virtualenvs/main/bin/pip install -r requirements.txt

$(HOME)/.virtualenvs/main:
	$(HOME)/.local/bin/virtualenv $@

.PHONY: puppet
puppet: init.pp
	puppet parser validate $< && \
	sudo FACTER_homedir=$(HOME) FACTER_cwd=$(shell pwd) FACTER_user=$(shell whoami) puppet apply $<

.PHONY: ansible
ansible:
	(cd ansible && ansible-playbook -i hosts.ini playbook.yml)

.PHONY: clean
clean:
	rm -rf $(HOME)/.virtualenvs/main
