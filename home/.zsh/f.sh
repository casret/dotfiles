# This tool gives you quick access to your frequent/recent files
#
# INSTALL:
#   Source this file somewhere in your shell rc (.bashrc or .zshrc).
#
# SYNOPSIS:
#   _f [options] [query ...]
#     options:
#       -s        show list of files with their ranks
#       -l        list paths only
#       -e <cmd>  set command to execute on the result file
#       -a        match files and directories
#       -d        match directories only
#       -f        match files only
#       -r        match by rank only
#       -h        show a brief help message
#
# EXAMPLES:
#   f foo # list recent files mathcing foo
#   f foo bar # list recent files mathcing foo and bar
#   f -e vim foo # run vim on the most frecent file matching foo
#
# TIPS:
#   alias z="f -d -e cd"
#   alias v="f -e vim"
#   alias m="f -e mplayer"
#   alias o="f -e xdg-open"

_f() {

  if [ "$1" = "--add" ]; then # add entries
    shift

    # stop if we don't own ~/.f (we're another user but our ENV is still set)
    [ -f "$_F_DATA" -a ! -O "$_F_DATA" ] && return

    # blacklists
    local each
    for each in "${_F_BLACKLIST[@]}"; do
      [[ "$*" =~ "$each" ]] && return
    done

    # shifts
    for each in "${_F_SHIFT[@]}"; do
      while [ "$1" = "$each" ]; do shift; done
    done

    # ignores
    for each in "$_F_IGNORE[@]"; do
      [ "$1" = "$each" ] && return
    done

    shift # shift out the command itself

    local paths
    while [ "$1" ]; do
      # add the adsolute path to "paths", and a separator "|"
      paths+="$($_F_READLINK -e -- "$1" 2>> "$_F_SINK")|"
      shift
    done

    # add current pwd if the option is set
    [ "$_F_TRACK_PWD" = "1" -a "$(pwd -P)" != "$HOME" ] && paths+="$(pwd -P)"

    [ -z "${paths//|/}" ] && return # stop if we have nothing to add

    # maintain the file
    local tempfile
    tempfile="$(mktemp $_F_DATA.XXXXXX)" || return
    $_F_AWK -v list="$paths" -v now="$(date +%s)" -v max="$_F_MAX" -F"|" '
      BEGIN {
        split(list, files, "|")
        for(i in files) {
          path = files[i]
          if ( path == "" ) continue
          paths[path] = path # array for checking
          rank[path] = 1
          time[path] = now
        }
      }
      $2 >= 1 {
        if( $1 in paths ) {
          rank[$1] = $2 + 1
          time[$1] = now
        } else {
          rank[$1] = $2
          time[$1] = $3
        }
        count += $2
      }
      END {
        if( count > max )
          for( i in rank ) print i "|" 0.9*rank[i] "|" time[i] # aging
        else
          for( i in rank ) print i "|" rank[i] "|" time[i]
      }' "$_F_DATA" 2>> "$_F_SINK" >| "$tempfile"
    if [ $? -ne 0 -a -f "$_F_DATA" ]; then
      env rm -f "$tempfile"
    else
      env mv -f "$tempfile" "$_F_DATA"
    fi

  elif [ "$1" = "--query" ]; then
    # query the database, this need some local variables to be set
    while read line; do
      [ -${typ:-e} "${line%%|*}" ] && echo "$line"
    done < "$_F_DATA" | \
    $_F_AWK -v t="$(date +%s)" -v mode="$mode" -v q="$fnd" -F"|" '
      function frecent(rank, time) {
        dx = t-time
        if( dx < 3600 ) return rank*4
        if( dx < 86400 ) return rank*2
        if( dx < 604800 ) return rank/2
        return rank/4
      }
      function likelihood(pattern, path) {
        m = gsub( "/+", "/", path )
        r = 1
        for( i in pattern ) {
          tmp = path
          gsub( ".*" pattern[i], "", tmp)
          n = gsub( "/+", "/", tmp )
          if( n == m )
            return 0
          else if( n == 0 )
            r *= 20 # F
          else
            r *= 1 - ( n / m )
        }
        return r
      }
      function getRank() {
        if( mode == "rank" )
          f = $2
        else
          f = frecent($2, $3)
        wcase[$1] = f * likelihood( pattern, $1 )
        nocase[$1] = f * likelihood( pattern2, tolower($1) )
      }
      BEGIN {
        split(q, pattern, " ")
        for( i in pattern ) pattern2[i] = tolower(pattern[i]) # nocase
      }
      {
        getRank()
        cx = cx || wcase[$1]
        ncx = ncx || nocase[$1]
      }
      END {
        if( cx ) {
          for( i in wcase )
            if( wcase[i] ) printf "%-10s %s\n", wcase[i], i
        } else if( ncx ) {
          for( i in nocase )
            if( nocase[i] ) printf "%-10s %s\n", nocase[i], i
        }
      }' - 2>> "$_F_SINK"

  else
    # parsing logic and processing
    [ -f "$_F_DATA" ] || return # no db yet
    local fnd last
    while [ "$1" ]; do case "$1" in
      --complete) [ "$2" = "--" ] && shift; set -- $(echo $2); local list=1 r=r;;
      --) while [ "$2" ]; do shift; fnd+="$1 "; last="$1"; done;;
      -*) [ "$ZSH_VERSION" ] && local x='o=${o[2,#o]}' || local x='o=${o:1}'
        local o=${1#-}; while [ "$o" ]; do case $o in
          s*) local show=1;;
          l*) local list=1;;
          r*) local mode=rank;;
          t*) local mode=recent;;
          e*) eval $x; if [ "$o" ]; then # there are characters after "-e"
                local exec=$o # anything after "-e"
              else # use the next argument
                local exec=${2:?"Argument needed after -e"}
                shift
              fi; break;;
          a*) local typ=e;;
          d*) local typ=d;;
          f*) local typ=f;;
          h*) echo "_f [options] [query ...]
  options:
    -s        show list of files with their ranks
    -l        list paths only
    -e <cmd>  set command to execute on the result file
    -a        match files and directories
    -d        match directories only
    -f        match files only
    -r        match by rank only
    -h        show a brief help message" >&2; return;;
          #*) fnd+="$1 "; last="$1"; break;; # unknown option detected
        esac; eval $x; done;;
      *) fnd+="$1 "; last="$1";;
    esac; shift; done

    # if we hit enter on a completion just execute
    case "$last" in
     # completions will always start with /
     /*) [ -z "$show$list" -a -${typ:-e} "$last" -a "$exec" ] \
       && $exec "$last" && return;;
    esac

    local result
    result="$(_f --query 2>> "$_F_SINK")" # query the database
    [ $? -gt 0 ] && return
    if [ "$list" ]; then
      echo "$result" | sort -n${r} | sed 's/^[0-9.]*[ ]*//'
    elif [ "$show" ]; then
      echo "$result" | sort -n${r}
    elif [ "$fnd" -a "$exec" ]; then # exec
      $exec "$(echo "$result" | sort -n | sed -n '$s/^[0-9.]*[ ]*//p')"
    elif [ "$fnd" ] && [ "$ZSH_SUBSHELL$BASH_SUBSHELL" != "0" ]; then # echo
      echo "$result" | sort -n | sed -n '$s/^[0-9.]*[ ]*//p'
    else # no args, show
      echo "$result" | sort -n${r}
    fi

  fi
}

# set default aliases
alias ${_F_CMD_A:=a}='_f -a'
alias ${_F_CMD_S:=s}='_f -s'
alias ${_F_CMD_D:=d}='_f -d'
alias ${_F_CMD_F:=f}='_f -f'

# set default options
[ -z "$_F_DATA" ] && _F_DATA="$HOME/.f"
[ -z "$_F_BLACKLIST" ] && _F_BLACKLIST=(--help)
[ -z "$_F_SHIFT" ] && _F_SHIFT=(sudo busybox)
[ -z "$_F_IGNORE" ] && _F_IGNORE=(_f cd ls echo)
[ -z "$_F_SINK" ] && _F_SINK=/dev/null
[ -z "$_F_TRACK_PWD" ] && _F_TRACK_PWD=1
[ -z "$_F_MAX" ] && _F_MAX=2000
[ -z "$_F_QUERY_SEPARATOR" ] && _F_QUERY_SEPARATOR=,

if [ -z "$_F_AWK" ]; then
  # awk preferences
  for awk in gawk original-awk nawk mawk awk; do
    $awk "" >> "$_F_SINK" 2>&1 && _F_AWK=$awk && break
  done
fi

# readlink setup
if readlink -e / >> "$_F_SINK" 2>&1; then
  _F_READLINK=readlink
elif greadlink -e / >> "$_F_SINK" 2>&1; then
  _F_READLINK=greadlink
else # fall back on emulated readlink
  _f_readlink() {
    # function that mimics readlink from GNU coreutils
    [ "$1" = "-e" ] && shift && local e=1 # existence option
    [ "$1" = "--" ] && shift
    [ "$1" = "/" ] && echo / && return
    [ "$1" = "." ] && echo "$(pwd -P)" && return
    local path
    if [ "${1##*/}" = ".." ]; then
      path="$(cd "$1" >> "$_F_SINK" 2>&1 && pwd -P)"
      [ -z "$path" ] && return 1 # if cd fails
    elif [[ "${1#/}" =~ "/" ]]; then
      # if target contains "/" (not counting top level) or target is ".."
      local base="$(cd "${1%/*}" >> "$_F_SINK" 2>&1 && pwd -P)"
      [ -z "$base" ] && return 1 # if cd fails
      path="${base%/}/${1##*/}"
    elif [ -z "${1##/*}" ]; then # straight top level
      path="$1"
    else # anything within where we are
      path="$(pwd -P)"'/'"$1"
    fi
    [ "$path" = "/" ] && echo / && return
    path=${path%/} # strip off trailing "/"
    [ "$e" = "1" -a ! -e "$path" ] && return
    echo "$path"
  }
  _F_READLINK=_f_readlink
fi

{ # setup zsh/bash hooks and completions
  if compctl; then # zsh
    # zsh command mode completion
    _f_zsh_cmd_complete() {
      local compl
      read -c compl
      compstate[insert]=menu # no expand
      reply=(${(f)"$(_f --complete "$compl")"})
    }

    # enbale command mode completion
    compctl -U -K _f_zsh_cmd_complete -V f -x 'C[-1,-*e],s[-]n[1,e]' -c -- _f

    # zsh word mode completion
    _f_zsh_word_complete() {
      local fnd="${words[CURRENT]//$_F_QUERY_SEPARATOR/ }"
      local typ=${1:-e}
      _f --query | sort -nr | sed 's/^[0-9.]*[ ]*//' | while read line; do
          compadd -U -V f "$line"
        done
        compstate[insert]=menu # no expand
    }
    _f_zsh_word_complete_f() { _f_zsh_word_complete f ; }
    _f_zsh_word_complete_d() { _f_zsh_word_complete d ; }
    _f_zsh_word_complete_trigger() {
      [[ ${words[CURRENT]} == "$_F_QUERY_SEPARATOR"* ]] && _f_zsh_word_complete
    }

    # enable word mode completion
    zstyle ':completion:*' completer _complete _ignored \
      _f_zsh_word_complete_trigger

    # define zle widgets
    zle -C f-complete menu-select _f_zsh_word_complete
    zle -C f-complete-f menu-select _f_zsh_word_complete_f
    zle -C f-complete-d menu-select _f_zsh_word_complete_d

    # add zsh hook
    function _f_preexec () { eval "_f --add $3" 2>&1; }
    autoload -U add-zsh-hook
    add-zsh-hook preexec _f_preexec

  elif complete; then # bash
    # bash command mode completion
    _f_bash_cmd_complete() {
      # complete command after "-e"
      local cur=${COMP_WORDS[COMP_CWORD]}
      [[ ${COMP_WORDS[COMP_CWORD-1]} == -*e ]] && \
        COMPREPLY=( $(compgen -A command $cur) ) && return
      # get completion results using expanded aliases
      local RESULT=$( _f --complete "$(alias -p ${COMP_WORDS} | \
        sed -n "\$s/^.*'\(.*\)'/\1/p") ${COMP_LINE#* }" )
      local IFS=$'\n'
      COMPREPLY=( $RESULT )
    }
    _f_bash_hook_cmd_complete() {
      for cmd in $*; do
        complete -F _f_bash_cmd_complete $cmd
      done
    }

    # enable bash command mode completion
    _f_bash_hook_cmd_complete $_F_CMD_A $_F_CMD_S $_F_CMD_D $_F_CMD_F

    # bash word mode completion
    _f_bash_word_complete() {
      local cur=${COMP_WORDS[COMP_CWORD]}
      if [[ $cur == "$_F_QUERY_SEPARATOR"* ]]; then
        local fnd="${cur//$_F_QUERY_SEPARATOR/ }"
        local RESULT=$(_f --query | sed 's/^[0-9.]*[ ]*//')
        local IFS=$'\n'
        COMPREPLY=( $RESULT )
      fi
    }
    _f_bash_word_complete_wrap() {
      _f_bash_word_complete
      # try original comp func
      [ "$COMPREPLY" ] || eval "$( echo "$_F_BASH_COMPLETE_P" | \
        sed -n "/ ${COMP_WORDS[0]}$/"'s/.*-F \(.*\) .*/\1/p' )"
      # fall back on original complete options
      [ "$COMPREPLY" ] || COMPREPLY=( $(eval "$(echo "$_F_BASH_COMPLETE_P" | \
        sed -n "/ ${COMP_WORDS[0]}$/"'s/complete/compgen/') \
        ${COMP_WORDS[COMP_CWORD]}" ) )
    }
    _f_bash_hook_word_complete_wrap_all() {
      export _F_BASH_COMPLETE_P="$(complete -p)"
      for cmd in $(complete -p | awk '{print $NF}' | tr '\n' ' '); do
        complete -F _f_bash_word_complete_wrap $cmd
      done
    }

    # enable word mode completion as default completion
    complete -D -F _f_bash_word_complete

    # add bash hook
    echo $PROMPT_COMMAND | grep -v -q "_f --add" && \
      PROMPT_COMMAND='eval "_f --add $(history 1 | \
      sed -e "s/^[ ]*[0-9]*[ ]*//")" >> "$_F_SINK" 2>&1;'"$PROMPT_COMMAND"

  fi
} >> "$_F_SINK" 2>&1

