#!/usr/bin/env python
import os
import fnmatch
import shutil


def create_symlink(dotname, directory=''):
    path = os.path.join(os.path.expanduser('~'), directory, dotname)
    if os.path.isfile(path) or os.path.islink(path):
        os.unlink(path)
    elif os.path.isdir(path):
        shutil.rmtree(path)
    os.symlink(os.path.abspath(os.path.join(directory, dotname)), path)
    print 'create link for %s' % (path)


exclude = ['*.sw*', '.git', '*.un~', 'install-dotfiles.py',
    '.gitmodules', 'Makefile', 'build', 'requirements.txt',
    'virtualenv-burrito', '.config']

for f in os.listdir('.'):
    if not any(fnmatch.fnmatch(f, p) for p in exclude):
        create_symlink(f)

for f in os.listdir('.config'):
    if not any(fnmatch.fnmatch(f, p) for p in exclude):
        create_symlink(f, '.config')
