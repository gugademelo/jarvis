#!/bin/sh

#params
VERSION=$1

#globals
ROOT="/usr/local/sublime-text-3"
FOLDER_NAME="sublime_text_3_"
FOLDER_NAME+="$VERSION"
SCRIPT="#!/bin/sh
if [[ \${1} == \"--help\" ]]; then
/usr/local/sublime-text-3/current/sublime_text --help
else
/usr/local/sublime-text-3/current/sublime_text \$@ > /dev/null 2>&1 &
fi"

# colors
DEFAULT="\e[39m"
RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
BLUE="\e[34m"

function createShortcut() {
  echo -e "$BLUE Creating terminal shortcut in /usr/bin/subl"
  echo "${SCRIPT}" > "/usr/bin/subl"
  sudo chmod +x "/usr/bin/subl"
  echo -e "$GREEN Shortcut created, type subl to open $FOLDER_NAME $DEFAULT"
}

function createLink() {
  echo -e "$BLUE Creating symbolic link to $ROOT/$FOLDER_NAME in $ROOT/current $DEFAULT"
  sudo rm -f "$ROOT/current"
  sudo ln -s "$ROOT/$FOLDER_NAME" current
  echo -e "$GREEN Symbolic link creation complete $DEFAULT"

  createShortcut
}

function move() {
  echo -e "$BLUE Renaming $ROOT/sublime_text_3 to $ROOT/$FOLDER_NAME $DEFAULT"
  sudo mv "$ROOT/sublime_text_3" "$ROOT/sublime_text_3_$VERSION"
  echo -e "$GREEN Rename complete $DEFAULT"

  createLink
}

function extract() {
  filename="sublime_text_3_build_"
  filename+="$VERSION"
  filename+="_x64.tar.bz2"
  echo -e "$BLUE Extracting $ROOT/$filename $DEFAULT"
  sudo tar -xf $ROOT/$filename
  echo -e "$GREEN Extract complete $DEFAULT"

  sudo rm -f $ROOT/$filename

  move
}

function download() {
  download_url="http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_"
  download_url+="$VERSION"
  download_url+="_x64.tar.bz2"

  if [ ! -d "$ROOT" ]; then
    echo -e "$BLUE Creating $ROOT folder $DEFAULT"
    sudo mkdir $ROOT
  fi

  echo -e "$BLUE Downloading from $download_url $DEFAULT"
  sudo wget $download_url $ROOT
  echo -e "$GREEN Download complete $DEFAULT"

  extract
}

function checkParams() {
  if [ "$VERSION" != "" ]; then
    download
  else
    echo -e "$YELLOW Usage: ./get_sublime.sh [version]"
    echo -e "$BLUE You can get your version at http://www.sublimetext.com/3 $DEFAULT"
  fi
}

function checkRoot() {
  if [ "$(id -u)" != "0" ]; then
    echo -e "$YELLOW You must be root $DEFAULT"
    exit 1
  else
    checkParams
  fi
}

checkRoot