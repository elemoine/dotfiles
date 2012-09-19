#!/usr/bin/env python
import os
import fnmatch
import shutil


home = os.path.expanduser('~')


def run(cmd):
    """simple wrapper around os.system to log the command to sys.stdout"""
    print 'running: ' + cmd
    os.system(cmd)

# virtualenv-burrito
vburrito_dir = os.path.join(home, '.venvburrito')
vburrito = os.path.join(vburrito_dir, 'bin', 'virtualenv-burrito')
cmd = vburrito + ' upgrade'
if not os.path.exists(os.path.join(vburrito_dir)):
    os.makedirs(os.path.join(vburrito_dir, 'lib', 'python'))
    os.makedirs(os.path.join(vburrito_dir, 'bin'))
    cmd += ' firstrun'
shutil.copyfile('virtualenv-burrito/virtualenv-burrito.py', vburrito)
os.chmod(vburrito, 0755)
run(cmd)

# "global" venv
venv_global = os.path.join(home, '.virtualenvs/global')
if not os.path.exists(venv_global):
    run('/bin/bash -c "source %s && mkvirtualenv global"' %
        os.path.join(vburrito_dir, 'startup.sh'))
run(os.path.join(venv_global, 'bin', 'pip') + ' install -r requirements.txt')

# dotfiles
exclude = ['*.sw*', '.git', 'install.*', '.gitmodules',
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
