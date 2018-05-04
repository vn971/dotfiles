#!/bin/bash -eu

# There are reasons why I don't want to put
# my whole ~/.config/firejail directory in "dotfiles" repo.

cp -afl ~/.config/firejail/*-seccomp.inc ./