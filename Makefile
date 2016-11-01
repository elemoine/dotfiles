.PHONY: all
all: submodule dotfiles pip virtualenv virtualenvwrapper venv ansible playbook requirements

.PHONY: submodule
submodule:
	git submodule update --init

.PHONY: dotfiles
dotfiles:
	/usr/bin/python install-dotfiles.py

.PHONY: pip
pip: get-pip.py
	/usr/bin/python get-pip.py --user -I

.PHONY: virtualenv
virtualenv:
	$(HOME)/.local/bin/pip install --user --upgrade virtualenv

.PHONY: virtualenvwrapper
virtualenvwrapper:
	$(HOME)/.local/bin/pip install --user --upgrade virtualenvwrapper

.PHONY: venv
venv: $(HOME)/.virtualenvs/main

.PHONY: ansible
ansible: $(HOME)/.virtualenvs/main
	$(HOME)/.virtualenvs/main/bin/pip install "ansible==2.2.0.0"

.PHONY: requirements
requirements: $(HOME)/.virtualenvs/main
	$(HOME)/.virtualenvs/main/bin/pip install -r requirements.txt

.PHONY: playbook
playbook:
	(cd ansible && $(HOME)/.virtualenvs/main/bin/ansible-playbook -i hosts.ini -l local -K playbook.yml)

.PHONY: clean
clean:
	rm -rf $(HOME)/.virtualenvs/main

get-pip.py:
	curl -O https://bootstrap.pypa.io/get-pip.py

$(HOME)/.virtualenvs/main:
	$(HOME)/.local/bin/virtualenv $@
