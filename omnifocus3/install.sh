#!/bin/zsh
# first we save all currently added stencil in our dotfiles
# then we copy them all back

cp ~/Library/Application\ Scripts/com.omnigroup.OmniFocus3/*.scpt ~/.dotfiles/omnifocus3/scripts/
cp ~/.dotfiles/omnifocus3/scripts/* ~/Library/Application\ Scripts/com.omnigroup.OmniFocus3/