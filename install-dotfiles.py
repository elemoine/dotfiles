#!/usr/bin/env python
import os
import fnmatch
import shutil


def create_symlink(dotname, directory=''):
    directory_path = os.path.join(os.path.expanduser('~'), directory)
    if not os.path.isdir(directory_path):
        os.mkdir(directory_path)
    path = os.path.join(directory_path, dotname)
    if os.path.isfile(path) or os.path.islink(path):
        os.unlink(path)
    elif os.path.isdir(path):
        shutil.rmtree(path)
    os.symlink(os.path.abspath(os.path.join(directory, dotname)), path)
    print 'create link for %s' % (path)


exclude = ['*.sw*', '.git', '*.un~', 'install-dotfiles.py',
    '.gitmodules', 'Makefile', 'build', 'requirements.txt',
    'init.pp', '.config', 'ansible', 'get-pip.py']

for f in os.listdir('.'):
    if not any(fnmatch.fnmatch(f, p) for p in exclude):
        create_symlink(f)

for f in os.listdir('.config'):
    if not any(fnmatch.fnmatch(f, p) for p in exclude):
        create_symlink(f, '.config')
