#!/bin/sh
#
# Installing pip 
#

# Check for Homebrew
if test ! $(which pip)
then
  echo "  Installing `pip` for you."
  sudo easy_install pip
else
  echo "  pip already installed. Checking for updates..."
  sudo -H pip install --upgrade pip
fi

