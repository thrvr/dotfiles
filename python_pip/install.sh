#!/bin/sh
#
#  this installation script automatically installs pip
#
cdir=`pwd`

#Check for pip
if test ! $(which pip)
then
  echo "  Installing `pip` for you."
  sudo easy_install pip
else
  echo "  pip already installed. Checking for updates..."
  sudo -H pip install --upgrade pip
fi


# Installing `requests` package
#
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
fi

# Installing `lxml` package
#
present=`pip list | grep lxml | sed 's/^lxml\ *//'`
if test ! $(echo $present)
then
	sudo -H pip install lxml
else
	echo "   found lxml in version $present"
fi


echo "   Upgarding all python packages"
sudo -H pip2 freeze — local | grep -v ‘^\-e’ | cut -d = -f 1 | xargs -n1 sudo -H pip2 install -U --user
echo ""
echo "   Ugrade of Pyton finished. All packages should now be current. Please check any potential error messages."