#!/bin/bash
# set -x
echo "Recovering up BetterTouchTool preferences"
bd="`dirname \"$0\"`"              # relative
bd="`( cd \"$bd\" && pwd )`"  # absolutized and normalized
if [ -z "$bd" ] ; then
  echo "Could not access the current directory '$bd'";
  exit 1  # fail
fi


bdasd=$bd'/Application Support/BetterTouchTool'
btasd=$HOME'/Library/Application Support/BetterTouchTool'
btpf=$HOME'/Library/Preferences/com.hegenberg.BetterTouchTool.plist'

cp -a "$bd/Preferences/com.hegenberg.BetterTouchTool.plist" $btpf

if [[ -L "$btasd" && -d "$btasd" ]]
then
    echo "Finished recovering up of BetterTouchTool preferences"
    exit 0
fi
rm -rf "$btasd"
echo "linking '$btasd' -> '$bdasd'"
ln -s "$bdasd" "$btasd"
echo "Finished recovering of BetterTouchTool preferences"
exit 0
