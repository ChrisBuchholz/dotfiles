[ -z "$PS1" ] && return

export PS1='[\u@\h \W]\$ '

if [ `uname` == 'Darwin' ]; then
    ### PATH
    # put /usr/local/{sbin,bin} first
    export PATH=/usr/local/sbin:/usr/local/bin:$PATH

    # include $HOME/bin if it exists
    [[ -e $HOME/bin ]] && export PATH=$HOME/bin:$PATH

    # find and include homebrew-built python
    python_bin=`echo $(brew --cellar python)/*/bin`
    [[ -e $python_bin ]] && export PATH=$python_bin:$PATH
fi

### set general environmental variables
# Set $TERM for libvte terminals that set $TERM wrong (like gnome-terminal) 
#{ 
#    [ "_$TERM" = "_xterm" ] && type ldd && type grep && type tput && [ -L "/proc/$PPID/exe" ] && { 
#        if ldd /proc/$PPID/exe | grep libvte; then 
#            if [ "`tput -Tgnome-256color colors`" = "256" ]; then 
#                TERM=gnome-256color 
#            elif [ "`tput -Txterm-256color colors`" = "256" ]; then 
#                TERM=xterm-256color 
#            elif tput -T gnome; then 
#                TERM=gnome 
#            fi 
#        fi 
#    } 
#} >/dev/null 2>/dev/null
export TERM=xterm-256color
export EDITOR=vim
export VISUAL=mvim
export LANG="da_DK.UTF-8"
export LC_ALL="da_DK.UTF-8" 
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx


### functions
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

# open man pages in Preview.app
pman () {
    man -t $1 | open -f -a /Applications/Preview.app
}


### aliases
alias ls='ls -Gp'
alias sshtnnl='ssh -D 8080 -f -C -q -N -p 443' # usage: `sshtnnl username@remoteserver`
alias brewup='brew update; brew install `brew outdated`'
