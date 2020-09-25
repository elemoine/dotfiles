#!/usr/bin/env python3
import os
import fnmatch
import shutil


def create_symlink(dotname, directory=""):
    directory_path = os.path.join(os.path.expanduser("~"), directory)
    if not os.path.isdir(directory_path):
        os.mkdir(directory_path)
    path = os.path.join(directory_path, dotname)
    if os.path.isfile(path) or os.path.islink(path):
        os.unlink(path)
    elif os.path.isdir(path):
        shutil.rmtree(path)
    os.symlink(os.path.abspath(os.path.join(directory, dotname)), path)
    print("create link for %s" % path)


exclude = [
    "*.sw*",
    ".git",
    "*.un~",
    "install-dotfiles.py",
    ".gitmodules",
    "Makefile",
    "build",
    "requirements.txt",
    ".config",
    "get-pip.py",
    ".ssh",
    ".gnupg",
    "packages.txt",
    "config",
    "crontab",
]

for e in os.scandir("."):
    if not any(fnmatch.fnmatch(e.name, p) for p in exclude):
        create_symlink(e.name)

for configdir in (".config", ".ssh", ".gnupg"):
    for e in os.scandir(configdir):
        if e.is_dir():
            continue
        if not any(fnmatch.fnmatch(e.name, p) for p in exclude):
            create_symlink(e.name, configdir)
