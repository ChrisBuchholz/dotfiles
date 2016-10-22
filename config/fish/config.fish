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
set -x LDFLAGS -L/usr/local/opt/openssl/lib
set -x CPPFLAGS -I/usr/local/opt/openssl/include
set -x PATH $HOME/.cargo/bin $PATH

set -x TERM screen-256color
set -x DISABLE_AUTO_TITLE true

alias vim 'mvim -v' # alias vim to terminal mvim if mvim exists

function mkvtomp4 --description "mkvtomp4 input output"
    ffmpeg -i $argv[1] -vcodec copy -acodec copy $argv[2]
end

function mp4addsrt --description "mp4addsubs input.mp4 output.mp4 input.srt"
    ffmpeg -i $argv[1] -f srt -i $argv[3] -map 0:0 -map 0:1 -map 1:0 \
        -c:v copy -c:a copy -c:s mov_text $argv[2]
end

function avitomp4 --description "avitomp4 input.avi output.mp4"
    ffmpeg -i $argv[1] -c:v libx264 -crf 19 -preset slow -c:a libfaac \
        -b:a 192k -ac 2 $argv[2]
end

function mkcd --description "mkdir and cd into it afterwards"
  mkdir "$argv[1]"
  cd "$argv[1]"
end

[ -e $HOME/.secrets ]; and . $HOME/.secrets

eval (python3.5 -m virtualfish auto_activation global_requirements)

set -x RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src $RUST_SRC_PATCH
