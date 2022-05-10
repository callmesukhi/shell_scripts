#!/bin/bash
#script to install Docker on Intel MacBooks

#create a var which contains path to the app
app_name="/Applications/Docker.app"

#check if app exists
if [ -e "$app_name" ] ; then
  app_version=$(defaults read /Applications/Docker.app/Contents/Info.plist CFBundleShortVersionString) #check app version & store it to a var
  if [ app_version -ge 4.4.2 ] ; then #compare the current app version with the desired app app version
    echo "Docker 4.4.2 or higher exists"
    exit 0 #done with no change
  else
    rm -rf /Applications/Docker.app #remove the outdated app
    curl 'https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64' -o /tmp/Docker.dmg #download the image file in tmp location
    hdiutil attach /tmp/Docker.dmg #mount the image to Volumes
    /Volumes/Docker/Docker.app/Contents/MacOS/install #run the installer
    hdiutil detach /Volumes/Docker #unmount the image after installation
    rm -rf /tmp/Docker.dmg #delete the file after installation
    exit 0
  fi
else
  curl 'https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64' -o /tmp/Docker.dmg #download the image file in tmp location
  hdiutil attach /tmp/Docker.dmg #mount the image to Volumes
  /Volumes/Docker/Docker.app/Contents/MacOS/install #run the installer
  hdiutil detach /Volumes/Docker #unmount the image after installation
  rm -rf /tmp/Docker.dmg #delete the file after installation
  exit 0
fi

#done
exit 0
