#!/usr/bin/env bash

mv ~/.emacs.d ~/.emacs.d.old
git clone https://github.com/blak3mill3r/emacs.d.git ~/.emacs.d
cd ~/.emacs.d
rm -rf .git
cask install
echo "Done! Enjoy"

