#!/bin/bash
#Script to install Docker Desktop app on Apple chip MacBooks.
#This script is only useful with MDM when you have to install the app on multiple devices in one go.

#create a var which contains path to the app
app_name="/Applications/Docker.app"
brew_app_location="/opt/homebrew/bin/docker" #create a var which contains path to the docker install using homebrew

#check if app exists
if [ -e "$brew_app_location" ] ; then
  echo "Docker app exists which was installed using homebrew"
  rm -r /opt/homebrew/Cellar/docker
  rm -r /opt/homebrew/var/homebrew/linked/docker
  rm - rf /opt/homebrew/bin/docker
  echo "Removed docker installed using homebrew"
fi
if [ -e "$app_name" ] ; then
  app_version=$(defaults read /Applications/Docker.app/Contents/Info.plist CFBundleShortVersionString) #check app version & store it to a var
  function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }
  if [ $(version $app_version) -ge $(version "4.4.2") ]; then #compare the current app version with the desired app app version
    echo "Docker desktop app version 4.4.2 or higher is already installed"
    exit 0 #done with no change
  else
    echo "Outdated app exists"
    killall "Docker"
    killall "Docker Desktop"
    rm -rf /Applications/Docker.app #remove the outdated app
    curl 'https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64' -o /tmp/Docker.dmg #download the image file in tmp location
    hdiutil detach /Volumes/Docker
    hdiutil attach /tmp/Docker.dmg #mount the image to Volumes
    /Volumes/Docker/Docker.app/Contents/MacOS/install --accept-license --allowed-org="org_name" #run the installer
    hdiutil detach /Volumes/Docker #unmount the image after installation
    rm -rf /tmp/Docker.dmg #delete the file after installation
    echo "New Docker desktop app successfully installed"
    exit 0
  fi
else
  echo "App does not exist"
  softwareupdate --install-rosetta #install rosetta just to be on safe side
  curl 'https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64' -o /tmp/Docker.dmg #download the image file in tmp location
  hdiutil detach /Volumes/Docker
  hdiutil attach /tmp/Docker.dmg #mount the image to Volumes
  /Volumes/Docker/Docker.app/Contents/MacOS/install --accept-license --allowed-org="org_name" #run the installer
  hdiutil detach /Volumes/Docker #unmount the image after installation
  rm -rf /tmp/Docker.dmg #delete the file after installation
  echo "Docker Desktop app is successfully installed"
  exit 0
fi
#done
exit 0
