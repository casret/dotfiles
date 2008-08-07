cdpath=(. .. ~)

umask 022

# set up aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias g='git'
alias vless='/usr/share/vim/vim71/macros/less.sh'

alias j=jobs
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history
alias grep='egrep --color'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias cvs='cvs -q'
alias nsi='netstat -A inet'
alias vless='/usr/share/vim/vim71/macros/less.sh'

# list only directories and symbolic
# links that point to directories
alias lsd='ls -T 0 -ld *(-/)'

# list only file beginning with "."
alias lsa='ls -T 0 -ld .*'

# where to look for autoloaded function definitions
fpath=(~/.zfuns $fpath)


# global aliases
alias -g G='| grep' 
alias -g M='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g 7S='/usr/local/giao/src/p4'


# filename suffixes to ignore during completion
fignore=(.o .c~ .old .pro .class .arch-ids)

# Lets set up the necessary colors that we will use elsewhere.
#grey="%{$(echo -n '\e[1;30m')%}"
#red="%{$(echo -n '\e[1;31m')%}"
#green="%{$(echo -n '\e[1;32m')%}"
#yellow="%{$(echo -n '\e[1;33m')%}"
#blue="%{$(echo -n '\e[1;34m')%}"
#magenta="%{$(echo -n '\e[1;35m')%}"
#cyan="%{$(echo -n '\e[1;36m')%}"
#white="%{$(echo -n '\e[1;37m')%}"
#black="%{$(echo -n '\e[0;30m')%}"
#lored="%{$(echo -n '\e[0;31m')%}"
#logreen="%{$(echo -n '\e[0;32m')%}"
#loyellow="%{$(echo -n '\e[0;33m')%}"
#loblue="%{$(echo -n '\e[0;34m')%}"
#lomagenta="%{$(echo -n '\e[0;35m')%}"
#locyan="%{$(echo -n '\e[0;36m')%}"
#lowhite="%{$(echo -n '\e[0;37m')%}"
#

#PROMPT="%{yellow}%2m$magenta:$blue%l$red%#"
#RPROMPT=" $green%~$white"

# set prompts
#PROMPT='%m%# '    # default prompt
#RPROMPT=' %~'     # prompt for right side of screen

MAILCHECK=300
DIRSTACKSIZE=20

# watch for my friends
#watch=($(cat ~/.friends))      # watch for people in .friends file
watch=(notme)                   # watch for everybody but me
LOGCHECK=300                    # check every 5 min for login/logout activity
WATCHFMT='%n %a %l from %m at %t.'

# set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume  pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
setopt   automenu
unsetopt bgnice autoparamslash noclobber


#PROMPT='%m:%l%#'
stty sane
alias ='clear'
ff() { find / -name "$*" -print }
gr() { fgrep -in "$*" *.c *.h }
umask 022

#prompt
case $TERM in
xterm*)
precmd () {print -Pn "\e]0;%n@%m: %~\a"}
;;
esac

#history
HISTSIZE=1000
SAVEHIST=HISTSIZE
HISTFILE=~/.zsh/history
setopt append_history extended_history hist_ignore_all_dups 
setopt hist_no_store hist_reduce_blanks hist_save_no_dups
setopt inc_append_history

#up and down arrow
bindkey '[A' up-line-or-history
bindkey '[B' down-line-or-history
bindkey '[D' backward-char
bindkey '[C' forward-char

autoload -U promptinit
promptinit

prompt giao

# The following lines were added by compinstall

zstyle :compinstall filename '/home/casret/.zshrc'
[[ -z $fpath[(r)$_compdir] ]] && fpath=($fpath $_compdir)

autoload -U compinit
compinit
# End of lines added by compinstall

_rake_does_task_list_need_generating () {
  if [ ! -f .rake_tasks ]; then return 0;
  else
    accurate=$(stat -c%Z .rake_tasks)
    changed=$(stat -c%Z Rakefile)
    return $(expr $accurate '>=' $changed)
  fi
}

_rake () {
  if [ -f Rakefile ]; then
    if _rake_does_task_list_need_generating; then
      echo "\nGenerating .rake_tasks..." > /dev/stderr
      rake --silent --tasks | cut -d " " -f 2 > .rake_tasks
    fi
    compadd `cat .rake_tasks`
  fi
}

compdef _rake rake

export PYTHONPATH=/home/casret/lib/python:$PYTHONPATH
eval `keychain --eval`

###########################################
#   iTerm Tab and Title Customization     #
###########################################

  # Put the penultimate and current directory in the iterm tab:

    function settab { echo -ne "\e]1;$PWD:h:t/$PWD:t\a" }

  # Put the string " [zsh]   hostname::/full/directory/path" in the title bar:

    function settitle { echo -ne "\e]2;[zsh]   $HOST:r:r::$PWD\a" }

  # This updates after each change of directory:
    function chpwd { settab;settitle }

