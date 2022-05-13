#!/bin/bash

#This script will work on MacOS only
#This script checks if an app exists & if it meets a certain version

#NOTE 1: replace the <application> with actual app app_name
#NOTE 2: replace <version> with the desired version to check against

#create a var which contains path to the app
app_name="/Applications/<application>.app"

#check if app exists
if [ -e "$app_name" ] ; then
  app_version=$(defaults read /Applications/Docker.app/Contents/Info.plist CFBundleShortVersionString) #check app version & store it to a var
  function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }
  if [ $(version $app_version) -ge $(version "<version>") ]; then #compare the current app version with the desired app app version
    echo "<application> app version <version> or higher is already installed on this machine"
    exit 0 #done with no change
  else
    echo "An outdated <application> app is installed on this machine"
    exit 0
  fi
else
  echo "<application> app is not installed on this machine"
  exit 0
fi

exit 0
