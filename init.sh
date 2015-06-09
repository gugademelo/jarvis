#!/bin/bash

#colors
GREEN="\e[38;5;046m"
RESET_COLOR="\e[0m"
LIGHT_BLUE="\e[38;5;033m"

init() {
	echo -e "${GREEN}Hello, I'm starting..."
}

dotfiles() {
  for file in `ls files`; do
    cp files/${file} ~/.${file}
  done
}

end() {
  echo -e "${GREEN}Done!${RESET_COLOR}"
  echo -e "-------------------------------------\n"
}

linking() {
  if [ `uname` == 'Linux' ]; then
    ENTRY='source ~/.bash_profile'
    FILE=~/.bashrc
    RESULT=$(grep "${ENTRY}" $FILE)

    [ "$RESULT" == '' ] && echo $ENTRY >> $FILE
  fi
}

reload() {
  . ~/.bash_profile
}

###################
# --- Install --- #
###################

init

dotfiles
linking
reload

#end