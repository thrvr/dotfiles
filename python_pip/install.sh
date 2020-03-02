#!/bin/sh
#
#  this installation script automatically installs pip
#
cdir=`pwd`

# #Check for pip
# if test ! $(which pip)
# then
#   echo "  Installing `pip` for you."
#   sudo easy_install pip
# else
#   echo "  pip already installed. Checking for updates..."
#   sudo -H pip install --upgrade pip
# fi


# pcregrep -v $exclude_pattern for excluding these packages
# form upgrading
exclude_pattern='(pip|docutils|idna)'

# versions that we freeze packages at
pip_version=20.0.2
docutils_version=0.15.2
idna_version=2.8

echo "#-----------------------------------#"
echo "# Installing fixed version packages #"
echo "#-----------------------------------#"

# Installing `pip` in required version 
#
present=`pip list | grep pip | sed -E 's/^pip\ *//' | sed -E 's/\ //g'`
if [ "$present" != "$pip_version" ]; then
	echo "Found pip in version '$present' vs. needed '$pip_version' "
	pip install pip==$pip_version --user
else
	echo "   found pip in version in required version $present"
fi

# Installing `docutils` 
#
present=`pip list | grep docutils | sed -E 's/^docutils\ *//' | sed -E 's/\ //g'`
if [ "$present" != "$docutils_version" ]; then
	echo "Found docutils in version '$present' vs. needed '$idna_version' "
	pip install docutils==$docutils_version --user
else
	echo "   found docutils in version in required version $present"
fi

# Installing `idna` 
#
present=`pip list | grep idna | sed -E 's/^idna\ *//' | sed -E 's/\ //g'`
if [ "$present" != "$idna_version" ]; then
	echo "Found idna in version '$present' vs. needed '$idna_version' "
	pip install idna==$idna_version --user
else
	echo "   found idna in version in required version $present"
fi

echo "#------------------------------------#"
echo "# Installing latest version packages #"
echo "#------------------------------------#"


# Installing `requests` package
#
present=`pip list | grep requests | sed 's/^requests\ *//'`
if test ! $(echo $present); then
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
if test ! $(echo $present); then
	pip install lxml --user
else
	echo "   found lxml in version $present"
fi

# Installing `tornado` package
#
present=`pip list | grep tornado | sed 's/^tornado\ *//'`
if test ! $(echo $present); then
	pip install tornado --user
else
	echo "   found tornado in version $present"
fi

# Installing `nose` package
#
present=`pip list | grep nose | sed 's/^nose\ *//'`
if test ! $(echo $present); then
	pip install nose --user
else
	echo "   found nose in version $present"
fi

# Installing `botocore` package
#
present=`pip list | pcregrep '^botocore ' | sed 's/^botocore\ *//'  | sed 's/\n*//'`
if test ! $(echo $present)
then
	pip install botocore --user
else
	echo "   found botocore in version $present"
fi

# Installing `boto` package
#
present=`pip list | pcregrep '^boto '| sed 's/^boto\ *//'  | sed 's/\n*//'`
if test ! $(echo $present)
then
	pip install boto --user
else
	echo "   found boto in version $present"
fi

# Installing `boto3` package
#
present=`pip list | pcregrep '^boto3 ' | sed 's/^boto3\ *//' | sed 's/\n*//'`
if test ! $(echo $present)
then
	pip install boto3 --user
else
	echo "   found boto3 in version $present"
fi

echo
echo "#----------------------------------------#"
echo "#     Upgraded python packages           #"
echo "#     Kept         pip at $pip_version         #"
echo "#     Kept    docutils at $docutils_version         #"
echo "#     Kept        idna at $idna_version            #"
echo "#     Please check periodically if we    #"
echo "#     can update these packages          #"
echo "#----------------------------------------#"
echo " "
echo " "

pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | pcregrep -v "$exclude_pattern" | xargs -n1 pip install -U --user

echo " "
echo " "
echo "#----------------------------------------#"
echo "#     Ugrade of Pyton finished.          #"
echo "#     All packages should now be         #"
echo "#     current. Please check any          #"
echo "#     potential error messages.          #"
echo "#----------------------------------------#"
echo

echo
echo "#----------------------------------------#"
echo "#     Upgrading all python packages      #"
echo "#     Keeping      pip at $pip_version         #"
echo "#     Keeping docutils at $docutils_version         #"
echo "#     Keeping     idna at $idna_version            #"
echo "#     Please check periodically if we    #"
echo "#     can update these packages          #"
echo "#     eclude pattern was                 #"
echo "#     $exclude_pattern "
echo "#   See updatable python packages below  #"
echo "#----------------------------------------#"
echo " "
echo " "
pip list --outdated --format=columns
echo " "
echo " "

