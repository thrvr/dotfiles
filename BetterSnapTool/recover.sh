#!/bin/bash
# set -x
echo "Recovering up BetterSnapTool preferences"
bd="`dirname \"$0\"`"         # relative
bd="`( cd \"$bd\" && pwd )`"  # absolutized and normalized
if [ -z "$bd" ] ; then
  echo "Could not access the current directory '$bd'";
  exit 1  # fail
fi


bdasd=$bd'/Application Support/BetterSnapTool'
btasd=$HOME'/Library/Application Support/BetterSnapTool'
btpf=$HOME'/Library/Preferences/com.hegenberg.BetterSnapTool.plist'

cp -a "$bd/Preferences/com.hegenberg.BetterSnapTool.plist" $btpf

if [[ -L "$btasd" && -d "$btasd" ]]
then
    echo "Finished recovering up of BetterSnapTool preferences"
    exit 0
fi
rm -rf "$btasd"
echo "linking '$btasd' -> '$bdasd'"
ln -s "$bdasd" "$btasd"
echo "Finished recovering of BetterSnapTool preferences"
exit 0
