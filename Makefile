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
	/usr/bin/python get-pip.py --user -I

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

.PHONY: ansible
ansible:
	(cd ansible && ansible-playbook -i hosts.ini playbook.yml)

.PHONY: packages
packages:
	sudo apt-get install -y gcc libjpeg-dev python python-dev zlib1g-dev vim-gtk tmux curl

.PHONY: clean
clean:
	rm -rf $(HOME)/.virtualenvs/main
