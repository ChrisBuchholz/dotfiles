set -e fish_greeting

set -x GOPATH $HOME/Gophings
set -x GOBIN $GOPATH/bin
set -x PATH /usr/local/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $PATH $GOBIN
set -x PATH $HOME/.gem/ruby/*/bin $PATH
set -x PATH /usr/local/lib/python2.7/site-packages $PATH
set -x PATH /usr/local/lib/python3.5/site-packages $PATH
set -x MANPATH /usr/local/share/man $MANPATH
set -x MANPATH /usr/local/share/man $MANPATH
set -x PATH $HOME/.cargo/bin $PATH
set -x TERM screen-256color
set -x DISABLE_AUTO_TITLE true
set -x OPENSSL_INCLUDE_DIR /usr/local/opt/include
set -x OPENSSL_LIB_DIR /usr/local/opt/lib
set -x LDFLAGS -L$OPENSSL_LIB_DIR
set -x CPPFLAGS -I$OPENSSL_INCLUDE_DIR
set -x RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src $RUST_SRC_PATCH
set -x FZF_DEFAULT_COMMAND 'ag --hidden -g ""'

[ -e $HOME/.secrets ]; and . $HOME/.secrets

eval (python3.5 -m virtualfish auto_activation global_requirements)

function mkvtomp4 --description "mkvtomp4 input output"
    # ffmpeg -i $argv[1] -vcodec copy -acodec copy $argv[2]
    ffmpeg -i $argv[1] -c copy -c:s mov_text $argv[2]
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

function installXvim
    sudo xcode-select -s $argv[1]
    set tpath /tmp/(date +"%s")
    mkcd $tpath
    git clone git@github.com:XVimProject/XVim.git
    cd Xvim
    make clean
    make uninstall
    sudo codesign -f -s "iPhone Developer: Christoffer Buchholz (JKYX2Y4VLS)" \
        $argv[1]
    make
    rm -rf $tpath
end

function e 
    set hasPath false

    for arg in $argv
        if begin test -e $arg; or test -d $arg; end 
            set hasPath true
        end
    end

    if [ $hasPath = true ]
        code-insiders $argv
    else
        fzf | read -l result; and code-insiders $argv $result
    end
end