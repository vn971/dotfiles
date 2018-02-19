#!/bin/bash -eu

# There are reasons why I don't want to put
# my whole ~/.config/firejail directory in "dotfiles" repo.

target="$PWD"
cd ~/.config/firejail
cp -afl ./*-seccomp.inc "$target"