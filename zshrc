export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="blinks"
export OH_MY_ZSH_DEBUG="true"
export DISABLE_AUTO_TITLE=true
export TERM=screen-256color
export EDITOR=vim
export GPGKEY=7EA01D78
export GREP_OPTIONS='--color=auto'

unsetopt nomatch

# terminal fix to bring back git completion
zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash

hash brew 2>/dev/null && . `brew --prefix`/etc/profile.d/z.sh


# Function --------------------------------------------------------------------


# easy extraction
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

# creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# Test if HTTP compression (RFC 2616 + SDCH) is enabled for a given URL.
# Send a fake UA string for sites that sniff it instead of using the Accept-Encoding header. (Looking at you, ajax.googleapis.com!)
httpcompression() {
  encoding="$(curl -LIs -H 'User-Agent: Mozilla/5 Gecko' -H 'Accept-Encoding: gzip,deflate,compress,sdch' "$1" | grep '^Content-Encoding:')" && echo "$1 is encoded using ${encoding#* }" || echo "$1 is not using any encoding"
}

# all the dig info
digga() {
  dig +nocmd "$1" any +multiline +noall +answer
}

# make and cd into directory
mcd() {
    if [ ! -n "$1" ]; then
        echo "enter the name of the directory that is to be created and then entered"
    elif [ -d "$1" ]; then
        echo "$1 already exists"
    else
        mkdir $1 && cd $1
    fi
}

# simpler find
search() {
    find . -name "$1" -exec grep -li "$2" {} \;
}


# Aliases ---------------------------------------------------------------------


alias sshtnnl='ssh -D 8080 -f -C -q -N -p 443' # ssh tunnel on port 8080
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias flush="dscacheutil -flushcache"
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias server="open http://localhost:8080/ && python -m SimpleHTTPServer 8080"
alias tmux='tmux -2'
alias c='clear'


# Host specifics --------------------------------------------------------------


UNAME=`uname`
if [ "$UNAME" = "Linux" ]; then
    # linux
    source ~/.zshrc-linux
elif [ "$UNAME" = "Darwin" ]; then
    # Max OS X (Darwin)
    source ~/.zshrc-osx
fi


# Oh-My-Zsh -------------------------------------------------------------------


source $ZSH/oh-my-zsh.sh
