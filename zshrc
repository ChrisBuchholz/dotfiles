unsetopt nomatch

export LANG="da_DK.UTF-8"
export LC_ALL="da_DK.UTF-8"
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export VISUAL=vim
export EDITOR=vim
export GPGKEY=7EA01D78
export GREP_OPTIONS='--color=auto'

# terminal fix to bring back git completion
#zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash

#hash brew 2>/dev/null && . `brew --prefix`/etc/profile.d/z.sh


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


# terminal colors
listColors() {
    for i in {0..255} ; do
        printf "\x1b[38;5;${i}mcolour${i}\n"
    done
}

vactivate() {
    if [ -f "$PWD/bin/activate" ]; then
        source "$PWD/bin/activate"
    elif [ -f "$PWD/venv/bin/activate" ]; then
        source "$PWD/venv/bin/activate"
    elif [ -f "$PWD/env/bin/activate" ]; then
        source "$PWD/env/bin/activate"
    else
        echo "No virtual environment to activate in $PWD"
    fi
}


function lsdirs () {
    for key in ${(k)NAMED_DIRS}
    do
        printf "%-10s %s\n" $key  ${NAMED_DIRS[$key]}
    done
}


function MKVToMP4 () {
    ffmpeg -i $1 -vcodec copy -acodec copy $2
}


function webserver () {
    PORT=$1
    if [ -z "$1" ]; then
        PORT=8080
    fi

    python -m SimpleHTTPServer $1
}


function airplay() {
    IP=$2
    if [ -z "$2" ]; then
        IP="192.168.0.17"
    fi
    airstream $1 -o $IP
}


# open all files in git repo that are not staged, committed or ignored
function gim() {
    CMD='git ls-files --other --exclude-standard -m'
    if eval $CMD; then
        vim `eval $CMD` -O
    fi
}



# Aliases ---------------------------------------------------------------------


alias sshtnnl='ssh -D 8080 -f -C -q -N -p 443' # ssh tunnel on port 8080
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias flush="dscacheutil -flushcache"
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias phpserver="php -S localhost:3000"
alias tmux='tmux -2'
alias ltop='top -F -R -o cpu'
hash mvim 2>/dev/null && alias vim='mvim -v' # alias vim to terminal mvim if mvim exists
alias c='clear'


# Named directories -----------------------------------------------------------


typeset -A NAMED_DIRS

NAMED_DIRS=(
    webapi      ~/OC/Projekter/ocmg-webapi/ocmg-webapi
    ocid        ~/OC/Projekter/ocid/ocid
    flaskocid   ~/OC/Projekter/Flask-ocid
    occommon    ~/OC/Projekter/ocmg-py3-common
    projekter   ~/Projekter
)

for key in ${(k)NAMED_DIRS}
do
    if [[ -d ${NAMED_DIRS[$key]} ]]; then
        export $key=${NAMED_DIRS[$key]}
    else
        unset "NAMED_DIRS[$key]"
    fi
done


# Antigen ---------------------------------------------------------------------


source ~/.dotfiles/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

# Load the theme.
antigen theme steeef


# Host specifics --------------------------------------------------------------


UNAME=`uname`
if [ "$UNAME" = "Linux" ]; then
    # linux
    source ~/.zshrc-linux
elif [ "$UNAME" = "Darwin" ]; then
    # Max OS X (Darwin)
    source ~/.zshrc-osx
fi


# Secrets ---------------------------------------------------------------------


SECRETS=~/.zshrc-secrets
if [ -f $SECRETS ]; then
    source $SECRETS
fi


# Now that host specific configs have been sourced; apply! --------------------


antigen apply
