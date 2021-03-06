export BLUE="\[\033[1;34m\]"
export PURPLE="\[\033[1;35m\]"
export NO_COLOR="\[\e[0m\]"
export GRAY="\[\033[1;31m\]"
export GREEN="\[\033[1;32m\]"
export LIGHT_GRAY="\[\033[1;37m\]"
export LIGHT_GREEN="\[\033[1;32m\]"
export LIGHT_RED="\[\033[1;31m\]"
export RED="\[\033[1;31m\]"
export WHITE="\[\033[1;37m\]"
export YELLOW="\[\033[1;33m\]"

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

finderx() {
  cd $(find $HOME -name $1 2>/dev/null)
}
alias cec=finderx

# Utilities
alias rr='bundle exec rubocop -aD'

alias gp='git push'
alias gpl='git pull'
alias gc='git commit -m'
alias ga='git add .'
alias gst='git status'
alias gb='git branch'
alias gcm='git checkout master'
alias gm='git merge'
alias grm='git rm --cached `git ls-files -i --exclude-from=.gitignore`'
alias gh='git push heroku master'
alias pgst='sudo service postgresql start'
alias pgrt='sudo service postgresql restart'

# Rails commands aliases
alias mig='rake db:drop db:create db:migrate db:seed'
alias et='RAILS_ENV=test'
alias ep='RAILS_ENV=production'
alias ed='RAILS_ENV=development'
alias rss='cd spec/dummy; rails server'
alias rsc='./spec/dummy/bin/rails console'
alias createmig='cd spec/dummy; rails g repense_core:install --force; cd ../..'

alias g='gedit'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f /home/bruno/.travis/travis.sh ] && source /home/bruno/.travis/travis.sh

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"


custom_prompt () {
  local BRANCH=`git branch 2> /dev/null | grep \* | sed 's/* //'`

  if [[ "$BRANCH" = "" ]]; then
    BRANCH=`git status 2> /dev/null | grep "On branch" | sed 's/# On branch //'`
  fi

  #local RUBY_VERSION=`ruby -e "puts RUBY_VERSION"`
  local RAILS_PROMPT=""
  local RUBY_PROMPT=""
  local STATUS=`git status 2>/dev/null`
  local PROMPT_COLOR=$GREEN
  local STATE=" "
  local NOTHING_TO_COMMIT="# Initial commit"
  local BEHIND="# Your branch is behind"
  local AHEAD="# Your branch is ahead"
  local UNTRACKED="# Untracked files"
  local DIVERGED="have diverged"
  local CHANGED="# Changed but not updated"
  local TO_BE_COMMITED="# Changes to be committed"
  local LOG=`git log -1 2> /dev/null`

  if [[ "$RAILS_VERSION" != "" ]]; then
    RAILS_PROMPT="${RAILS_VERSION}@"
  fi

  if [[ "$GEMSET_NAME" != "" ]]; then
    RUBY_PROMPT="${GREEN}[${RAILS_PROMPT}${NO_COLOR} "
  else
    RUBY_PROMPT="${GREEN}[${RAILS_PROMPT}${RUBY_VERSION}]${NO_COLOR} "
  fi

  if [ "$STATUS" != "" ]; then
    if [[ "$STATUS" =~ "$NOTHING_TO_COMMIT" ]]; then
      PROMPT_COLOR=$RED
      STATE=""
    elif [[ "$STATUS" =~ "$DIVERGED" ]]; then
      PROMPT_COLOR=$RED
      STATE="${STATE}${RED}↕${NO_COLOR}"
    elif [[ "$STATUS" =~ "$BEHIND" ]]; then
      PROMPT_COLOR=$RED
      STATE="${STATE}${RED}↓${NO_COLOR}"
    elif [[ "$STATUS" =~ "$AHEAD" ]]; then
      PROMPT_COLOR=$RED
      STATE="${STATE}${RED}↑${NO_COLOR}"
    elif [[ "$STATUS" =~ "$CHANGED" ]]; then
      PROMPT_COLOR=$RED
      STATE=""
    elif [[ "$STATUS" =~ "$TO_BE_COMMITED" ]]; then
      PROMPT_COLOR=$RED
      STATE=""
    else
      PROMPT_COLOR=$GREEN
      STATE=""
    fi

    if [[ "$STATUS" =~ "$UNTRACKED" ]]; then
      STATE="${STATE}${YELLOW}*${NO_COLOR}"
    fi

    PS1="[${GREEN}$USER@$(hostname)${GREEN} ${YELLOW}$(basename $PWD)${YELLOW} ${NO_COLOR}(${PROMPT_COLOR}${BRANCH}${NO_COLOR}${STATE}${NO_COLOR})]${BLUE}$ ${NO_COLOR}" # To remove the big path!
  else
    PS1="[${GREEN}$USER@$(hostname)${GREEN} ${YELLOW}$(basename $PWD)${NO_COLOR}]${BLUE}$ ${NO_COLOR}"
  fi
}

PROMPT_COMMAND=custom_prompt
