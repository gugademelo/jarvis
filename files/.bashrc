#ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

#r7 aliasses
alias build_boxes='sudo ~/workspace/box_tools/prepare.sh && ~/workspace/box_tools/build_boxes.sh'

#git helpers
merge_theirs() {
  BRANCH=$1
  git merge --strategy recursive -X theirs $BRANCH
}

#colored ps1
DARK_GREY="\e[38;5;240m"
USER="\u"
LIGHT_GREEN="\e[38;5;120m"
CURRENT_PATH="\w"
DARK_PINK="\e[38;5;197m"
GIT_BRANCH="\$(__git_ps1)"
RESET_COLOR="\[\e[0m\]"
PS1="${DARK_GREY}${USER} ${LIGHT_GREEN}${CURRENT_PATH}${DARK_PINK}${GIT_BRANCH} ${RESET_COLOR}\$ "

#set colors on ls
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi