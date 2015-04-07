export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/Gophings/bin:$PATH
export PATH=$HOME/.gem/ruby/*/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/Library/Haskell/bin:$PATH
export PATH=$(brew --prefix)/lib/pythonX.Y/site-packages:$PATH
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin
export GOPATH=$HOME/Gophings:$GOPATH
export GOBIN=$HOME/Gophings/bin
export MANPATH=$HOMEBREWDIR/share/man:$MANPATH
export MANPATH=$HOMEBREWDIR/share/man:$MANPATH

export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/cb/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

export VISUAL=vim
export EDITOR=vim
export LANG="da_DK.UTF-8"
export LC_ALL="da_DK.UTF-8"
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export GPGKEY=7EA01D78
export GREP_OPTIONS='--color=auto'
export TERM=xterm-256color
export RI="--format ansi --width 70"

# Add GHC 7.8.3 to the PATH, via http://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.8.3.app"
if [ -d "$GHC_DOT_APP" ]; then
    export PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000


#### ----  functions ---- ####


# remove XCode derived data
dxdd() {
    #Save the starting dir
    startingDir=$PWD

    #Go to the derivedData
    cd ~/Library/Developer/Xcode/DerivedData

    #Sometimes, 1 file remains, so loop until no files remain
    numRemainingFiles=1
    while [ $numRemainingFiles -gt 0 ]; do
        #Delete the files, recursively
        rm -rf *

        #Update file count
        numRemainingFiles=`ls | wc -l`
    done

    echo Done

    #Go back to starting dir
    cd $startingDir
}

fixxcode () {
    rm -frd ~/Library/Developer/Xcode/DerivedData/*
    rm -frd ~/Library/Caches/com.apple.dt.Xcode/*
}

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

# terminal colors
listColors() {
    for i in {0..255} ; do
        printf "\x1b[38;5;${i}mcolour${i}\n"
    done
}

# create tags file with ctags
maketags() {
    ctags -f .tags -R *
}

makehaskelltags() {
    hasktags -c -o .tags .
}

# open man pages in Preview.app
pman () {
    man -t $1 | open -f -a /Applications/Preview.app
}

rmount () {
    #
    # requires osxfuse, sshfs and ssh-copy-id and that you have keyless
    # ssh login set up between you and the remote
    #
    # usage:
    #   rmount 99.99.99.99 /some/path
    #
    # if you leave out the path it defaults to ./ (home folder)
    #
    REMOTE_HOST=$1
    REMOTE_PATH=$2
    MOUNT_PATH=/Volumes/$REMOTE_HOST
    if [ -z "$2" ]; then
        REMOTE_PATH=./
    fi
    [ -d $MOUNT_PATH ] || mkdir $MOUNT_PATH
    sshfs -o reconnect -o volname=$REMOTE_HOST -o IdentityFile=~/.ssh/id_rsa $REMOTE_HOST:$REMOTE_PATH $MOUNT_PATH && open $MOUNT_PATH
}


#### aliases


alias sshtnnl='ssh -D 8080 -f -C -q -N -p 443' # ssh tunnel on port 8080
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias flush="dscacheutil -flushcache"
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias webserver="python -m SimpleHTTPServer 3000"
alias phpserver="php -S localhost:3000"
alias tmux='tmux -2'
alias ltop='top -F -R -o cpu'
alias ql='qlmanage -p 2>/dev/null' # quicklook
alias brewup='brew update && brew upgrade'
hash mvim 2>/dev/null && alias vim='mvim -v' # alias vim to terminal mvim if mvim exists
alias ..='cd ..'
alias c='clear'


### bindings


# Up Arrow: search and complete from previous history
bind '"\eOA": history-search-backward'
# Down Arrow: search and complete from next history
bind '"\eOB": history-search-forward'


### styling


. ~/.bash_prompt

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
