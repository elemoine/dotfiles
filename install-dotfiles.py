#!/usr/bin/env python
import os
import fnmatch
import shutil


exclude = ['*.sw*', '.git', '*.un~', 'install-dotfiles.py', '.gitmodules', 'Makefile',
           'build', 'requirements.txt', 'virtualenv-burrito']
for f in os.listdir('.'):
    if not any(fnmatch.fnmatch(f, p) for p in exclude):
        path = os.path.join(os.path.expanduser('~'), f)
        if os.path.isfile(path) or os.path.islink(path):
            os.unlink(path)
        elif os.path.isdir(path):
            shutil.rmtree(path)
        os.symlink(os.path.abspath(f), path)
        print 'create link for %s' % (path)