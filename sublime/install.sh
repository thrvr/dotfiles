#!/bin/bash
# set -x
dotfile_sublime_directory="`dirname \"$0\"`"              # relative
dotfile_sublime_directory="`( cd \"$dotfile_sublime_directory\" && pwd )`"  # absolutized and normalized
if [ -z "$dotfile_sublime_directory" ] ; then
  echo "Could not access the current directory '$dotfile_sublime_directory'";
  exit 1  # fail
fi
# echo $dotfile_sublime_directory

dpd="$dotfile_sublime_directory/Packages"
dipd="$dotfile_sublime_directory/Installed Packages"
# echo "DPD $dpd - $dipd"

sublime_directory=~/Library/Application\ Support/Sublime\ Text\ 3/
spd="$sublime_directory/Packages"
sipd="$sublime_directory/Installed Packages"

if [ ! -L "$spd" ]; then
	cd "$spd"
	cp -R * "$dpd"
	cd ..
	rm -rf Packages
	ln -s "$dpd" Packages
fi

if [ ! -L "$sipd" ]; then
	cd "$sipd"
	cp -R * "$dipd"
	cd ..
	rm -rf "Installed Packages"
	ln -s "$dipd" "Installed Packages"
fi
