set -x GOPATH $HOME/Gophings
set -x PATH /usr/local/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/.gem/ruby/*/bin $PATH
set -x PATH $HOME/.rvm/gems/*/bin $PATH
set -x PATH $HOME/.cabal/bin $PATH
set -x PATH $HOME/Library/Haskell/bin $PATH
set -x PATH (brew --prefix)/lib/python2.7/site-packages $PATH
set -x PATH (brew --prefix)/lib/python3.4/site-packages $PATH
set -x PATH $PATH $GOPATH/bin
set -x MANPATH $HOMEBREWDIR/share/man $MANPATH
set -x MANPATH $HOMEBREWDIR/share/man $MANPATH

set -x TERM screen-256color
set -x DISABLE_AUTO_TITLE true

rvm default

alias vim 'mvim -v' # alias vim to terminal mvim if mvim exists

function mkvtomp4 --description "mkvtomp4 input output"
    ffmpeg -i $argv[1] -vcodec copy -acodec copy $argv[2]
end
