#!/bin/sh
#
# Installing pip 
#
cdir=`pwd`
# Check for pip
# if test ! $(which pip)
# then
#   echo "  Installing `pip` for you."
#   sudo easy_install pip
# else
#   echo "  pip already installed. Checking for updates..."
#   sudo -H pip install --upgrade pip
# fi

present=`pip list | grep requests | sed 's/^requests\ *//'`

if test ! $(echo $present)
then
	echo "   python package requests not found. Cloning git and installing it."
	mkdir -p /tmp/requests
	cd /tmp/requests
	git clone git://github.com/requests/requests.git
	cd requests
	pip install requests --user
	cd /tmp
	rm -rf requests
	cd $cdir
else
	echo "   found requests in version $present"
	echo "   skipping the installation. If there is a newer version, we'll upgrade that automatically in a bit..."
fi