set -e fish_greeting

set -x GOPATH $HOME/Gophings
set -x GOBIN $GOPATH/bin
set -x PATH /usr/local/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $PATH $GOBIN
set -x PATH $HOME/.gem/ruby/*/bin $PATH
set -x PATH (brew --prefix)/lib/python2.7/site-packages $PATH
set -x PATH (brew --prefix)/lib/python3.5/site-packages $PATH
set -x MANPATH $HOMEBREWDIR/share/man $MANPATH
set -x MANPATH $HOMEBREWDIR/share/man $MANPATH
set -x PATH $HOME/.multirust/toolchains/nightly/cargo/bin $PATH
set -x RUST_SRC_PATH $HOME/.local/src/rust/src
#set -x PYTHONPATH /System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python $PYTHONPATH

set -x TERM screen-256color
set -x DISABLE_AUTO_TITLE true

alias vim 'mvim -v' # alias vim to terminal mvim if mvim exists

function mkvtomp4 --description "mkvtomp4 input output"
    ffmpeg -i $argv[1] -vcodec copy -acodec copy $argv[2]
end

function mkcd --description "mkdir and cd into it afterwards"
  mkdir "$argv[1]"
  cd "$argv[1]"
end

[ -e $HOME/.secrets ]; and . $HOME/.secrets

eval (python3.5 -m virtualfish auto_activation global_requirements)
