#!/bin/bash
# set -x
echo "Backing up BetterTouchTool preferences"
bd="`dirname \"$0\"`"              # relative
bd="`( cd \"$bd\" && pwd )`"  # absolutized and normalized
if [ -z "$bd" ] ; then
  echo "Could not access the current directory '$bd'";
  exit 1  # fail
fi


bdasd=$bd'/Application Support/BetterTouchTool'
btasd=$HOME'/Library/Application Support/BetterTouchTool'
btpf=$HOME'/Library/Preferences/com.hegenberg.BetterTouchTool.plist'

rsync -ac $btpf "$bd/Preferences/"

if [[ -L "$btasd" && -d "$btasd" ]]
then
    echo "Finished backing up of BetterTouchTool preferences"
    exit 0
fi
echo "Creating copy of 'Application Support' directory"
rsync -ac "$btasd" "$bdasd"
echo "Deleting original directory and creating symlink"
rm -rf "$btasd"
ln -s "$bdasd" "$btasd"
echo "Finished backing up of BetterTouchTool preferences"
exit 0
