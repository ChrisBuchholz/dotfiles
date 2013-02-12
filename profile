export PATH=~/.local/bin:$PATH

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

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
export VISUAL=vim

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

### bindings

# Up Arrow: search and complete from previous history
bind '"\eOA": history-search-backward'
# Down Arrow: search and complete from next history
bind '"\eOB": history-search-forward'
