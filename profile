#### linux specific settings
if [ `uname` == 'Linux' ]; then
    # If not running interactively, don't do anything
    [ -z "$PS1" ] && return
    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize
    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi
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
    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi

#### linux specific exports

    export PATH=~/.local/bin:$PATH
    # set up virtualenvwrapper
    WORKON_HOME=$HOME/.virtualenvs
    VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
    VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
    source /usr/bin/virtualenvwrapper.sh

#### linux specific aliases

    # enable pacman-color
    alias sudo='sudo '
    alias pacman='pacman-color'
    # enable color support of ls,grep and stuff, and also add handy aliases
    alias ls='ls --color=auto'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

#### Mac OS X (Darwin) specific settings
elif [ `uname` == 'Darwin' ]; then

    [ -z "$PS1" ] && return

#### run tmux on start if not in tmux already

#    if [ -z "$TMUX" ]; then
#        tmux
#    fi

#### Mac OS X (Darwin) specific exports

    export PS1='[\u@\h \W]\$ '
    export PATH=/usr/local/sbin:/usr/local/bin:/usr/local/share/python:$PATH
    export MANPATH=$HOMEBREWDIR/share/man:$MANPATH
    [[ -e $HOME/.local/bin ]] && export PATH=$HOME/.local/bin:$PATH
    [[ -e $HOME/.gem/ruby/*/bin ]] && export PATH=$HOME/.gem/ruby/*/bin:$PATH
    python_bin=`echo $(brew --cellar python)/*/bin`
    python_man=`echo $(brew --cellar python)/*/man`
    [[ -e $python_bin ]] && export PATH=$python_bin:$PATH
    [[ -e $python_man ]] && export MANPATH=$python_man:$MANPATH
    export VISUAL=mvim
    export LANG="da_DK.UTF-8"
    export LC_ALL="da_DK.UTF-8" 
    export CLICOLOR=1
    export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
    WORKON_HOME=$HOME/.virtualenvs
    virtualenvwrapper_path=/usr/local/share/python/virtualenvwrapper.sh
    [[ -e $virtualenvwrapper_path ]] && source $virtualenvwrapper_path
    export NODE_PATH="/usr/local/lib/node_modules"

#### Mac OS X (Darwin) Specific functions

    # open man pages in Preview.app
    pman () {
        man -t $1 | open -f -a /Applications/Preview.app
    }

#### Mac OS X (Darwin) aliases

    alias mvim="mvim -v"
    alias couchdb_restart='/usr/bin/sudo launchctl stop org.apache.couchdb'
    alias couchdb_start='/usr/bin/sudo launchctl load -w /Library/LaunchDaemons/org.apache.couchdb.plist'
    alias couchdb_stop='/usr/bin/sudo launchctl unload /Library/LaunchDaemons/org.apache.couchdb.plist'
    alias c="tr -d '\n' | pbcopy"
    alias spotoff="sudo mdutil -a -i off"
    alias spoton="sudo mdutil -a -i on"

fi

#### not-operating system specifics from here on out

#### exports

    # don't put duplicate lines in the history. See bash(1) for more options
    # ... or force ignoredups and ignorespace
    HISTCONTROL=ignoredups:ignorespace
    # append to the history file, don't overwrite it
    shopt -s histappend
    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    HISTSIZE=1000
    HISTFILESIZE=2000
    export TERM=xterm-256color
    export EDITOR=vim
    # enable git completion
    source ${HOME}/.git-completion.sh

#### functions

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
    # create a new directory and enter it
    md() {
      mkdir -p "$@" && cd "$@"
    }
    # Test if HTTP compression (RFC 2616 + SDCH) is enabled for a given URL.
    # Send a fake UA string for sites that sniff it instead of using the Accept-Encoding header. (Looking at you, ajax.googleapis.com!)
    httpcompression() {
      encoding="$(curl -LIs -H 'User-Agent: Mozilla/5 Gecko' -H 'Accept-Encoding: gzip,deflate,compress,sdch' "$1" | grep '^Content-Encoding:')" && echo "$1 is encoded using ${encoding#* }" || echo "$1 is not using any encoding"
    }
    # all the dig info
    digga() {
      dig +nocmd "$1" any +multiline +noall +answer
    }

#### aliases

    alias ..="cd .."
    alias ...="cd ../.."
    alias ls="ls -paolgG"
    alias la="ls -Gla"
    alias lsd='ls -l | grep "^d"'
    alias undopush="git push -f origin HEAD^:master"
    alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
    alias localip="ipconfig getifaddr en1"
    alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
    alias flush="dscacheutil -flushcache"
    alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
    alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
    alias server="open http://localhost:8080/ && python -m SimpleHTTPServer 8080"
    alias d="cd ~/Dropbox"
    alias p="cd ~/Projekter"
    alias g="git"
    alias v="vim"
    alias fs="stat -f \"%z bytes\""
    alias rot13='tr a-zA-Z n-za-mN-ZA-M'
    for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do alias "$method"="lwp-request -m '$method'"; done
    alias sshtnnl='ssh -D 8080 -f -C -q -N -p 443' # ssh tunnel on port 8080
                                                   # usage: `sshtnnl username@remoteserver`
    alias schoolprojects='cd ~/Dropbox/Public/www/skole/'

### bindings

# Up Arrow: search and complete from previous history
bind '"\eOA": history-search-backward'
# Down Arrow: search and complete from next history
bind '"\eOB": history-search-forward'

# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}
